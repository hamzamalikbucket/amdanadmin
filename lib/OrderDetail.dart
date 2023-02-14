import 'dart:convert';
import 'dart:math';

import 'package:amdanadmin/Models/OrderModel.dart';
import 'package:amdanadmin/Models/ProductModel.dart';
import 'package:amdanadmin/MyColors.dart';
import 'package:amdanadmin/Utils.dart';
import 'package:amdanadmin/widgets/BtnNullHeightWidth.dart';
import 'package:amdanadmin/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class OrderDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailState();
  }

}
class DetailState extends State<OrderDetail>{
  final GlobalKey<ScaffoldState> ScafoldOrderkey =
  new GlobalKey<ScaffoldState>();
  late OrderModel orderModel;

  String? radiovalue;
  bool radiobutton = false;
  late String pname,pimage,

      productDescription,
      shippingfee,
      productColor,
      productSize,
      productprice,
      quantity,
      shopname;
  late int resellerprofit;
  String baseurl = 'https://api-stg.amdan.pk/api/v1/';

  @override
  void initState() {
    // TODO: implement initState

 /*   setState(() {
      orderModel.orderdetail.forEach((item){
        print(item['id']);
        pname=item['name'];
        pimage=item['imageURL'];
        productDescription=item['desc'];
        shippingfee=item['shippingFee'];
        print(pimage);

      });

    });*/

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    orderModel=ModalRoute.of(context)!.settings.arguments as OrderModel;
    List<dynamic> categoriesList = List<dynamic>.from(orderModel.orderdetail as List);
    print(categoriesList[0]['name']);

    // TODO: implement build
    return Scaffold(
      key: ScafoldOrderkey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
                input: "Details",
                fontsize: 16,
                fontWeight: FontWeight.normal,
                textcolor: MyColors.whiteColor),
          ],
        ),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: MyColors.whiteColor,
                child: Column(
                  children: <Widget>[
                    Container(


                      child: Card(
                        color: MyColors.whiteColor,
                        elevation:8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: MyColors.blackColor24, width: 2.0)),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  input: "Customer Name:"+"  "+orderModel.CustomerName ,
                                  fontsize: 15,
                                  fontWeight: FontWeight.bold,
                                  textcolor: MyColors.blackColor8),
                              Utils.FORM_HINT_PADDING,

                              TextWidget(
                                  input: "Delivery Address:"+"  "+orderModel.CustomerAddress ,
                                  fontsize: 15,
                                  fontWeight: FontWeight.bold,
                                  textcolor: MyColors.blackColor8),
                              Utils.FORM_HINT_PADDING,

                              TextWidget(
                                  input: "Customer Contact:"+"  "+orderModel.CutomerContact ,
                                  fontsize: 15,
                                  fontWeight: FontWeight.bold,
                                  textcolor: MyColors.blackColor8),

                              Utils.FORM_HINT_PADDING,


                            ],
                          ),
                        ),

                      ),
                      width: MediaQuery.of(context).size.width,

                    ),

                   /* Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: Container(
                            width: 412,
                            height: 348,
                            child: Image.network(
                              orderModel.ProductImg,
                            ),
                          ),
                        ),

                      ],
                    ),*/
                    Utils.FORM_HINT_PADDING,
                    Utils.FORM_HINT_PADDING,
                    Flexible(

                      child: ListView.builder(
                        itemCount: categoriesList.length,
                        addRepaintBoundaries: true,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                         categoriesList[index];
                          return Container(
                            child:Card(
                              elevation: 10,
                              child: Column(
                                children: [
                                  Image.network(
                                    categoriesList[0]['imageURL'].toString(),
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                  ),
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                        input: "Product Name:",
                                        fontsize: 18,
                                        fontWeight: FontWeight.bold,
                                        textcolor: MyColors.blackColor8),
                                    TextWidget(
                                        input: categoriesList[0]['name'].toString(),
                                        fontsize: 18,
                                        fontWeight: FontWeight.normal,
                                        textcolor: MyColors.blackColor8),
                                  ],
                                ),
                                Utils.FORM_HINT_PADDING,

                                TextWidget(
                                    input: "Order Price :"+" "+
                                        orderModel.Orderprice,
                                    fontsize: 14,
                                    fontWeight: FontWeight.bold,
                                    textcolor: MyColors.blackColor),
                                Utils.FORM_HINT_PADDING,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                        input: "Order Quantity:",
                                        fontsize: 14,
                                        fontWeight: FontWeight.bold,
                                        textcolor: MyColors.blackColor),
                                    TextWidget(
                                        input: categoriesList[0]['qty'].toString(),
                                        fontsize: 14,
                                        fontWeight: FontWeight.normal,
                                        textcolor: MyColors.blackColor),
                                  ],
                                ),
                                Utils.FORM_HINT_PADDING,
                                Utils.FORM_HINT_PADDING,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                        input: "Shipping Cost:",
                                        fontsize: 14,
                                        fontWeight: FontWeight.bold,
                                        textcolor: MyColors.blackColor),
                                    TextWidget(
                                        input: categoriesList[0]['shippingFee'].toString(),
                                        fontsize: 14,
                                        fontWeight: FontWeight.normal,
                                        textcolor: MyColors.blackColor),
                                  ],
                                ),
                                Utils.FORM_HINT_PADDING,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                        input: "Size:",
                                        fontsize: 14,
                                        fontWeight: FontWeight.bold,
                                        textcolor: MyColors.blackColor),
                                    TextWidget(
                                        input: categoriesList[0]['size'].toString(),
                                        fontsize: 14,
                                        fontWeight: FontWeight.normal,
                                        textcolor: MyColors.blackColor),
                                  ],
                                ),
                                Utils.FORM_HINT_PADDING,
                                Utils.FORM_HINT_PADDING,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                        input: "Description: ",
                                        fontsize: 14,
                                        fontWeight: FontWeight.bold,
                                        textcolor: MyColors.blackColor),
                                    TextWidget(
                                        input: categoriesList[0]['desc'].toString(),
                                        fontsize: 14,
                                        fontWeight: FontWeight.normal,
                                        textcolor: MyColors.blackColor),
                                  ],
                                ),

                                ],




                              ),
                            ) ,



                          );
                        },
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Utils.FORM_HINT_PADDING,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                  input: "Shop Details ",
                                  fontsize: 20,
                                  fontWeight: FontWeight.bold,
                                  textcolor: MyColors.blackColor),

                            ],
                          ),
                          Utils.FORM_HINT_PADDING,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                  input: "Shop Name:",
                                  fontsize: 14,
                                  fontWeight: FontWeight.bold,
                                  textcolor: MyColors.blackColor),
                              TextWidget(
                                  input: orderModel.shopname,
                                  fontsize: 14,
                                  fontWeight: FontWeight.normal,
                                  textcolor: MyColors.blackColor),
                            ],
                          ),
                          Utils.FORM_HINT_PADDING,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                  input: "Address:",
                                  fontsize: 14,
                                  fontWeight: FontWeight.bold,
                                  textcolor: MyColors.blackColor),
                              TextWidget(
                                  input: orderModel.PickupAddress,
                                  fontsize: 14,
                                  fontWeight: FontWeight.normal,
                                  textcolor: MyColors.blackColor),
                            ],
                          ),
                          Utils.FORM_HINT_PADDING,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                  input: "Contact:",
                                  fontsize: 14,
                                  fontWeight: FontWeight.bold,
                                  textcolor: MyColors.blackColor),
                              TextWidget(
                                  input: orderModel.ResellerContact,
                                  fontsize: 14,
                                  fontWeight: FontWeight.normal,
                                  textcolor: MyColors.blackColor),
                            ],
                          ),
                          Utils.FORM_HINT_PADDING,
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 25, right: 25,),
                            child: BtnNullHeightWidth(
                              title: "Change Status",
                              bgcolour: MyColors.darkgreenColor,
                              textcolour: MyColors.whiteColor,
                              onPress: ()
                              {   _onAlertWithCustomContentPressed(
                                  context);

                                //(is_teacher)?Navigator.pushReplacementNamed(context, Constants.signup_page),
                              },
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                            ),
                          ),
                          Utils.FORM_HINT_PADDING,
                        ],
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  _onAlertWithCustomContentPressed(context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      overlayColor: Colors.black87,
      isCloseButton: true,

      titleTextAlign: TextAlign.start,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: MyColors.darkgreenColor),
      descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
    );
    Alert(
        context: context,
        style: alertStyle,
        title: "Select one option",

        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio(

                      value: "Placed",
                      groupValue: radiovalue,
                      activeColor: MyColors.blue_button_colour,
                      onChanged: (value) {
                        setState(() {
                          radiovalue = value.toString();
                          upadteOrder("Placed");
                        });
                      }),
                  TextWidget(
                    input: "Placed",
                    fontsize: 10,
                    fontWeight: FontWeight.normal,
                    textcolor: MyColors.blackColor8,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                    value: "In Process",
                    groupValue: radiovalue,
                    activeColor: MyColors.blue_button_colour,
                    onChanged: (value) {
                      radiovalue = value.toString();
                      setState(() {
                        radiovalue = value.toString();
                        upadteOrder("In Process");
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.only(right: 19.0),
                  child: TextWidget(
                    input: "In Process",
                    fontsize: 10,
                    fontWeight: FontWeight.normal,
                    textcolor: MyColors.blackColor8,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                    value: "Delivered",
                    groupValue: radiovalue,
                    activeColor: MyColors.blue_button_colour,
                    onChanged: (value) {
                      setState(() {
                        radiovalue = value.toString();
                        upadteOrder("Delivered");

                      });
                    }),
                Padding(
                  padding: const EdgeInsets.only(right: 19.0),
                  child: TextWidget(
                    input: "Delivered",
                    fontsize: 10,
                    fontWeight: FontWeight.normal,
                    textcolor: MyColors.blackColor8,
                  ),
                ),
              ],
            ),
          ],
        ),
        buttons: [
          DialogButton(
            child: Text(
              "Proceed",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: MyColors.darkgreenColor,
          )
        ]).show();
  }
  Future<dynamic> upadteOrder(String? status ) async {
    var token = Utils.token;
    var url = Uri.parse(baseurl + 'admin/order/'+orderModel.OrderId);
    var response = await http
        .put(
      url,
      body: {"status": status},
      headers: {
        'Authorization': '$token',
      },
    )
        .timeout(const Duration(seconds: 10),onTimeout: (){

      return errorPopUp(context, "Check your Internet Connection!");
    });

    if (response.statusCode == 200) {
      print(response.body);
      dynamic body = jsonDecode(response.body);
      String message=body['data'];

      Navigator.pop(context);





    } else {

      print(response.body);
      dynamic body = jsonDecode(response.body);
      String error = body['error'];
      print(error);
    }
    ;
  }
  errorPopUp(BuildContext dialogContext, String? error) {

    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
      descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(context: dialogContext, style: alertStyle, title: error, buttons: [
      DialogButton(
        child: Text(
          "Try Again",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          Navigator.pop(dialogContext);
        },
        color: MyColors.redColor,
      )
    ]).show();
  }
}
