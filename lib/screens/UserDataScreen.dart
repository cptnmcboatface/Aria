import 'package:aria_makeup/shared/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDataScreen extends StatefulWidget {
  final mode;
  UserDataScreen({this.mode});
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(right: 50, top: 30),
                  decoration: BoxDecoration(
                    color: mainThemeColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        topRight: Radius.circular(2)),
                  ),
                  width: double.infinity,
                  height: 200,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Personal Information.",
                      style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 45)),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(1)),
                      border: Border.all(color: mainThemeColor, width: 1)),
                  child: userDataInputForm(),
                ),
                Center(
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Go Back",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(fontSize: 10),
                        ),
                      )),
                )
              ],
            ),
          ),
        ));
  }

  Widget userDataInputForm() {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Theme(
                data: new ThemeData(
                  primaryColor: mainThemeColor,
                  primaryColorDark: mainThemeColor,
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: mainThemeColor)),
                      hintText: 'Enter Name',
                      labelText: 'Name',
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color.fromRGBO(255, 183, 201, 0.9),
                      ),
                      prefixText: ' ',
                      labelStyle: GoogleFonts.montserrat()),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Theme(
                data: new ThemeData(
                  primaryColor: mainThemeColor,
                  primaryColorDark: mainThemeColor,
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: mainThemeColor)),
                      hintText: 'Enter E-mail',
                      labelText: 'E-mail',
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Color.fromRGBO(255, 183, 201, 0.9),
                      ),
                      prefixText: ' ',
                      labelStyle: GoogleFonts.montserrat()),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: bottom - 120 < 0 ? bottom : bottom - 120),
            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: mainThemeColor,
                    primaryColorDark: mainThemeColor,
                  ),
                  child: TextField(
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: mainThemeColor)),
                        hintText: 'Enter Address',
                        labelText: 'Address',
                        prefixIcon: const Icon(
                          Icons.home,
                          color: Color.fromRGBO(255, 183, 201, 0.9),
                        ),
                        prefixText: ' ',
                        labelStyle: GoogleFonts.montserrat()),
                  ),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              color: mainThemeColor,
              child: FlatButton(
                child: Text(
                  "Save",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.white, fontSize: 25)),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
