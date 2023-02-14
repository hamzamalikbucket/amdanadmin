import 'package:amdanadmin/MyColors.dart';
import 'package:amdanadmin/OrderScreen.dart';
import 'package:amdanadmin/OrderTabs/DeliveredTab.dart';
import 'package:amdanadmin/OrderTabs/PlacedTab.dart';
import 'package:amdanadmin/OrderTabs/InprocessTab.dart';
import 'package:amdanadmin/Utils.dart';
import 'package:amdanadmin/widgets/Toolbar.dart';
import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderState();
  }

}
class OrderState extends State<OrderScreen>{

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarBack(title: "Orders", appBar: AppBar()),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey) )),
                height: 40,
                child: TabBar(
                  labelColor: MyColors.darkgreenColor,
                  unselectedLabelColor: MyColors.blackColor24,


                  tabs: [
                    Text("Placed",style: TextStyle(


                    ),),
                    new Text("In Process",style: TextStyle(

                    ),),
                    new Text("Delivered",style: TextStyle(

                    ),)
                  ],
                ),
              ),
            ),
          ),
          body: new TabBarView(
            children: <Widget>[
              PlacedTab(),
              InProcessTab(),
              DeliveredTab(),


            ],
          ),
        ),
      ),
    );
  }


}