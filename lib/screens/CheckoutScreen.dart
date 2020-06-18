import 'dart:math';

import 'package:aria_makeup/models/User.dart';
import 'package:aria_makeup/services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aria_makeup/screens/OrderScreen.dart';

import 'package:random_string/random_string.dart';

class CheckoutScreen extends StatefulWidget {
  final uid, shoppingcart, allProducts;
  CheckoutScreen({this.uid, this.shoppingcart, this.allProducts});
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Color appBarIconColor = Color.fromRGBO(0, 0, 0, 0.7);
  Color titleFontColor = Color.fromRGBO(0, 0, 0, 0.8);
  final _formKey = GlobalKey<FormState>();
  String name, address, phoneNo;
  @override
  Widget build(BuildContext context) {
    bool _isValid = false;

    int subtotal = calculatePrice(widget.shoppingcart, widget.allProducts);
    Order order = Order(
        uid: widget.uid,
        name: name,
        phoneNumber: phoneNo,
        address: address,
        shoppingCart: widget.shoppingcart,
        price: subtotal + 180,
        orderId: randomAlphaNumeric(30));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: Form(
          onChanged: () {
            final isValid = _formKey.currentState.validate();
            if (_isValid != isValid) {
              setState(() {
                _isValid = isValid;
              });
            }
          },
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Checkout",
                      style: GoogleFonts.montserrat(
                          color: titleFontColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Expanded(
                flex: 17,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text("Name.",
                                style: GoogleFonts.montserrat(
                                    color: titleFontColor, fontSize: 20)),
                          ),
                          Expanded(
                              flex: 7,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all()),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.center,
                                  maxLines: null,
                                  onChanged: (val) {
                                    setState(() {
                                      name = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter your name',
                                      hintStyle:
                                          GoogleFonts.montserrat(fontSize: 13)),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text("Address.",
                                style: GoogleFonts.montserrat(
                                    color: titleFontColor, fontSize: 20)),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all()),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                maxLines: null,
                                textAlign: TextAlign.center,
                                onChanged: (val) {
                                  setState(() {
                                    address = val;
                                  });
                                },
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter your address',
                                    hintStyle:
                                        GoogleFonts.montserrat(fontSize: 13)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text("Phone Number.",
                                style: GoogleFonts.montserrat(
                                    color: titleFontColor, fontSize: 20)),
                          ),
                          Expanded(
                              flex: 7,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all()),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Enter Your Phone Number';
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.center,
                                  maxLines: null,
                                  onChanged: (val) {
                                    setState(() {
                                      phoneNo = val;
                                    });
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Your phone number',
                                      hintStyle:
                                          GoogleFonts.montserrat(fontSize: 13)),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text("Payment Method.",
                                style: GoogleFonts.montserrat(
                                    color: titleFontColor, fontSize: 20)),
                          ),
                          Expanded(
                            flex: 7,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all()),
                                    child: FlatButton(
                                      onPressed: null,
                                      child: Text("Cash On Delivery",
                                          style: GoogleFonts.montserrat(
                                              color: titleFontColor,
                                              fontSize: 15)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
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
                              costText(subtotal, false),
                              costText(180, false),
                              costText(subtotal + 180, true)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 20, left: 10, right: 10, bottom: 30),
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              DataBase(uid: widget.uid).addOrder(order);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderScreen(
                                          order: order,
                                          allProducts: widget.allProducts,
                                        )),
                              );
                            }
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Order",
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  int calculatePrice(var shoppingCart, var allProducts) {
    int t = 0;
    for (String pro in shoppingCart.products) {
      t += (allProducts[pro].price) * shoppingCart.quantities[pro];
    }
    return t;
  }

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
}
