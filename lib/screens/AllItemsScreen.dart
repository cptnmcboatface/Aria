import 'package:flutter/material.dart';
import 'package:aria_makeup/screens/ShoppingCartScreen.dart';
import 'UserDataScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:aria_makeup/services/DatabaseService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aria_makeup/models/User.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'ProductScreen.dart';
import 'LikedItemsScreen.dart';

class AllItemsScreen extends StatefulWidget {
  final uid;
  AllItemsScreen({this.uid});
  @override
  _AllItemsScreenState createState() => _AllItemsScreenState();
}

class MyList<T> {
  List<T> _internal = new List<T>();
  operator +(other) => new List<T>.from(_internal)..addAll(other);
  noSuchMethod(inv) {
    //pass all calls to _internal
  }
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  @override
  Widget build(BuildContext context) {
    Color titleFontColor = Color.fromRGBO(0, 0, 0, 0.8);
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
                    List<Widget> allCategories = new List();

                    categories.forEach((k, v) => allCategories
                        .add(categoryDrawerMaker(v, 300, 170, products)));

                    return ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text("All Items.",
                                    style: GoogleFonts.montserrat(
                                        color: titleFontColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ] +
                            allCategories);
                  }
                });
          }),
    );
  }

  List<String> dynamicToSimpleList(List<dynamic> dynamicList) {
    List<String> simpleList = new List();
    dynamicList.forEach((val) {
      simpleList.add(val);
    });
    return simpleList;
  }

  Widget categoryDrawerMaker(Category category, double height, double width,
      Map<String, Product> allProducts) {
    List<Product> categoryProducts = (dynamicToSimpleList(category.products)
        .map((e) => allProducts[e])).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            category.name,
            style: GoogleFonts.montserrat(
              decorationThickness: 0.9,
              decoration: TextDecoration.underline,
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        categoryDrawer(categoryProducts, height, width),
      ],
    );
  }

  Widget categoryDrawer(
      List<Product> categoryProducts, double height, double width) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10,left: 20),
      height: height,
      child: CupertinoScrollbar(
        child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: (categoryProducts
                .map((e) => trendingCard(e, height, width))
                .toList())),
      ),
    );
  }

  Widget trendingCard(Product product, double height, double width) {
    Color trendingCardNameColor = Color.fromRGBO(0, 0, 0, 0.6);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(
                      product: product,
                      uid: widget.uid,
                    )));
      },
      child: Container(
        height: height,
        width: width,
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
              height: height - 80,
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
                  builder: (context) => ShoppingCartScreen(uid: widget.uid)),
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
              MaterialPageRoute(builder: (context) => LikedItemsScreen(uid:widget.uid)),
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
