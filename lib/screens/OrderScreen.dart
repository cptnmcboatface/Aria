import 'package:aria_makeup/shared/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:aria_makeup/models/User.dart';

class OrderScreen extends StatefulWidget {
  final order, allProducts;

  OrderScreen({this.order, this.allProducts});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    Color appBarIconColor = Color.fromRGBO(0, 0, 0, 0.7);
    Color titleFontColor = Color.fromRGBO(0, 0, 0, 0.8);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            // Navigator.popUntil(context, (route) => false);
          },
          color: Colors.white,
          icon: Icon(
            Icons.arrow_back_ios,
            color: appBarIconColor,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Text("Order Recieved.",
                    style: GoogleFonts.montserrat(
                        color: titleFontColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(
                    "Thank you for your order. We will soon confirm your order and it will be on your way asap. <3",
                    style: GoogleFonts.montserrat(
                        color: titleFontColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w300)),
              ),
            ),
            Expanded(
              flex: 17,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        flex: 9,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                border: Border.all()),
                            child: shoppingCartItems())),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                costName("Sub-Total", false),
                                costName("Shipping", false),
                                costName("Total", true)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                costName(" : ", false),
                                costName(" : ", false),
                                costName(" : ", true)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                costText(widget.order.price - 180, false),
                                costText(180, false),
                                costText(widget.order.price, true)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final ScrollController _scrollBarController = ScrollController();
  Color appBarIconColor = Color.fromRGBO(0, 0, 0, 0.7);
  Color titleFontColor = Color.fromRGBO(0, 0, 0, 0.8);
  Widget costName(String name, bool mode) {
    return Container(
      padding: EdgeInsets.only(top: mode ? 5 : 0),
      child: Text(
        name,
        style: GoogleFonts.montserrat(
            fontSize: mode ? 20 : 13,
            letterSpacing: mode ? 0.4 : 0.25,
            fontWeight: mode ? FontWeight.w400 : FontWeight.w300,
            textStyle: TextStyle(color: titleFontColor)),
      ),
    );
  }

  Widget costText(int cost, bool mode) {
    Color titleFontColor = Color.fromRGBO(0, 0, 0, 0.8);
    return Container(
      padding: EdgeInsets.only(top: mode ? 5 : 0),
      child: Text(
        'Rs. ' + cost.toString(),
        style: GoogleFonts.montserrat(
            fontSize: mode ? 18 : 13,
            letterSpacing: 0.25,
            fontWeight: FontWeight.w500,
            textStyle: TextStyle(color: titleFontColor)),
      ),
    );
  }

  List<String> dynamicToSimpleList(List<dynamic> dynamicList) {
    List<String> simpleList = new List();
    dynamicList.forEach((val) {
      simpleList.add(val);
    });
    return simpleList;
  }

  var itemCount;
  Widget shoppingCartItems() {
    ;
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      child: CupertinoScrollbar(
        // isAlwaysShown: true,
        controller: _scrollBarController,
        child: ListView(
          controller: _scrollBarController,
          physics: BouncingScrollPhysics(),
          children: dynamicToSimpleList(widget.order.shoppingCart.products)
              .map((product) => listTileShoppingCart(
                  widget.allProducts[product],
                  widget.order.shoppingCart.quantities[product]))
              .toList(),
        ),
      ),
    );
  }

  Widget listTileShoppingCart(Product product, var quantity) {
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
      trailing: Text(
        quantity.toString(),
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color.fromRGBO(0, 0, 0, 0.8)),
      ),
    );
  }
}
