import 'package:aria_makeup/models/User.dart';
import 'package:aria_makeup/services/DatabaseService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aria_makeup/screens/CheckoutScreen.dart';

class ShoppingCartScreen extends StatefulWidget {
  final uid;
  // final allProducts;
  ShoppingCartScreen({this.uid});
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    Color appBarIconColor = Color.fromRGBO(0, 0, 0, 0.7);
    Color titleFontColor = Color.fromRGBO(0, 0, 0, 0.8);
    final dB = DataBase(uid: widget.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: appBarIconColor,
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.shopping_basket,
                color: appBarIconColor,
              ),
              onPressed: () {}),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Text("My cart",
                    style: GoogleFonts.montserrat(
                        color: titleFontColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Expanded(
              flex: 17,
              child: Container(
                decoration: BoxDecoration(
                    color: mainThemeColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: new StreamBuilder(
                    stream: dB.shoppingCartStream,
                    builder: (context, snapshot1) {
                      return StreamBuilder(
                        stream: dB.productStream,
                        builder: (context, snapshot2) {
                          if (!snapshot1.hasData || !snapshot2.hasData) {
                            return Center(
                              child: Text("No items in shopping cart"),
                            );
                          } else {
                            ShoppingCart shoppingCart = snapshot1.data;
                            Map<String, Product> allProducts = snapshot2.data;
                            return Column(
                              children: <Widget>[
                                Expanded(
                                    flex: 10,
                                    child: shoppingCartItems(
                                        shoppingCart, allProducts)),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.only(right: 20),
                                    alignment: Alignment.centerRight,
                                    child: Text.rich(
                                      TextSpan(
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            letterSpacing: 0.25,
                                            fontWeight: FontWeight.w300,
                                            textStyle: TextStyle(
                                                color: titleFontColor)),
                                        text:
                                            'Sub-Total    ', // default text style
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "Rs. " +
                                                  calculatePrice(shoppingCart,
                                                          allProducts)
                                                      .toString(),
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      fontSize: 25,
                                                      letterSpacing: 0.25,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: titleFontColor))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin: EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CheckoutScreen(
                                                    uid: widget.uid,
                                                    shoppingcart: shoppingCart,
                                                    allProducts: allProducts,
                                                  )),
                                        );
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Text(
                                              "Check out",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      letterSpacing: .5),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child:
                                                Icon(Icons.arrow_forward_ios),
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.all(10),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  final ScrollController _scrollBarController = ScrollController();
  List<String> dynamicToSimpleList(List<dynamic> dynamicList) {
    List<String> simpleList = new List();
    dynamicList.forEach((val) {
      simpleList.add(val);
    });
    return simpleList;
  }

  Widget shoppingCartItems(
      ShoppingCart shoppingCart, Map<String, Product> allProducts) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      child: CupertinoScrollbar(
        isAlwaysShown: true,
        controller: _scrollBarController,
        child: ListView(
          controller: _scrollBarController,
          physics: BouncingScrollPhysics(),
          children: dynamicToSimpleList(shoppingCart.products)
              .map((product) => listTileShoppingCart(
                  allProducts[product], shoppingCart.quantities))
              .toList(),
        ),
      ),
    );
  }

  var itemCount = [1, 1, 1, 1, 1];
  
  int calculatePrice(
      ShoppingCart shoppingCart, Map<String, Product> allProducts) {
    int t = 0;
    for (String pro in shoppingCart.products) {
      t += (allProducts[pro].price) * shoppingCart.quantities[pro];
    }
    return t;
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
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              updateCount(product.id, true, quantity);
            },
            child: Icon(
              Icons.arrow_upward,
              size: 20,
              color: Color.fromRGBO(0, 0, 0, 0.4),
            ),
          ),
          Text(
            quantity[product.id].toString(),
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color.fromRGBO(0, 0, 0, 0.8)),
          ),
          InkWell(
            onTap: () {
              updateCount(product.id, false, quantity);
            },
            child: Icon(
              Icons.arrow_downward,
              size: 20,
              color: Color.fromRGBO(0, 0, 0, 0.4),
            ),
          )
        ],
      ),
    );
  }

  void updateCount(id, bool direction, var quantities) {
    if (direction) {
      DataBase(uid: widget.uid).updateItemQuantity(id, quantities[id] + 1);
    } else {
      if (quantities[id] == 1) {
        DataBase(uid: widget.uid).removeItem(id);
      } else {
        DataBase(uid: widget.uid).updateItemQuantity(id, quantities[id] - 1);
      }
    }
  }
}
