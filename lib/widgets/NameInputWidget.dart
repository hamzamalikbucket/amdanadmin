import 'dart:ui';

import 'package:flutter/material.dart';

import '../MyColors.dart';
import 'package:fluttertoast/fluttertoast.dart';


class NameInputWidget extends StatelessWidget {
  String title;
  late Color hintcolour;
  Color? errorcolor;
  bool isPassword = false;


  bool validate = true;
  TextInputType keyboardType = TextInputType.text;
  ValueChanged<String?> value;

  bool isRequired = false;
  String? error;
  TextEditingController? controller;

  double width;
  IconData? icon;


  NameInputWidget(
      {Key? key,
        required this.title,
        required this.isRequired,
        required this.keyboardType,
        required this.value,
        required this.width,
        required this.validate,
        required this.isPassword,
        required this.hintcolour,
        this.error,
        this.errorcolor,
        this.icon,
        this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new TextFormField(

      controller: controller,
      obscureText: isPassword,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,


      decoration: new InputDecoration(
        filled: true,
          fillColor: MyColors.whiteColor,
          labelText: title,



          border: new OutlineInputBorder(

              borderRadius: BorderRadius.circular(10.0),
              borderSide: new BorderSide(color: MyColors.blackColor24,)),
          hintText: title,


          errorStyle: TextStyle(
            color:errorcolor,
          ),

          alignLabelWithHint: true,
          /* labelText: title,*/
          hintStyle: TextStyle(color: hintcolour)),
      validator: (value) {
        if (validate && value!.length<1) {
          return error;



        }
      },
      onSaved: value,

    );
  }
}