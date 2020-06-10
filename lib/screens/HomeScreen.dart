import 'package:flutter/material.dart';
import 'package:aria_makeup/services/AuthenticateService.dart';

class HomeScreen extends StatefulWidget {
  final uid;
  HomeScreen({this.uid});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: RaisedButton(
        child: Text('SO'),
        onPressed: () {
        AuthService().signOut();
      }),
    ));
  }
}
