import 'package:aria_makeup/screens/HomeScreen.dart';
import 'package:aria_makeup/screens/LoadingScreen.dart';
import 'package:aria_makeup/screens/UserDataScreen.dart';
import 'package:aria_makeup/services/DatabaseService.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  final uid;
  var dB;
  Wrapper({this.uid}) {
    print("DB initiated: " + uid);
    dB = DataBase(uid: this.uid);
    // dB.checkUser().then((v) {print(v);});
  }

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool check;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.dB.checkUser(), builder: (context, snapshot) {
          if(snapshot.hasData){
            bool userDataCheck = snapshot.data;
            if(userDataCheck){
              return HomeScreen(uid:widget.uid);
            }else{
              return UserDataScreen();
            }
          }else{
            print("No Data User Data Check");
            return LoadingScreen();
          }
        });
  }

}
