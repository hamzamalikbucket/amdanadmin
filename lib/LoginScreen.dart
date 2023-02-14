import 'dart:convert';
import 'dart:ui';

import 'package:amdanadmin/HomeScreen.dart';
import 'package:amdanadmin/MyColors.dart';

import 'package:amdanadmin/Utils.dart';
import 'package:amdanadmin/widgets/BtnNullHeightWidth.dart';
import 'package:amdanadmin/widgets/EmailInputWidget.dart';
import 'package:amdanadmin/widgets/TextWidget.dart';
import 'package:bottom_loader/bottom_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _ScafoldSignKey =
      new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _SignKey = new GlobalKey<FormState>();
  bool showpass = true;
  late String? email, password;
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: MyColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(Utils.APP_PADDING),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    scale: 11,
                  ),
                  Utils.FORM_HINT_PADDING,
                  Utils.FORM_HINT_PADDING,
                  Utils.FORM_HINT_PADDING,
                  Align(
                      alignment: Alignment.bottomCenter, child: form(context)),
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
        key: _SignKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            EmailInputWidget(
                title: "Email",
                error: "Enter Valid Email",
                isRequired: true,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                value: (val) {
                  email = val!;
                },
                width: MediaQuery.of(context).size.width,
                validate: true,
                isPassword: false,
                hintcolour: MyColors.blackColor24),
            Utils.FORM_HINT_PADDING,
            TextFormField(
              decoration: new InputDecoration(
                  fillColor: MyColors.whiteColor,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: MyColors.blackColor24,
                  ),
                  suffixIcon: (showpass)
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              showpass = false;
                            });
                          },
                          icon: Icon(Icons.visibility_off),
                          color: MyColors.blackColor24,
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              showpass = true;
                            });
                          },
                          icon: Icon(Icons.visibility),
                          color: MyColors.blackColor24,
                        ),
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                        color: MyColors.blackColor24,
                      )),
                  hintText: "Password",
                  alignLabelWithHint: true,
                  hintStyle: TextStyle(color: MyColors.blackColor24)),
              obscureText: showpass,
              validator: (password) {
                if (password!.isEmpty) {
                  return 'The Password you enter is incorrect';
                }
              },
              onSaved: (value) {
                password = value;
              },
              onChanged: (value) {
                setState(() {});
              },
            ),
            Utils.FORM_HINT_PADDING,
            Utils.FORM_HINT_PADDING,
            BtnNullHeightWidth(
              title: "Login",
              bgcolour: MyColors.darkgreenColor,
              textcolour: MyColors.whiteColor,
              onPress: () async {

                final form = _SignKey.currentState;
                form!.save();

                if (form.validate()) {
                  print(password);
                  print(email);
                  bl.display();

                  try{
                    login();
                  }catch (e){
                    bl.close();
                    confirmationPopup(context, "An error Occurred.Try again later!");
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

  Future<dynamic> login() async {
    String token;
    var url = Uri.parse(baseurl + 'admin/login');
    var response = await http
        .post(
          url,
          body: {"email": email, "password": password},
        )
        .timeout(const Duration(seconds: 10),onTimeout: (){
          bl.close();
          return confirmationPopup(context, "Check your Internet Connection!");
    });

    if (response.statusCode == 200) {
      print(response.body);
      dynamic body = jsonDecode(response.body);
      Utils.token = body['token'];
      dynamic user = body['user'];
      bool role = body['isSuperAdmin'];
      if (role == true) {
        //Utils.User_Status='admin';
        Utils.User_Status = 'Super Admin';
      } else {
        Utils.User_Status = 'admin';
      }

      print(Utils.User_Status);
      print(Utils.token);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomeScreen(),
        ),
        (route) => false,
      );
    } else {
      bl.close();
      print(response.body);
      dynamic body = jsonDecode(response.body);
      String error = body['error'];
      print(error);

      confirmationPopup(context, error);
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
