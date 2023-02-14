import 'package:amdanadmin/Models/EarningModel.dart';
import 'package:amdanadmin/MyColors.dart';
import 'package:amdanadmin/Utils.dart';
import 'package:amdanadmin/widgets/TextWidget.dart';
import 'package:flutter/material.dart';

class EarningListItem extends StatelessWidget{
  EarningModel earningModel;
  EarningListItem({Key? key,required this.earningModel}):super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      child: Card(
        color: MyColors.whiteColor,
        elevation:2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: MyColors.blackColor24, width: 1.0)),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                      input: "Order id:"+ "           "+earningModel.orderid,
                      fontsize: 10,
                      fontWeight: FontWeight.normal,
                      textcolor: MyColors.blackColor8),


                  TextWidget(
                      input: "     ",
                      fontsize: 10,
                      fontWeight: FontWeight.normal,
                      textcolor: MyColors.blackColor8),
                  TextWidget(
                      input: "Earning Id:"+"  "+earningModel.id,
                      fontsize: 10,
                      fontWeight: FontWeight.bold,
                      textcolor: MyColors.blackColor8),

                ],
              ),
              Utils.FORM_HINT_PADDING,
              Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  TextWidget(
                      input: "Reseller Id:"+ "      ",
                      fontsize: 10,
                      fontWeight: FontWeight.normal,
                      textcolor: MyColors.blackColor8),
                  TextWidget(
                      input:earningModel.resellerid,
                      fontsize: 10,
                      fontWeight: FontWeight.bold,
                      textcolor: MyColors.blackColor8),




                ],
              ),
              Utils.FORM_HINT_PADDING,
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [


                  TextWidget(
                      input: "Earning Status:",
                      fontsize: 10,
                      fontWeight: FontWeight.normal,
                      textcolor: MyColors.blackColor8),
                  TextWidget(
                      input: earningModel.status,
                      fontsize: 10,
                      fontWeight: FontWeight.bold,
                      textcolor: MyColors.blackColor8),
                  TextWidget(
                      input: "Earning Amount:",
                      fontsize: 10,
                      fontWeight: FontWeight.normal,
                      textcolor: MyColors.blackColor8),

                  TextWidget(
                      input: earningModel.earningamout,
                      fontsize: 15,
                      fontWeight: FontWeight.bold,
                      textcolor: MyColors.blackColor8),


                ],
              ),
              Divider(
                thickness: 2.0,
                color: MyColors.darkgreenColor,
              ),


            ],
          ),
        ),

      ),
    );
  }

}