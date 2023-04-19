import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/search_screen.dart';
class SearchBar extends StatelessWidget {
   SearchBar({Key? key}) : super(key: key);
var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children:  [
           Expanded(
            child: TextField(
              controller: searchController,
             decoration: const InputDecoration(
               hintText: "Search Wallpapers",
               errorBorder: InputBorder.none,
               focusedBorder: InputBorder.none,
               focusedErrorBorder: InputBorder.none,
               disabledBorder: InputBorder.none,
               enabledBorder: InputBorder.none,
               border: InputBorder.none,
             ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen(query: searchController.text,)));
            },
              child: const Icon(Icons.search)
          ),
        ],
      ),

    );
  }
}
