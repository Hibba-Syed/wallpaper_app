import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {
  String title;
   CustomAppBar({Key? key,required this.title}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        textAlign: TextAlign.center,
        text:  TextSpan(
          children: [
          TextSpan(
            text:  title,
              style: const TextStyle(color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
          ),
            // TextSpan(
            //     text:  "Hibba",
            //     style: TextStyle(color: Colors.orange)
            // ),
          ]
        ),

      ) ,
    );
  }
}
