import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aria_makeup/services/AuthenticateService.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => AuthService().handleAuth())));
  }

  @override
  Widget build(BuildContext context) {
    print("here");
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            width: double.infinity,
            color: mainThemeColor,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Brand Name",
                style: GoogleFonts.playfairDisplay(
                    textStyle: TextStyle(fontSize: 38, color: Colors.white)),
              ),
              SizedBox(height: 10),
              Text(
                "Slogan Comes Here",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(fontSize: 15, color: Colors.white)),
              ),
              SizedBox(height: 20),
              SpinKitPumpingHeart(
                color: Colors.white,
                size: 20.0,
              )
            ])));
  }
}
