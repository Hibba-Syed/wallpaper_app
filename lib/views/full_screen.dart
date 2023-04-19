import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:open_file/open_file.dart';
class FullScreen extends StatelessWidget {
  String imgUrl;
   FullScreen({super. key,required this.imgUrl});
 final GlobalKey<ScaffoldState> scaffoldkey = new  GlobalKey<ScaffoldState>();

 Future<void> setWallpaperFromFile(String wallpaperUrl, BuildContext context )async{
   ScaffoldMessenger.of(context).
   showSnackBar(const SnackBar(content: Text("Downloading Started...")));
   try{
     // save with this method
     var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
     if ( imageId == null){
       return;
     }
     // Below is a method of obtaining saved image information.
     // var fileName = await ImageDownloader.findName(imageId);
     var path = await ImageDownloader.findPath(imageId);
     // var size = await ImageDownloader.findByteSize(imageId);
     // var mimeType = await ImageDownloader.findMimeType(imageId);
     ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Downloaded Sucessfully"),
       action: SnackBarAction(
           label: "Open",
           onPressed: (){
             OpenFile.open(path);
           }),
     ));
     print("IMAGE DOWNLOADED");
   }on PlatformException catch (error){
     print(error);
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Error Occured - $error")));
   }
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
   key: scaffoldkey,
      floatingActionButton: ElevatedButton(
        onPressed: ()async{
         await setWallpaperFromFile(imgUrl,context);
        },
        child: const Text("Set Wallpaper"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image:NetworkImage(imgUrl),
            fit: BoxFit.cover

          ),
        ),
      ),
    );
  }
}

