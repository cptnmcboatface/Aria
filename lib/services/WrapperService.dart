import 'package:flutter/material.dart';
import 'package:aria_makeup/services/AuthenticateService.dart';
import 'package:aria_makeup/screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:aria_makeup/models/User.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return home or authenticate
    final user = Provider.of<User>(context);

    if (user == null) {
      return AuthService().handleAuth();
    } else {
      return HomeScreen();
    }
  }
}
