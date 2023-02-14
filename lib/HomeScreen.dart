import 'package:amdanadmin/Constants.dart';
import 'package:amdanadmin/Models/SaleModel.dart';
import 'package:amdanadmin/MyColors.dart';
import 'package:amdanadmin/Utils.dart';
import 'package:amdanadmin/widgets/AppDrawer.dart';
import 'package:amdanadmin/widgets/SuperadminDrawer.dart';
import 'package:amdanadmin/widgets/TextWidget.dart';
import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _ScafoldHomeKey =
      new GlobalKey<ScaffoldState>();
  SaleModel? saleModel;
  late BottomLoader bl;
  String baseurl = 'https://api-stg.amdan.pk/api/v1/';
  int? orders, resselers,WholeSellerProfit,Customers,avgOrderPrice,grossSale;
  /*double avgOrderPrice = 1.00;
  double grossSale = 1.00;
 */ double totalProfit = 1.00;
  DateTime fromdate = DateTime.now();
  DateTime todate = DateTime.now();

  String? FromFormattedDate,ToFormattedDate;
  TextEditingController FromController = TextEditingController();
  TextEditingController ToController = TextEditingController();
  bool tovalidate = false;
  bool fromvalidate = false;
  filterpopup(BuildContext dialogContext) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
      descStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
        context: dialogContext,
        style: alertStyle,
        title: "Select Date",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextWidget(

                  input: "Select Date From:",
                  fontsize: 16,
                  fontWeight: FontWeight.normal,
                  textcolor: MyColors.blackColor8,
                ),
                Container(
                  width: 100,
                  child: TextField(
                    controller: FromController,
                    onTap: () async{
                      FocusScope.of(context).requestFocus(new FocusNode());
                      await selectfromdate(context);
                      FromController.text = DateFormat('yyyy-MM-dd').format(fromdate);
                    },
                    onChanged: (String value){
                      FromFormattedDate=value;
                    },

                    decoration:InputDecoration(
                      border: InputBorder.none,
                       hintText:fromdate.year.toString()+"-"+fromdate.month.toString()+"-"+fromdate.day.toString(),


                    ),
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  input: "Select To Date:",
                  fontsize: 16,
                  fontWeight: FontWeight.normal,
                  textcolor: MyColors.blackColor8,
                ),
                Container(
                  width: 100,
                  child: TextField(
                    controller: ToController,
                    onTap: () async{
                      FocusScope.of(context).requestFocus(new FocusNode());
                      await selecttodate(context);
                      ToController.text = DateFormat('yyyy-MM-dd').format(todate);
                    },
                    onChanged: (String value){
                      ToFormattedDate=value;
                    },

                    decoration:InputDecoration(
                      border: InputBorder.none,
                      hintText:todate.year.toString()+"-"+todate.month.toString()+"-"+todate.day.toString(),

                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        buttons: [
          DialogButton(
            child: Text(
              "Submit!",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () async{
              if(FromController.text.isNotEmpty && ToController.text.isNotEmpty){
                await datestats();
                FromController.clear();
                ToController.clear();
                Navigator.of(context).pop(true);
              }
              else{
                Navigator.of(context).pop(true);

              }



            },
            color: MyColors.redColor,
          )
        ]).show();
  }


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
    setState(() {
      bl.display();
      stats();
    });
super.initState();



  }


  Future<dynamic> stats() async {
    var token = Utils.token;
    var url = Uri.parse(baseurl +
        'admin/stats');
    var response = await http.get(url, headers: {
      'Authorization': '$token',
    }).timeout(const Duration(seconds: 10),onTimeout: (){
      bl.close();
      return errorPopUp(context, "Check your Internet Connection!");
    }).whenComplete(() => bl.close());
    print(token);
    if (response.statusCode == 200) {
      print(response.body);
      dynamic body = jsonDecode(response.body);

      setState(() {
        orders = body['orders'];
        resselers = body['resellers'];
        WholeSellerProfit = body['wholeSellers'];
        Customers = body['customers'];
        avgOrderPrice = body['avgOrderPrice'];
        grossSale = body['grossSale'];
        totalProfit = body['totalProfit'];
      /*  dynamic saless=body['ordersByDay'];
        print(saless);
        saless.forEach((item){
          saledata.add(SaleModel.fromJson(item));

        });*/
      });


      print(orders);
      print(resselers);
      print(avgOrderPrice);
    } else {

      bl.close();
      print(response.body);
      dynamic body = jsonDecode(response.body);
      String error = body['error'];
      print(error);
      errorPopUp(context, error);
      //confirmationPopup(context);

    }
  }
  Future<dynamic> datestats() async {
    var token = Utils.token;
    var url = Uri.parse(baseurl +
        'admin/stats'+'?'+'dateFrom'+'='+FromFormattedDate!+'&'+'dateTo'+'='+ToFormattedDate!);
    var response = await http.get(url, headers: {
      'Authorization': '$token',
    });
    print(token);
    if (response.statusCode == 200) {
      print(response.body);
      dynamic body = jsonDecode(response.body);

      setState(() {
        orders = body['orders'];
        resselers = body['resellers'];
        WholeSellerProfit=body['wholeSellers'];
        Customers = body['customers'];
        List<dynamic> saless=body['ordersByDay'];

/*
        saless.forEach((item){
          saledata.add(SaleModel.fromJson(item));

        });*/


        if(body['avgOrderPrice']!=null){
          avgOrderPrice = body['avgOrderPrice'];
        }
        else if(body['totalProfit']!=null){
          totalProfit=body[totalProfit];
        }
        else if(body['grossSale']!=null){
          grossSale=body['grossSale'];
        }
        else{
          avgOrderPrice=0;
          grossSale=0;
          totalProfit=0;
        }

      });
      bl.close();

      print(orders);
      print(resselers);
      print(avgOrderPrice);
    } else {
      bl.close();
      print(response.statusCode);
      //confirmationPopup(context);

    }
  }

  List<SaleModel> saledata = [
    /*SaleModel("01", 35),
    SaleModel("02", 55),
    SaleModel("03", 66),
    SaleModel("04", 0),
    SaleModel("05", 100),*/
  ];

 /* List<SaleModel> amdanprofit = [
    SaleModel("date", 100),
    SaleModel("date", 200),
    SaleModel("date", 300),
    SaleModel("date", 0),
  ];

  List<SaleModel> resellerprofit = [
    SaleModel("date", 10),
    SaleModel("date", 15),
    SaleModel("date", 0),
  ];
  List<SaleModel> wholesellerprofit = [
    SaleModel("1", 20),
    SaleModel("2", 30),
    SaleModel("3", 80),
    SaleModel("4", 90),
    SaleModel("5", 190),
    SaleModel("6", 1290),
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ScafoldHomeKey,
      drawer: SuperAdminDrawer(),
      appBar: AppBar(
        leading: new IconButton(
          icon: Image.asset(
            'assets/images/menuicon.png',
            color: MyColors.whiteColor,
            scale: 2,
          ),
          onPressed: () => _ScafoldHomeKey.currentState!.openDrawer(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
                input: "Menu",
                fontsize: 16,
                fontWeight: FontWeight.normal,
                textcolor: MyColors.whiteColor),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Image.asset(
                'assets/images/notification.png',
                color: MyColors.whiteColor,
                scale: 2,
              ),
              onPressed: () => {
                Navigator.pushNamed(context, Constants.Notifications_Screen),
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        iconTheme: IconThemeData(
          color: MyColors.whiteColor,
          //change your color here
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Utils.FORM_HINT_PADDING,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      GestureDetector(
                        onTap: () {
                          filterpopup(context);
                        },
                        child: TextWidget(
                            input: "Filter Results",
                            fontsize: 12,
                            fontWeight: FontWeight.bold,
                            textcolor: MyColors.blackColor8),
                      ),
                    ],
                  ),
                  Utils.FORM_HINT_PADDING,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 100,
                        width: 180,
                        child: Card(
                          color: MyColors.rating_text_color,
                          elevation: 25,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                  color: MyColors.rating_text_color,
                                  width: 1.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                        input: "Total Orders",
                                        fontsize: 16,
                                        fontWeight: FontWeight.bold,
                                        textcolor: MyColors.whiteColor),
                                    Image.asset(
                                      "assets/images/order.png",
                                      height: 30,
                                      width: 30,
                                      color: MyColors.whiteColor,
                                    ),
                                  ],
                                ),
                                TextWidget(
                                    input: orders.toString(),
                                    fontsize: 20,
                                    fontWeight: FontWeight.bold,
                                    textcolor: MyColors.whiteColor),
                                if(FromFormattedDate!=null && ToFormattedDate!=null)
                                  TextWidget(
                                      input: FromFormattedDate!+"-"+ ToFormattedDate!,
                                      fontsize: 12,
                                      fontWeight: FontWeight.normal,
                                      textcolor: MyColors.whiteColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 180,
                        child: Card(
                          color: MyColors.facebook_button_color,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                  color: MyColors.nocolor, width: 1.0)),
                          elevation: 25,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                        input: "Resellers Profit",
                                        fontsize: 16,
                                        fontWeight: FontWeight.bold,
                                        textcolor: MyColors.whiteColor),
                                    Image.asset(
                                      "assets/images/sellers.png",
                                      height: 30,
                                      width: 30,
                                      color: MyColors.whiteColor,
                                    ),
                                  ],
                                ),
                                TextWidget(
                                    input: resselers.toString(),
                                    fontsize: 20,
                                    fontWeight: FontWeight.bold,
                                    textcolor: MyColors.whiteColor),
                                if(FromFormattedDate!=null && ToFormattedDate!=null)
                                  TextWidget(
                                      input: FromFormattedDate!+"-"+ ToFormattedDate!,
                                      fontsize: 12,
                                      fontWeight: FontWeight.normal,
                                      textcolor: MyColors.whiteColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Utils.FORM_HINT_PADDING,
                  Utils.FORM_HINT_PADDING,
                  if (Utils.User_Status == "Super Admin")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 100,
                          width: 180,
                          child: Card(
                            color: MyColors.navyblue,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: MyColors.nocolor, width: 1.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          input: "Average Sale",
                                          fontsize: 16,
                                          fontWeight: FontWeight.bold,
                                          textcolor: MyColors.whiteColor),
                                      Image.asset(
                                        "assets/images/margins.png",
                                        height: 30,
                                        width: 30,
                                        color: MyColors.whiteColor,
                                      ),
                                    ],
                                  ),
                                  TextWidget(
                                      input: grossSale.toString(),
                                      fontsize: 16,
                                      fontWeight: FontWeight.bold,
                                      textcolor: MyColors.whiteColor),
                                  if(FromFormattedDate!=null && ToFormattedDate!=null)
                                  TextWidget(
                                      input: FromFormattedDate!+"-"+ ToFormattedDate!,
                                      fontsize: 12,
                                      fontWeight: FontWeight.normal,
                                      textcolor: MyColors.whiteColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 180,
                          child: Card(
                            color: MyColors.darkgreenColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: MyColors.nocolor, width: 1.0)),
                            elevation: 25,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          input: "WholeSeller Profit",
                                          fontsize: 14,
                                          fontWeight: FontWeight.bold,
                                          textcolor: MyColors.whiteColor),
                                      Image.asset(
                                        "assets/images/earnings.png",
                                        height: 30,
                                        width: 30,
                                        color: MyColors.whiteColor,
                                      ),
                                    ],
                                  ),
                                  TextWidget(
                                      input:
                                          Utils.CURRENCY_SYMBOL + " " + WholeSellerProfit.toString(),
                                      fontsize: 20,
                                      fontWeight: FontWeight.bold,
                                      textcolor: MyColors.whiteColor),
                                  if(FromFormattedDate!=null && ToFormattedDate!=null)
                                    TextWidget(
                                        input: FromFormattedDate!+"-"+ ToFormattedDate!,
                                        fontsize: 12,
                                        fontWeight: FontWeight.normal,
                                        textcolor: MyColors.whiteColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 100,
                          width: 180,
                          child: Card(
                            color: MyColors.price_tag_color,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: MyColors.nocolor, width: 1.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          input: "Avg.Order Price",
                                          fontsize: 16,
                                          fontWeight: FontWeight.bold,
                                          textcolor: MyColors.whiteColor),
                                      Image.asset(
                                        "assets/images/earnings.png",
                                        height: 30,
                                        width: 30,
                                        color: MyColors.whiteColor,
                                      ),
                                    ],
                                  ),
                                  TextWidget(
                                      input: avgOrderPrice.toString(),
                                      fontsize: 20,
                                      fontWeight: FontWeight.bold,
                                      textcolor: MyColors.whiteColor),
                                  if(FromFormattedDate!=null && ToFormattedDate!=null)
                                    TextWidget(
                                        input: FromFormattedDate!+"-"+ ToFormattedDate!,
                                        fontsize: 12,
                                        fontWeight: FontWeight.normal,
                                        textcolor: MyColors.whiteColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 180,
                          child: Card(
                            color:MyColors.bin_red_color,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: MyColors.nocolor, width: 1.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          input: "Total Customers",
                                          fontsize: 16,
                                          fontWeight: FontWeight.bold,
                                          textcolor: MyColors.whiteColor),
                                      Image.asset(
                                        "assets/images/client.png",
                                        height: 30,
                                        width: 30,
                                        color: MyColors.whiteColor,
                                      ),
                                    ],
                                  ),
                                  TextWidget(
                                      input: Customers.toString(),
                                      fontsize: 20,
                                      fontWeight: FontWeight.bold,
                                      textcolor: MyColors.whiteColor),
                                  if(FromFormattedDate!=null && ToFormattedDate!=null)
                                    TextWidget(
                                        input: FromFormattedDate!+"-"+ ToFormattedDate!,
                                        fontsize: 12,
                                        fontWeight: FontWeight.normal,
                                        textcolor: MyColors.whiteColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (Utils.User_Status == "Super Admin")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 100,
                          width: 180,
                          child: Card(
                            color: MyColors.navyblue,
                            elevation: 25,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: MyColors.nocolor, width: 1.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                          input: "Amdan Profit",
                                          fontsize: 16,
                                          fontWeight: FontWeight.bold,
                                          textcolor: MyColors.whiteColor),
                                      Image.asset(
                                        "assets/images/margins.png",
                                        height: 30,
                                        width: 30,
                                        color: MyColors.whiteColor,
                                      ),
                                    ],
                                  ),
                                  TextWidget(
                                      input: totalProfit.toStringAsFixed(2),
                                      fontsize: 16,
                                      fontWeight: FontWeight.bold,
                                      textcolor: MyColors.whiteColor),
                                  if(FromFormattedDate!=null && ToFormattedDate!=null)
                                    TextWidget(
                                        input: FromFormattedDate!+"-"+ ToFormattedDate!,
                                        fontsize: 12,
                                        fontWeight: FontWeight.normal,
                                        textcolor: MyColors.whiteColor),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  Utils.FORM_HINT_PADDING,
                  Utils.FORM_HINT_PADDING,
                  Container(
                    color: MyColors.darkgreenColor,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: TextWidget(
                          input: "Sale",
                          fontsize: 26,
                          fontWeight: FontWeight.bold,
                          textcolor: MyColors.whiteColor),
                    ),
                  ),
                  Container(
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),

                        // Chart title
                        title: ChartTitle(text: 'Date wise sales analysis'),
                        // Enable legend
                        legend: Legend(isVisible: true),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<SaleModel, String>>[
                          LineSeries<SaleModel, String>(
                              dataSource: saledata,
                              xValueMapper: (SaleModel sales, _) => sales.date,
                              yValueMapper: (SaleModel sales, _) => sales.sales,
                              name: 'Sales',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true))
                        ]),
                  ),
               /*   if (Utils.User_Status == "Super Admin")
                    Column(
                      children: [
                        Container(
                          color: MyColors.darkgreenColor,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: TextWidget(
                                input: "Amdan Profit",
                                fontsize: 26,
                                fontWeight: FontWeight.bold,
                                textcolor: MyColors.whiteColor),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            //Initialize the spark charts widget
                            child: SfSparkLineChart.custom(
                              //Enable the trackball
                              trackball: SparkChartTrackball(
                                  activationMode: SparkChartActivationMode.tap),
                              //Enable marker
                              marker: SparkChartMarker(
                                  shape: SparkChartMarkerShape.diamond,
                                  displayMode: SparkChartMarkerDisplayMode.all),
                              //Enable data label
                              labelDisplayMode: SparkChartLabelDisplayMode.all,
                              xValueMapper: (int index) =>
                                  amdanprofit[index].date,
                              yValueMapper: (int index) =>
                                  amdanprofit[index].sales,
                              dataCount: amdanprofit.length.toInt(),
                            ),
                          ),
                        ),
                        Container(
                          color: MyColors.darkgreenColor,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: TextWidget(
                                input: "Resellers Profit",
                                fontsize: 26,
                                fontWeight: FontWeight.bold,
                                textcolor: MyColors.whiteColor),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            //Initialize the spark charts widget
                            child: SfSparkLineChart.custom(
                              //Enable the trackball
                              trackball: SparkChartTrackball(
                                  activationMode: SparkChartActivationMode.tap),
                              //Enable marker
                              marker: SparkChartMarker(
                                  shape: SparkChartMarkerShape.diamond,
                                  displayMode: SparkChartMarkerDisplayMode.all),
                              //Enable data label
                              labelDisplayMode: SparkChartLabelDisplayMode.all,
                              xValueMapper: (int index) =>
                                  resellerprofit[index].date,
                              yValueMapper: (int index) =>
                                  resellerprofit[index].sales,
                              color: MyColors.darkgreenColor,
                              axisLineColor: MyColors.greenColor,

                              dataCount: resellerprofit.length.toInt(),
                            ),
                          ),
                        ),
                        Container(
                          color: MyColors.darkgreenColor,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: TextWidget(
                                input: "WholeSeller profit",
                                fontsize: 26,
                                fontWeight: FontWeight.bold,
                                textcolor: MyColors.whiteColor),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            //Initialize the spark charts widget
                            child: SfSparkBarChart.custom(
                              //Enable the trackball
                              trackball: SparkChartTrackball(
                                  activationMode: SparkChartActivationMode.tap),
                              //Enable marker

                              //Enable data label
                              labelDisplayMode: SparkChartLabelDisplayMode.all,
                              xValueMapper: (int index) =>
                                  wholesellerprofit[index].date,
                              yValueMapper: (int index) =>
                                  wholesellerprofit[index].sales,
                              highPointColor: MyColors.darkgreenColor,
                              color: MyColors.navyblue,
                              lowPointColor: MyColors.redColor,

                              dataCount: wholesellerprofit.length.toInt(),
                            ),
                          ),
                        ),
                      ],
                    ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectfromdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromdate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2500));
    if (picked != null && picked != fromdate) {
      setState(() {
        fromdate = picked;
        DateFormat formatter = DateFormat('yyyy-MM-dd');
        FromFormattedDate = formatter.format(fromdate);


      });
    }
  }
  Future<void> selecttodate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: todate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2500));
    if (picked != null && picked != todate) {
      setState(() {
        todate = picked;
        DateFormat formatter = DateFormat('yyyy-MM-dd');
        ToFormattedDate = formatter.format(todate);


      });
    }
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
