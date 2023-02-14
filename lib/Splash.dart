import 'package:amdanadmin/LoginScreen.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';
import 'MyColors.dart';

import 'Utils.dart';
import 'dart:async';
import 'package:bottom_loader/bottom_loader.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late BottomLoader bl;




  @override
  Widget build(BuildContext context) {


    new Future.delayed(const Duration(seconds:05),(){
      CircularProgressIndicator(color: MyColors.blue_button_colour,);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>LoginScreen(),
        ),
            (route) => false,
      );

    });
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),




              ],
            ),
          ),
        ),
      ),
    );
  }


}