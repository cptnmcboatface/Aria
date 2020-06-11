import 'package:aria_makeup/services/WrapperService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aria_makeup/screens/LoginScreen.dart';
import 'package:aria_makeup/screens/HomeScreen.dart';

class AuthService {
  //Handle Auth
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Wrapper(uid: snapshot.data.uid,);
        } else {
          return LoginScreen();
        }
      },
    );
  }

  //SignOut
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign In
  signIn(AuthCredential authCred) {
    FirebaseAuth.instance.signInWithCredential(authCred);
  }

  //SignIn with OTP
  signInWithOTP(smsCode, verID) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verID, smsCode: smsCode);
    signIn(authCreds);
  }
}
