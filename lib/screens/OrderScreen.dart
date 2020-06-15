import 'package:aria_makeup/shared/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class OrderScreen extends StatefulWidget {
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
                                // color: mainThemeColor,
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
                                costText(580, false),
                                costText(580, false),
                                costText(580, true)
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

  Widget shoppingCartItems() {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      child: CupertinoScrollbar(
        // isAlwaysShown: true,
        controller: _scrollBarController,
        child: ListView(
          controller: _scrollBarController,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            listTileShoppingCart(imgList[0], 0),
            listTileShoppingCart(imgList[1], 1),
            listTileShoppingCart(imgList[2], 2),
            listTileShoppingCart(imgList[3], 3),
            listTileShoppingCart(imgList[4], 4),
          ],
        ),
      ),
    );
  }

  var itemCount = [1, 1, 1, 1, 1];
  Widget listTileShoppingCart(url, id) {
    double tileImageSize = 56;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            color: Colors.white.withOpacity(0.4),
            height: tileImageSize,
            width: tileImageSize,
            child: Image.network(
              url,
              fit: BoxFit.cover,
            )),
      ),
      title: Text('Lorem Ipsum',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(0, 0, 0, 0.8),
          )),
      subtitle: Text('Rs. 580',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(0, 0, 0, 0.7),
          )),
      trailing: Text(
        itemCount[id].toString(),
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color.fromRGBO(0, 0, 0, 0.8)),
      ),
    );
  }
}
