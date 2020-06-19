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
import 'package:cached_network_image/cached_network_image.dart';
import 'LikedItemsScreen.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  final uid;
  HomeScreen({this.uid});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeScreenOptionState = "Collection";
  @override
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
                        builder: (context) => ShoppingCartScreen(
                              uid: widget.uid,
                            )),
                  );
                }),
          ],
        ),
        body: new StreamBuilder(
            stream: dB.productStream,
            builder: (context, snapshot1) {
              return new StreamBuilder(
                  stream: dB.categoryStream,
                  builder: (context, snapshot2) {
                    if (!snapshot1.hasData || !snapshot2.hasData) {
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
                      Map<String, Category> categories = snapshot2.data;

                      return Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            titleBar(),
                            trendingDrawer(
                                products, categories['Trending'].products),
                            homeScreenBottomDrawer(products, categories)
                          ],
                        ),
                      );
                    }
                  });
            }));
  }

  List<String> dynamicToSimpleList(List<dynamic> dynamicList) {
    List<String> simpleList = new List();
    dynamicList.forEach((val) {
      simpleList.add(val);
    });
    return simpleList;
  }

  Widget trendingDrawer(
      Map<String, Product> allProducts, List<dynamic> trendingProducts) {
    List<String> categoryItems = dynamicToSimpleList(trendingProducts);

    final trendingCardHeigth = 300.0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.only(left: 20.0),
      height: trendingCardHeigth,
      child: CupertinoScrollbar(
              child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: categoryItems.map((e) {
            return trendingCard(allProducts[e]);
          }).toList(),
        ),
      ),
    );
  }

  Widget trendingCard(
    Product product,
  ) {
    Color trendingCardNameColor = Color.fromRGBO(0, 0, 0, 0.6);

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductScreen(product: product, uid: widget.uid),
            ));
      },
      child: Container(
        height: 300,
        width: 180,
        margin: EdgeInsets.only(right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              height: 240,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                    color: Colors.white.withOpacity(0.4),
                    child: CachedNetworkImage(
                      imageUrl: product.images[0],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SpinKitPumpingHeart(
                        color: mainThemeColor,
                        size: 20.0,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.name,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: trendingCardNameColor,
                      fontSize: 15)),
            ),
            Text(
              "Rs. " + product.price.toString(),
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

  void homeScreenOptionStateHandler(String selected) {
    setState(() {
      homeScreenOptionState = selected;
    });
  }

  bool homeScreenOptionStateCheck(String id) {
    return id == homeScreenOptionState;
  }

  Widget homeScreenBottomDrawer(
      Map<String, Product> products, Map<String, Category> categories) {
    return Expanded(
      child: Container(
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
                    categoryHomeScreen("New"),
                    categoryHomeScreen("Collection"),
                  ],
                ),
                bottomDrawer(products, categories[homeScreenOptionState])
              ],
            )),
      ),
    );
  }

  Widget categoryHomeScreen(String name) {
    return FlatButton(
      onPressed: () {
        homeScreenOptionStateHandler(name);
      },
      child: Text(
        name,
        style: GoogleFonts.montserrat(
            textStyle: TextStyle(
                decorationThickness: 2.5,
                decoration: homeScreenOptionStateCheck(name)
                    ? TextDecoration.underline
                    : TextDecoration.none,
                fontWeight: homeScreenOptionStateCheck(name)
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: Colors.white,
                fontSize: homeScreenOptionStateCheck(name) ? 18 : 15)),
      ),
    );
  }

  Widget bottomDrawer(Map<String, Product> allProducts, Category myCategory) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 30, left: 20),
        margin: EdgeInsets.only(left: 10),
        child: CupertinoScrollbar(
                  child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: dynamicToSimpleList(myCategory.products)
                  .map((val) => bottomDrawerCard(allProducts[val]))
                  .toList()),
        ),
      ),
    );
  }

  Widget bottomDrawerCard(Product product) {
    var tileWidth = MediaQuery.of(context).size.width / 3;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductScreen(
                    product: product,
                    uid: widget.uid,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: tileWidth,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.white.withOpacity(0.4),
                      child: CachedNetworkImage(
                        imageUrl: product.images[0],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SpinKitPumpingHeart(
                          color: mainThemeColor,
                          size: 20.0,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.name,
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
              MaterialPageRoute(
                  builder: (context) => AllItemsScreen(uid: widget.uid)),
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
              MaterialPageRoute(
                  builder: (context) => ShoppingCartScreen(
                        uid: widget.uid,
                      )),
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
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LikedItemsScreen(uid: widget.uid)),
            );
          },
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
}
