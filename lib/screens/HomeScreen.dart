import 'package:aria_makeup/screens/AllItemsScreen.dart';
import 'package:aria_makeup/screens/ProductScreen.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:flutter/material.dart';
import 'package:aria_makeup/services/AuthenticateService.dart';
import 'package:aria_makeup/screens/UserDataScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aria_makeup/screens/ShoppingCartScreen.dart';
import 'package:aria_makeup/services/DatabaseService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aria_makeup/models/User.dart';

class HomeScreen extends StatefulWidget {
  final uid;
  HomeScreen({this.uid});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// AuthService().signOut();
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget homeScreenDrawer() {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Welcome.",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300)),
              ),
              Text(
                "Brand Name",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: mainThemeColor,
          ),
        ),
        ListTile(
          title: Text(
            "Log Out",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          onTap: () {
            Navigator.pop(context);
            AuthService().signOut();
          },
        ),
        ListTile(
          title: Text(
            "All Items",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllItemsScreen()),
            );
          },
        ),
        ListTile(
          title: Text(
            "Shopping Cart",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
            );
          },
        ),
        ListTile(
          title: Text(
            "Liked Items",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Personal Information",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserDataScreen()),
            );
          },
        ),
      ],
    ));
  }

  Widget build(BuildContext context) {
    final dB = DataBase(uid: widget.uid);
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: homeScreenDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShoppingCartScreen()),
                  );
                }),
          ],
        ),
        body: StreamBuilder(
            stream: dB.productStream,
            builder: (context, snapshot1) {
              if (!snapshot1.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitPumpingHeart(
                        color: mainThemeColor,
                        size: 20.0,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Connecting to the servers",
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                          )),
                    ],
                  ),
                );
              } else {
                Map<String, Product> products = snapshot1.data;
                return StreamBuilder(
                  stream:dB.categoryStream,
                  builder:(context, snapshot2){
                    return Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      titleBar(),
                      trendingDrawer(products),
                      homeScreenBottomDrawer()
                    ],
                  ),
                );
                  }
                );
                
              }
            }
            
            ));
  }

  Widget trendingDrawer(Map<String, Product> products) {
    
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
}
