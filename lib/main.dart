import 'package:flutter/material.dart';
import 'package:aria_makeup/screens/SplashScreen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  //HI THIS IS AMAL
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: SplashScreen(),
    );
  }
}
