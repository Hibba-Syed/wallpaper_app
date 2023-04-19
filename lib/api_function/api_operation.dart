import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/api_function/const.dart';
import 'package:wallpaper_app/model/category_model.dart';
import 'package:wallpaper_app/model/photos_model.dart';
class ApiOperations{
  static List<photosModel>trendingwallpaper = [];
  static List<photosModel>searchWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];
  static Future<List<photosModel>> getTrendingwallpapers()async{
    await http.get(
        Uri.parse("https://api.pexels.com/v1/curated"),
        headers:{ "Authorization" : Constants.apiKey}
    ).then((value){
      Map <String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        trendingwallpaper.add(photosModel.fromApitoApp(element));
        // Map<String, dynamic> src = element["src"];
        // print(src["portrait"]);
      });
      //jsonData('photos')
    });
   return trendingwallpaper;
  }
 static Future<List<photosModel>> searchWallpapers(String query)async{
    await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers:{ "Authorization" : "1SmHqHKWP3cDK0PXzfZddD0575ssniYBhfelPEHW7E3mWzKeCkhznVIH"}
    ).then((value){
      Map <String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      photos.forEach((element) {
        searchWallpapersList.add(photosModel.fromApitoApp(element));
      });
    });
    return  searchWallpapersList;

  }
  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      photosModel photoModel =
      (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}
