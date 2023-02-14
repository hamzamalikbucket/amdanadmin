import 'package:amdanadmin/Constants.dart';
import 'package:amdanadmin/EarningsScreen.dart';
import 'package:amdanadmin/HomeScreen.dart';
import 'package:amdanadmin/LoginScreen.dart';
import 'package:amdanadmin/MarginPercentScreen.dart';
import 'package:amdanadmin/NotificationScreen.dart';
import 'package:amdanadmin/OrderScreen.dart';
import 'package:amdanadmin/Splash.dart';
import 'package:flutter/material.dart';
import 'package:amdanadmin/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    const MaterialColor myColor = const MaterialColor(
      0xFF39195,
      const <int, Color>{
        50: const Color(0xfffff),
        100: const Color(0xfffff),
        200: const Color(0xfffff),
        300: const Color(0xfffff),
        400: const Color(0xfffff),
        500: const Color(0xfffff),
        600: const Color(0xfffff),
        700: const Color(0xfffff),
        800: const Color(0xfffff),
        900: const Color(0xfffff),
      },
    );
    return MaterialApp(
      title: 'Amdan Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
        initialRoute: Constants.login_screen,

        routes: {
          Constants.Splash: (context) =>Splash(),
          Constants.login_screen: (context) =>LoginScreen(),
          Constants.home_Screen:(context)=>HomeScreen(),
          Constants.Order_Screen:(context)=>OrderScreen(),
          Constants.Earnings_Screen:(context)=>EarningsScreen(),
          Constants.Margin_Screen:(context)=>MarginPercentScreen(),
          Constants.Notifications_Screen:(context)=>NotificationScreen(),











        }

    );
  }
}


