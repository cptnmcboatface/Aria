import 'package:flutter/material.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    Color appBarIconColor = Color.fromRGBO(0, 0, 0, 0.7);
    Color titleFontColor = Color.fromRGBO(0, 0, 0, 0.8);
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
          onPressed: () {},
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
                child: Text("MY CART",
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
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Container(),
                    ),
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
                                textStyle: TextStyle(color: titleFontColor)),
                            text:
                                'Total (Including Shipping)    ', // default text style
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Rs. 580",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 25,
                                          letterSpacing: 0.25,
                                          fontWeight: FontWeight.w500,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Check out",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.white, letterSpacing: .5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Icon(Icons.arrow_forward_ios),
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
