import 'dart:math';

import 'package:amdanadmin/Models/OrderModel.dart';
import 'package:amdanadmin/Models/ProductModel.dart';
import 'package:amdanadmin/MyColors.dart';
import 'package:amdanadmin/OrderDetail.dart';
import 'package:amdanadmin/OrderListItem.dart';
import 'package:amdanadmin/Utils.dart';
import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';


class InProcessTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProgressState();
  }

}
class ProgressState extends State<InProcessTab>{
  List<OrderModel> orderlist = [];
  late ProductModel productModel;
  late BottomLoader bl;
  String baseurl = 'https://api-stg.amdan.pk/api/v1/';
  @override
  void initState() {
    // TODO: implement initState


    bl = new BottomLoader(context,
        isDismissible: true,
        showLogs: true,
        loader: CircularProgressIndicator(
          color: MyColors.darkgreenColor,
        ));
    bl.style(
        message: 'Please Wait...',
        backgroundColor: MyColors.darkgreenColor,
        messageTextStyle: TextStyle(
            color: MyColors.darkgreenColor,
            fontSize: 19.0,
            fontWeight: FontWeight.w600));

    order_function();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: MyColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListView.builder(
              itemCount: orderlist.length,
              addRepaintBoundaries: true,
              scrollDirection:Axis.vertical,
              shrinkWrap: false,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                OrderModel od = orderlist[index];

                return GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetail(),
                          settings: RouteSettings(
                            arguments: od,
                          ),
                        ),);
                    },


                    child: OrderListItem(orderModel: od));
              },
            ),
          ),
        ),
      ),

    );
  }
  Future<dynamic> order_function() async {
    var token = Utils.token;
    var url = Uri.parse(baseurl +
        'admin/order'+'?'+'status'+'='+'In Process');
    var response = await http.get(url, headers: {
      'Authorization': '$token',
    });


    if (response.statusCode == 200) {

      print(response.body);
      dynamic body = jsonDecode(response.body);

      setState(() {
        dynamic notidata = body['data'];
        dynamic list = notidata;
        int id=notidata[0]['id'];


        //print(productModel.pname);

        list.forEach((item) {
          final DateTime docDateTime = DateTime.parse(item['createdAt']);
          String createddate =DateFormat("MM-dd-yyyy, hh:mm a").format(docDateTime);
          String stat= item['status']['status'];
          print(stat);

          orderlist.add(

              OrderModel(
                item['id'].toString(),
                createddate,
                item['status']['status'],
                item['total'],
                item['customer']['name'],
                item['customer']['mobile'],
                item['customer']['address'],
                item['reseller']['mobile'],
                item['reseller']['id'].toString(),
                item['total'],
                item['reseller']['shopName'].toString(),
                item['reseller']['address'].toString(),
                item['items'],
              )


          );




        });








      });
      bl.close();


    } else {
      bl.close();
      print(response.statusCode);
      //confirmationPopup(context);

    }
  }

}