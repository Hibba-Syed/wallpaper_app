import 'package:flutter/material.dart';
import 'package:wallpaper_app/api_function/api_operation.dart';
import 'package:wallpaper_app/model/category_model.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/views/full_screen.dart';
import '../widgets/category_block.dart';
import '../widgets/customAppBar.dart';
import '../widgets/search_bar.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
 List<photosModel> trendingWallList = [];
  List<CategoryModel> catModList = [];
 getCatDetails() async {
   catModList = await ApiOperations.getCategoriesList();
   // print("GETTING CAT MOD LIST");
   // print(CatModList);
   setState(() {
     catModList = catModList;
   });
 }

 getTrendingWallpapers() async {
   trendingWallList = await ApiOperations.getTrendingwallpapers();
  setState(() {
  });
 }
  @override
  void initState() {
    super.initState();
    ApiOperations.getTrendingwallpapers();
    getTrendingWallpapers();
    getCatDetails();
  }
  late double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title:  CustomAppBar(
          title: 'Awesome Wallpapers',
        ),
            elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * 0.04,),
        child: SingleChildScrollView(
          child: Column(
            children:  [
              SearchBar(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: catModList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) =>CategoryBlock(
                        categoryImgSrc: catModList[index].catImgUrl,
                        categoryName: catModList[index].catName,
                      )),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 350,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: trendingWallList.length,
                    itemBuilder: (context, index) =>GridTile(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (_)=>FullScreen(imgUrl: trendingWallList[index].imgSrc)));
                        },
                        child: Hero(
                          tag: trendingWallList[index].imgSrc,
                          child: Container(
                            height: 500,
                            width: 50,
                          //  color: Colors.amberAccent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                  height: 500,
                                  width: 50,
                                  fit: BoxFit.cover,
                                  trendingWallList[index].imgSrc
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
