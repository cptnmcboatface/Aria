import 'package:flutter/material.dart';
import 'package:aria_makeup/screens/ShoppingCartScreen.dart';
import 'UserDataScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:flutter/cupertino.dart';

class AllItemsScreen extends StatefulWidget {
  @override
  _AllItemsScreenState createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
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
    Color titleFontColor = Color.fromRGBO(0, 0, 0, 0.8);

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
                  MaterialPageRoute(builder: (context) => ShoppingCartScreen()),
                );
              }),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
        Container(
          padding: EdgeInsets.only(left:20),
                  child: Text("All Items.",
              style: GoogleFonts.montserrat(
                  color: titleFontColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w600)),
        ),
        SizedBox(
          height: 30,
        ),
        categoryDrawerMaker("Lip Color.", 200, 110),
        SizedBox(
          height: 10,
        ),
        categoryDrawerMaker("Eye Lashes.", 200, 110),
        SizedBox(
          height: 10,
        ),
        categoryDrawerMaker("Beauty Sponge.", 200, 110),
        SizedBox(
          height: 10,
        ),
        categoryDrawerMaker("Eye Shadow Palette.", 200, 110),
      ]),
    );
  }

  Widget categoryDrawerMaker(String text, double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
              decorationThickness: 0.9,
              decoration: TextDecoration.underline,
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        categoryDrawer(height, width),
      ],
    );
  }

  Widget categoryDrawer(double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: height,
      child: CupertinoScrollbar(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            trendingCard(Colors.red, height, width),
            SizedBox(
              width: 20,
            ),
            trendingCard(Colors.blue, height, width),
            SizedBox(
              width: 20,
            ),
            trendingCard(Colors.green, height, width),
            SizedBox(
              width: 20,
            ),
            trendingCard(Colors.yellow, height, width),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget trendingCard(var col, double height, double width) {
    Color trendingCardNameColor = Color.fromRGBO(0, 0, 0, 0.6);
    return Container(
      height: height,
      width: width,
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
            height: height - 60,
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
}
