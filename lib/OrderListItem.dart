import 'dart:core';
import 'dart:core';

import 'package:amdanadmin/Models/OrderModel.dart';
import 'package:amdanadmin/Models/ProductModel.dart';
import 'package:amdanadmin/MyColors.dart';
import 'package:amdanadmin/Utils.dart';
import 'package:amdanadmin/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class OrderListItem extends StatelessWidget{
  OrderModel orderModel;






  OrderListItem({Key? key,required this.orderModel,}):super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Container(

    child:
    Card(

      color: MyColors.whiteColor,
      elevation:8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: MyColors.blackColor24, width: 2.0)),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Image.asset("assets/images/logo.png",height: 80,width: 80,),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [
                TextWidget(
                    input: "Order id:",
                    fontsize: 10,
                    fontWeight: FontWeight.normal,
                    textcolor: MyColors.blackColor8),
                TextWidget(
                    input: orderModel.OrderId,
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                    textcolor: MyColors.blackColor8),
                TextWidget(
                    input: "Order Price:",
                    fontsize: 10,
                    fontWeight: FontWeight.normal,
                    textcolor: MyColors.blackColor8),
                TextWidget(
                    input: orderModel.Orderprice,
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                    textcolor: MyColors.blackColor8),
                TextWidget(
                    input: "Date:",
                    fontsize: 10,
                    fontWeight: FontWeight.normal,
                    textcolor: MyColors.blackColor8),
                TextWidget(
                    input: orderModel.OrderDate,
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                    textcolor: MyColors.blackColor8),

              ],
            ),
            Utils.FORM_HINT_PADDING,
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [
                TextWidget(
                    input: "Customer name:",
                    fontsize: 10,
                    fontWeight: FontWeight.normal,
                    textcolor: MyColors.blackColor8),
                TextWidget(
                    input: orderModel.CustomerName,
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                    textcolor: MyColors.blackColor8),
                TextWidget(
                    input: "Customer Contact:",
                    fontsize: 10,
                    fontWeight: FontWeight.normal,
                    textcolor: MyColors.blackColor8),
                TextWidget(
                    input: orderModel.CutomerContact,
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                    textcolor: MyColors.blackColor8),

              ],
            ),
            Utils.FORM_HINT_PADDING,
            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [

                TextWidget(
                    input: "Shop Name: ",
                    fontsize: 10,
                    fontWeight: FontWeight.normal,
                    textcolor: MyColors.blackColor8),
                TextWidget(
                    input:orderModel.shopname,
                    fontsize: 10,
                    fontWeight: FontWeight.bold,
                    textcolor: MyColors.blackColor8),

              ],
            ),

            Divider(
              thickness: 2.0,
              color: MyColors.darkgreenColor,
            )
          ],
        ),
      ),

    ),
  );
  }

}