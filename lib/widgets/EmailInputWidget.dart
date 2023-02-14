import 'package:flutter/material.dart';

import '../MyColors.dart';
import 'package:email_validator/email_validator.dart';


class EmailInputWidget extends StatelessWidget {
  String title;
  late Color hintcolour;
  bool isPassword = false;
  bool validate = true;
  TextInputType keyboardType = TextInputType.text;
  ValueChanged<String?> value;
  bool isRequired = false;
  String? error;
  IconData? icon;

  double width;
  TextEditingController? controller;


  EmailInputWidget(
      {Key? key,
        required this.title,
        required this.isRequired,
        required this.keyboardType,
        required this.value,
        required this.width,
        required this.validate,
        required this.isPassword,
        this.controller,
        this.icon,
        this.error,
        required this.hintcolour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      controller:controller,
      cursorColor: MyColors.navyblue,
      showCursor: true,
      obscureText: isPassword,
      style: TextStyle(color:MyColors.blackColor),
      textInputAction: TextInputAction.done,
      keyboardType: keyboardType,

      decoration: new InputDecoration(
        fillColor: MyColors.whiteColor,
          prefixIcon: Icon(
            icon,

            color:MyColors.blackColor24,
          ),


          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: new BorderSide(color: MyColors.blackColor24,)),
          hintText: title,
          alignLabelWithHint: true,
          /*  labelText: title,*/
          hintStyle: TextStyle(color: hintcolour)),
      validator: (value) {
        if (validate || value!.isEmpty) {
          return EmailValidator.validate(value!) ? null : 'Please enter valid ' + title;


        }
      },
      onSaved: value,
    );
  }
}