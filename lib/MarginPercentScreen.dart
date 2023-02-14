import 'dart:convert';

import 'package:amdanadmin/HomeScreen.dart';
import 'package:amdanadmin/MyColors.dart';
import 'package:amdanadmin/Utils.dart';
import 'package:amdanadmin/widgets/BtnNullHeightWidth.dart';
import 'package:amdanadmin/widgets/EmailInputWidget.dart';
import 'package:amdanadmin/widgets/NameInputWidget.dart';
import 'package:bottom_loader/bottom_loader.dart';
import 'package:http/http.dart' as http;
import 'package:amdanadmin/widgets/ToolbarImage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MarginPercentScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MarginState();
  }
}

class MarginState extends State<MarginPercentScreen> {
  final GlobalKey<ScaffoldState> ScafoldMarginKey =
      new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> MarginFormKey = new GlobalKey<FormState>();
  String? amdanpercent;
  String resell="10%";
  String amdan="";
  String ship="15%";
  bool btA=false;
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
    getmargin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:ToolbarImage(appBar: AppBar(),),
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height, 
            color: MyColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(Utils.APP_PADDING),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Align(
                     alignment: Alignment.bottomCenter,
                      child: form(context)),
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget form(BuildContext context) {
    return Form(
        key: MarginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[



            NameInputWidget(
                title: "Amdan Percentage",
                isRequired: true,
                controller: TextEditingController(text: amdan),
                error: "Amdan Percentage is empty",
                keyboardType: TextInputType.number,
                value: (val) {
                  amdanpercent = val!;
                },
                width: MediaQuery.of(context).size.width,
                validate: true,
                isPassword: false,
                hintcolour: MyColors.blackColor24),

            Utils.FORM_HINT_PADDING,
            Utils.FORM_HINT_PADDING,
            Utils.FORM_HINT_PADDING,
            BtnNullHeightWidth(
              title: "Add",
              bgcolour: MyColors.darkgreenColor,
              textcolour: MyColors.whiteColor,
              onPress: () {
                //(is_teacher)?Navigator.pushReplacementNamed(context, Constants.signup_page),
                final form = MarginFormKey.currentState;
                form!.save();
                if (form.validate()) {

                  setState(() {});
                  bl.display();

                  try{
                    createmargin();
                  }catch (e){
                    bl.close();
                    errorPopUp(context, "An error Occurred.Try again later!");
                  }
                }
              },
              width: MediaQuery.of(context).size.width,
              height: 48,
            ),


            Utils.FORM_COMP_PADDING,
          ],
        ));
  }
  Future<dynamic> getmargin() async {
    var token = Utils.token;
    var url = Uri.parse(baseurl +
        'admin/owner-margin');
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
        dynamic margin = body['data'];
        amdan=margin[0]['margin'];

      });


    } else {

      bl.close();
      print(response.body);
      dynamic body = jsonDecode(response.body);
      String error = body['error'];
      print(error);
      errorPopUp(context, error);


    }
  }
  Future<dynamic> createmargin() async {
    var token = Utils.token;
    var url = Uri.parse(baseurl + 'admin/owner-margin');
    var response = await http
        .post(
      url,
      body: {"margin": amdanpercent.toString()},
        headers: {
          'Authorization': '$token',
        },
    )
        .timeout(const Duration(seconds: 10),onTimeout: (){
      bl.close();
      return errorPopUp(context, "Check your Internet Connection!");
    });

    if (response.statusCode == 200) {
      print(response.body);
      dynamic body = jsonDecode(response.body);
     String message=body['data'];
      bl.close();
      confirmationPopup(context, message);




    } else {
      bl.close();
      print(response.body);
      dynamic body = jsonDecode(response.body);
      String error = body['error'];
      print(error);

      errorPopUp(context, error);
    }
    ;
  }
  confirmationPopup(BuildContext dialogContext, String? error) {

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
          "Close",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
                (route) => false,
          );
        },
        color: MyColors.darkgreenColor,
      )
    ]).show();
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
