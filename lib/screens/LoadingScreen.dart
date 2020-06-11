import 'package:flutter/material.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.white,child: Container(
            width: double.infinity,
            color: mainThemeColor,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "ARQOZMETICS",
                style: GoogleFonts.playfairDisplay(
                    textStyle: TextStyle(fontSize: 38, color: Colors.white)),
              ),
              SizedBox(height: 10),
              Text(
                "WHERE QUALITY IS QUEEN",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(fontSize: 15, color: Colors.white)),
              ),
              SizedBox(height: 20),
              SpinKitPumpingHeart(
                color: Colors.white,
                size: 20.0,
              )
            ])),),);
  }
}