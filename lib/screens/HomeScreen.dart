import 'dart:ffi';

import 'package:aria_makeup/screens/ProductScreen.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:flutter/material.dart';
import 'package:aria_makeup/services/AuthenticateService.dart';
import 'package:aria_makeup/screens/UserDataScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final uid;
  HomeScreen({this.uid});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// AuthService().signOut();
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.shopping_basket,
                  color: Colors.black,
                ),
                onPressed: null),
          ],
          leading: IconButton(
            onPressed: () {
              AuthService().signOut();
            },
            color: Colors.white,
            icon: Icon(
              Icons.dehaze,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              titleBar(),
              trendingDrawer(),
              homeScreenBottomDrawer()
            ],
          ),
        ));
  }

  var homeScreenOptionState = 0;
  void homeScreenOptionStateHandler(int selected) {
    setState(() {
      homeScreenOptionState = selected;
    });
  }

  bool homeScreenOptionStateCheck(var id) {
    return id == homeScreenOptionState;
  }

  Widget homeScreenBottomDrawer() {
    return Expanded(
      child: Container(
        // padding: EdgeInsets.only(left: 20),
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
              color: mainThemeColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        homeScreenOptionStateHandler(0);
                      },
                      child: Text(
                        "Collection",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                decorationThickness: 2.5,
                                decoration: homeScreenOptionStateCheck(0)
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                fontWeight: homeScreenOptionStateCheck(0)
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: Colors.white,
                                fontSize:
                                    homeScreenOptionStateCheck(0) ? 18 : 15)),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        homeScreenOptionStateHandler(1);
                      },
                      child: Text(
                        "New",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                decorationThickness: 2.5,
                                decoration: homeScreenOptionStateCheck(1)
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                fontWeight: homeScreenOptionStateCheck(1)
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: Colors.white,
                                fontSize:
                                    homeScreenOptionStateCheck(1) ? 18 : 15)),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        homeScreenOptionStateHandler(2);
                      },
                      child: Text(
                        "Collection",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                decorationThickness: 2.5,
                                decoration: homeScreenOptionStateCheck(2)
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                fontWeight: homeScreenOptionStateCheck(2)
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: Colors.white,
                                fontSize:
                                    homeScreenOptionStateCheck(2) ? 18 : 15)),
                      ),
                    ),
                  ],
                ),
                bottomDrawer()
              ],
            )),
      ),
    );
  }

  Widget bottomDrawer() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 30),
        margin: EdgeInsets.only(left: 10),
        // color: Colors.red,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            bottomDrawerCard(Colors.orange),
            SizedBox(
              width: 20,
            ),
            bottomDrawerCard(Colors.greenAccent),
            SizedBox(
              width: 20,
            ),
            bottomDrawerCard(Colors.blue),
            // trendingCard(Colors.green),
            SizedBox(
              width: 20,
            ),
            bottomDrawerCard(Colors.yellow),
            // trendingCard(Colors.yellow),
            SizedBox(
              width: 20,
            ),
            bottomDrawerCard(Colors.red)
          ],
        ),
      ),
    );
  }

  Widget bottomDrawerCard(var col) {
    var tileWidth = MediaQuery.of(context).size.width / 3;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductScreen(name: "lorem ipsum")),
        );
      },
      child: Container(
        width: tileWidth,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: col),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Lorem Ipsum",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 15)),
            )
          ],
        ),
      ),
    );
  }

  Widget trendingDrawer() {
    final trendingCardHeigth = 300.0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: trendingCardHeigth,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          trendingCard(Colors.red),
          SizedBox(
            width: 20,
          ),
          trendingCard(Colors.blue),
          SizedBox(
            width: 20,
          ),
          trendingCard(Colors.green),
          SizedBox(
            width: 20,
          ),
          trendingCard(Colors.yellow),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget trendingCard(var col) {
    Color trendingCardNameColor = Color.fromRGBO(0, 0, 0, 0.6);
    return Container(
      height: 300,
      width: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: col,
            ),
            height: 240,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Lorem Ipsum",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: trendingCardNameColor,
                    fontSize: 15)),
          ),
          Text(
            "Rs. 580",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: trendingCardNameColor,
                  fontSize: 20,
                ),
                color: mainThemeColor),
          ),
        ],
      ),
    );
  }

  Widget titleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "Trending",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {},
            child: Text(
              "See All",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
