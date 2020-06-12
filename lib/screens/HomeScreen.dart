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
            onPressed: () {},
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
            children: <Widget>[titleBar(), trendingDrawer()],
          ),
        ));
  }

  Widget trendingDrawer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 250.0,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          trendingCard(Colors.red)
          ,
          
          SizedBox(
            width: 20,
          ),
          trendingCard(Colors.blue),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 160.0,
            color: Colors.green,
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 160.0,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }

  Widget trendingCard(var col) {
    return Container(
      width: 200,
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            color: col,
          )
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
