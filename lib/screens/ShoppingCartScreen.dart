import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aria_makeup/screens/CheckoutScreen.dart';

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
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 10, child: shoppingCartItems()),
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
                                'Sub-Total    ', // default text style
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
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckoutScreen()),
                            );
                          },
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
                                          color: Colors.white,
                                          letterSpacing: .5),
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
        isAlwaysShown: true,
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
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              updateCount(id, true);
            },
            child: Icon(
              Icons.arrow_upward,
              size: 17,
              color: Color.fromRGBO(0, 0, 0, 0.4),
            ),
          ),
          Text(
            itemCount[id].toString(),
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color.fromRGBO(0, 0, 0, 0.8)),
          ),
          InkWell(
            onTap: () {
              updateCount(id, false);
            },
            child: Icon(
              Icons.arrow_downward,
              size: 17,
              color: Color.fromRGBO(0, 0, 0, 0.4),
            ),
          )
        ],
      ),
    );
  }

  void updateCount(id, bool direction) {
    if (direction) {
      setState(() {
        itemCount[id] += 1;
      });
    } else {
      setState(() {
        itemCount[id] -= 1;
      });
    }
  }
}
