import 'package:aria_makeup/screens/ShoppingCartScreen.dart';
import 'package:aria_makeup/shared/Constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sky_engine/math/math.dart';

class ProductScreen extends StatefulWidget {
  final name;
  ProductScreen({this.name});
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class _ProductScreenState extends State<ProductScreen> {
  @override
  int _current = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: productScreenTop(),
            ),
            Expanded(
              flex: 4,
              child: Container(
                // padding: EdgeInsets.only(left: 20, top: 20),
                color: Colors.white,
                child: productInfo(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productInfo() {
    Color productNameColor = Color.fromRGBO(0, 0, 0, 0.75);
    Color productDescriptTitleColor = Color.fromRGBO(0, 0, 0, 0.65);
    Color productDescriptColor = Color.fromRGBO(0, 0, 0, 0.45);
    Color productDescriptIconColor = Color.fromRGBO(0, 0, 0, 0.1);

    return CustomPaint(
      painter: ShapesPainter(),
      child: Container(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 20,
              child: Text(
                "Lorem Ipsum",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: productNameColor,
                        fontSize: 20)),
              ),
            ),
            Expanded(
                flex: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            letterSpacing: 0.25,
                            fontWeight: FontWeight.w600,
                            textStyle:
                                TextStyle(color: productDescriptTitleColor)),
                        text: 'Designer: ', // default text style
                        children: <TextSpan>[
                          TextSpan(
                              text: "Captain Mcboatface",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: productDescriptColor))),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            textStyle:
                                TextStyle(color: productDescriptTitleColor)),
                        text: 'Materials: ', // default text style
                        children: <TextSpan>[
                          TextSpan(
                              text: "Child labor",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: productDescriptColor))),
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 15,
              child: Text(
                "Rs. 580",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mainThemeColor,
                        fontSize: 23)),
              ),
            ),
            Expanded(
              flex: 30,
              child: Container(
                margin: EdgeInsets.only(bottom: 10, right: 20),
                height: double.infinity,
                width: double.infinity,
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: productDescriptIconColor,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.check),
                            Text(
                              "Instock",
                              style: GoogleFonts.montserrat(
                                  color: productDescriptTitleColor),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: productDescriptIconColor,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.brush),
                            Text(
                              "Brush",
                              style: GoogleFonts.montserrat(
                                  color: productDescriptTitleColor),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: productDescriptIconColor,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.invert_colors),
                            Text(
                              "Red",
                              style: GoogleFonts.montserrat(
                                  color: productDescriptTitleColor),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 30,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: FlatButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: mainThemeColor,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: InkWell(
                      onTap: () {
                        print("HERE");
                      },
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: mainThemeColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30))),
                        child: Center(
                          child: Text(
                            "Buy now",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool likeState = false;
  Widget productScreenTop() {
    return Container(
      child: new Stack(
        children: <Widget>[
          // The containers in the background

          imageSlider(),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.only(top: 30),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.white,
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            child: Container(
              height: double.infinity,
              width: 50,
              color: Color.fromRGBO(1, 1, 1, .3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShoppingCartScreen()),
                      );
                    },
                    padding: EdgeInsets.only(top: 30),
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map((url) {
                      int index = imgList.indexOf(url);
                      return Container(
                        width: _current == index ? 10.0 : 7.0,
                        height: _current == index ? 10.0 : 7.0,
                        margin: EdgeInsets.symmetric(vertical: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(255, 255, 255, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        likeState = !likeState;
                      });
                    },
                    padding: EdgeInsets.only(bottom: 60),
                    icon: Icon(
                      likeState ? Icons.favorite : Icons.favorite_border,
                      size: 25,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget imageSlider() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 19,
          child: CarouselSlider(
            items: imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        height: double.infinity,
                      )),
                    ))
                .toList(),
            options: CarouselOptions(
                height: double.infinity,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
      ],
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final curvePath = Path();
    curvePath.moveTo(size.width - 30, -30);

    curvePath.arcToPoint(
      Offset(size.width, 0),
      radius: Radius.circular(30),
    );
    curvePath.lineTo(0, 0);

    curvePath.lineTo(0, -60);

    curvePath.arcToPoint(Offset(30, -30),
        radius: Radius.circular(30), rotation: 0, clockwise: false

        // largeArc: true,
        );
    canvas.drawPath(curvePath, paint);

    //10
    canvas.drawPath(curvePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
