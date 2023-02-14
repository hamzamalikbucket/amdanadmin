import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnImg extends StatelessWidget{
  late String title;
  late String ImagePath;
  late Color bgcolour;
  late Color textcolour;
  late ValueChanged<String> value;
  late VoidCallback onPress;


  BtnImg({Key? key, required this.title,required this.bgcolour,required this.textcolour, required this.onPress,required this.ImagePath,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 48,

      child: ElevatedButton(
        onPressed: ()=> onPress(),
       style:ElevatedButton.styleFrom(
         primary: bgcolour,
         onPrimary: bgcolour,
         onSurface: bgcolour,
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10.0),
               side: BorderSide(color: bgcolour, width:2.0))
       ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Image.asset(
              ImagePath,
               scale: 9,


            ),
            Text(
              title,

              style: TextStyle(
                  color: textcolour, fontSize: 16, fontWeight: FontWeight.normal,),
            ),
          ],
        ),
      ),
    );
  }


}