import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MyColors.dart';
import '../Utils.dart';
import 'TextWidget.dart';

class CardProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: MyColors.whiteColor,
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: MyColors.blackColor24, width: 1.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/bell.png',
                  scale: 10,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextWidget(
                      input: "Your Profile Summary",
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                      textcolor: MyColors.blueColor)),
              TextWidget(
                  input: ":::",
                  fontsize: 15,
                  fontWeight: FontWeight.bold,
                  textcolor: MyColors.whiteColor)
            ],
          ),
          Divider(
            thickness: 1,
            color: MyColors.blackColor48,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage:
                      NetworkImage(Utils.User_Profile_Pic.toString()),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: TextWidget(
                        input: Utils.USER_First_NAME.toString()+Utils.User_last_name.toString(),
                        fontsize: 18,
                        fontWeight: FontWeight.bold,
                        textcolor: MyColors.navyblue),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: TextWidget(
                        input: Utils.User_Status.toString(),
                        fontsize: 15,
                        fontWeight: FontWeight.normal,
                        textcolor: MyColors.navyblue),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: TextWidget(
                        input: Utils.User_Branch_Name.toString(),
                        fontsize: 15,
                        fontWeight: FontWeight.normal,
                        textcolor: MyColors.navyblue),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextWidget(
                        input:
                            Utils.USER_EMAIL.toString(),
                        fontsize: 15,
                        fontWeight: FontWeight.normal,
                        textcolor: MyColors.navyblue),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: TextWidget(
                        input: Utils.User_Class_Name.toString()+Utils.User_Class_Section.toString(),
                        fontsize: 15,
                        fontWeight: FontWeight.normal,
                        textcolor: MyColors.navyblue),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: TextWidget(
                        input: Utils.User_DOB.toString(),
                        fontsize: 15,
                        fontWeight: FontWeight.normal,
                        textcolor: MyColors.navyblue),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
