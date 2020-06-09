import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aria_makeup/services/AuthenticateService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  String phoneNo, verificationID, smsCode;
  bool codeSent = false;
  final formKey = new GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
        key: formKey,
        body: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: "Enter Phone"),
                  onChanged: (val) {
                    this.phoneNo = val;
                  },
                ),
              ),
              codeSent
                  ? Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(hintText: "Enter Code"),
                        onChanged: (val) {
                          setState(() {
                            this.smsCode = val;
                          });
                        },
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: RaisedButton(
                  child: codeSent ? Text("ENTER OTP") : Text("Sign In"),
                  onPressed: () {
                    codeSent
                        ? AuthService().signInWithOTP(smsCode, verificationID)
                        : verifyPhone(phoneNo);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verID, [int forceResend]) {
      this.verificationID = verID;
      setState(() {
        codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationID = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
