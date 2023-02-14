import 'package:amdanadmin/Models/NotiModel.dart';
import 'package:amdanadmin/Models/SaleModel.dart';
import 'package:amdanadmin/MyColors.dart';
import 'package:amdanadmin/Utils.dart';
import 'package:amdanadmin/widgets/TextWidget.dart';
import 'package:amdanadmin/widgets/ToolbarImage.dart';
import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
class NotificationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotiState();
  }

}
class NotiState extends State<NotificationScreen>{
  List<NotiModel>notilist=[];
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

    noti();
  }
  Future<dynamic> noti() async {
    var token = Utils.token;
    var url = Uri.parse(baseurl +
        'admin/notification/all');
    var response = await http.get(url, headers: {
      'Authorization': '$token',
    });


    if (response.statusCode == 200) {

      print(response.body);
      dynamic body = jsonDecode(response.body);

      setState(() {

        dynamic notidata = body['data'];
        dynamic list = notidata;
        // Factory fact = fact.fromJsom(list[0]);
        list.forEach((item) {
          notilist.add(NotiModel.fromJson(item['data']));



        });
       /* NotiModel fact=NotiModel.fromJson(list['data']);
        //print(">> " + list[0]['data']);
        print(fact.body);*/







      });
      bl.close();


    } else {
      bl.close();
      print(response.statusCode);
      //confirmationPopup(context);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarImage(appBar: AppBar(),),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: MyColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.builder(

                itemCount: notilist.length,
                addRepaintBoundaries: true,
                scrollDirection:Axis.vertical,
                shrinkWrap: false,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  NotiModel notiModel = notilist[index];
                  return GestureDetector(
                    /* onTap: (){
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetail(),
                            settings: RouteSettings(
                              arguments: od,
                            ),
                          ),);
                      },*/


                    child: Container(

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
                                children: [
                                  Image.asset(
                                    'assets/images/notification.png',
                                    color: MyColors.darkgreenColor,
                                    scale: 10,
                                    height: 30,
                                    width: 30,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0,right: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(

                                          children: [
                                            TextWidget(
                                                input: notiModel.title,
                                                fontsize: 10,
                                                fontWeight: FontWeight.normal,
                                                textcolor: MyColors.blackColor8),
                                            TextWidget(
                                                input: notiModel.order_id.toString(),
                                                fontsize: 10,
                                                fontWeight: FontWeight.normal,
                                                textcolor: MyColors.blackColor8),
                                          ],
                                        ),
                                        TextWidget(
                                            input: notiModel.body,
                                            fontsize: 10,
                                            fontWeight: FontWeight.normal,
                                            textcolor: MyColors.darkgreenColor),

                                      ],
                                    ),
                                  ),
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
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),

    );
  }
  Future<void> _pullRefresh() async {
   noti();
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }

}