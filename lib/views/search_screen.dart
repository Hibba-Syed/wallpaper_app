import 'package:flutter/material.dart';
import 'package:wallpaper_app/api_function/api_operation.dart';
import 'package:wallpaper_app/model/photos_model.dart';
import 'package:wallpaper_app/views/full_screen.dart';
import '../widgets/customAppBar.dart';
import '../widgets/search_bar.dart';
class SearchScreen extends StatefulWidget {
  String query;
   SearchScreen({Key? key,required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
   List<photosModel> searchResults = [];
  getSearchResults() async{
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    getSearchResults();
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
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * 0.04,),
        child: SingleChildScrollView(
          child: Column(
            children:  [
               SearchBar(),
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
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) =>GridTile(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>FullScreen(imgUrl: searchResults[index].imgSrc)));
                      },
                      child: Hero(
                        tag: searchResults[index].imgSrc,
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
                                searchResults[index].imgSrc
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
