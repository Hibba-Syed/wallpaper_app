import 'package:flutter/material.dart';
import 'package:wallpaper_app/api_function/api_operation.dart';
import 'package:wallpaper_app/views/full_screen.dart';
import '../widgets/customAppBar.dart';
import 'package:wallpaper_app/model/photos_model.dart';
class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;
   CategoryScreen({Key? key,required this.catName,required this.catImgUrl});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
class _CategoryScreenState extends State<CategoryScreen> {
  late List<photosModel> categoryResults;
   // List<photosModel> categoryResults = [];
  bool isLoading  = true;
  getCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpapers(widget.catName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCatRelWall();
    super.initState();
  }
  late double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  CustomAppBar(title: 'Wallpapers',),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body:  isLoading  ? const Center(child: CircularProgressIndicator(),) : Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * 0.04,),
        child: SingleChildScrollView(
          child: Column(
            children:  [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      height: 150,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        widget.catImgUrl
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    height: 150,
                    width: MediaQuery.of(context).size.width,

                  ),
                  Positioned(
                  left: 120,
                    top: 40,
                    child: Column(
                      children:  [
                        const Text("Category",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                             // fontStyle: FontStyle.italic

                          ),
                        ),
                        Text( widget.catName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                             // fontStyle: FontStyle.italic
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
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
                  itemCount: categoryResults.length,
                  itemBuilder: (context, index) =>GridTile(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>FullScreen(imgUrl: categoryResults[index].imgSrc)));
                      },
                      child: Hero(
                        tag:  categoryResults[index].imgSrc,
                        child: SizedBox(
                          height: 500,
                          width: 50,
                          //  color: Colors.amberAccent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                                height: 500,
                                width: 50,
                                fit: BoxFit.cover,
                                categoryResults[index].imgSrc
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
