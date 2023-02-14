import 'package:amdanadmin/EarningListItem.dart';
import 'package:amdanadmin/EarningsScreen.dart';
import 'package:amdanadmin/Models/EarningModel.dart';
import 'package:amdanadmin/MyColors.dart';
import 'package:amdanadmin/Utils.dart';
import 'package:amdanadmin/widgets/BtnNullHeightWidth.dart';
import 'package:amdanadmin/widgets/TextWidget.dart';
import 'package:amdanadmin/widgets/ToolbarImage.dart';
import 'package:flutter/material.dart';

class EarningsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EarnState();
  }

}
class EarnState extends State<EarningsScreen>{
  List<EarningModel>earnings=[
    EarningModel("1", "2", "3", "1900", "Pending"),
    EarningModel("2", "2", "3", "1900", "Pending"),

  ];
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
            child: ListView.builder(
              itemCount: earnings.length,
              addRepaintBoundaries: true,
              scrollDirection:Axis.vertical,
              shrinkWrap: false,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                EarningModel earningModel = earnings[index];
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
                        BtnNullHeightWidth(
                          title: "Transfer Earning",
                          bgcolour: MyColors.darkgreenColor,
                          textcolour: MyColors.whiteColor,
                          onPress: () {

                          },
                          width: MediaQuery.of(context).size.width,
                          height: 40,
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

    );
  }

}