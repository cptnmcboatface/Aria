import 'package:aria_makeup/shared/Constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aria_makeup/services/DatabaseService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ShoppingCartScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aria_makeup/models/User.dart';
import 'package:flutter/cupertino.dart';

class LikedItemsScreen extends StatefulWidget {
  final uid;
  LikedItemsScreen({this.uid});

  @override
  LikedItemsScreenState createState() {
    return LikedItemsScreenState();
  }
}

class LikedItemsScreenState extends State<LikedItemsScreen> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';
    final dB = DataBase(uid: widget.uid);
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                "Liked Items <3",
                style: GoogleFonts.montserrat(
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: dB.likedItemsStream,
                  builder: (context, snapshot1) {
                    return StreamBuilder(
                      stream: dB.productStream,
                      builder: (context, snapshot2) {
                        if (!snapshot1.hasData || !snapshot2.hasData) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Loading",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(fontSize: 15)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SpinKitPumpingHeart(
                                    size: 20, color: mainThemeColor)
                              ],
                            ),
                          );
                        } else {
                          var likedItems =
                              snapshot1.data["Liked Items"].toList();
                          var allProducts = snapshot2.data;
                          return CupertinoScrollbar(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: likedItems.length,
                              itemBuilder: (context, index) {
                                final item = likedItems[index];

                                return Dismissible(
                                  key: Key(item),
                                  onDismissed: (direction) {
                                    dB.removeLikedItem(item);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                      "Product Removed",
                                      style: GoogleFonts.montserrat(),
                                    )));
                                  },
                                  background: Container(color: Colors.red),
                                  child: listTileShoppingCart(
                                      context, allProducts[item]),
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget listTileShoppingCart(context, Product product) {
    double tileImageSize = 56;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            color: Colors.white.withOpacity(0.4),
            height: tileImageSize,
            width: tileImageSize,
            child: Image.network(
              product.images[0],
              fit: BoxFit.cover,
            )),
      ),
      title: Text(product.name,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(0, 0, 0, 0.8),
          )),
      subtitle: Text('Rs. ' + product.price.toString(),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(0, 0, 0, 0.7),
          )),
      trailing: IconButton(
        onPressed: () {
          DataBase(uid: widget.uid).addItem(product.id);
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
            "Product Added to Cart",
            style: GoogleFonts.montserrat(),
          )));
        },
        icon: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
