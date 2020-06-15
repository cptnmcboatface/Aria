import 'package:aria_makeup/shared/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aria_makeup/services/AuthenticateService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:pinput/pin_put/pin_put_state.dart';

BoxDecoration get _pinPutDecoration {
  return BoxDecoration(
    border: Border.all(color: Color.fromRGBO(255, 183, 201, 0.4)),
    borderRadius: BorderRadius.circular(2),
  );
}

BoxDecoration get _pinDoneDecoration {
  return BoxDecoration(
    border: Border.all(color: Color.fromRGBO(255, 183, 201, 0.9)),
    borderRadius: BorderRadius.circular(10),
  );
}

BoxDecoration get _pinSelectedDecoration {
  return BoxDecoration(
    border: Border.all(
      color: Color.fromRGBO(255, 183, 201, 1.0),
      width: 2,
    ),
    borderRadius: BorderRadius.circular(10),
  );
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNo, verificationID, smsCode;
  bool codeSent = false;

  final formKey = new GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'PK';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Hello.",
                      style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(fontSize: 80, color: mainThemeColor)))),
              SizedBox(
                height: 0,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Sign In, beautiful.",
                      style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(fontSize: 20, color: mainThemeColor)))),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 80),
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 1,
                      color: mainThemeColor,
                    )),
                    child: phoneNoInputForm()),
              ),
              SizedBox(
                height: 80,
              )
            ],
          )),
    );
  }

  Widget phoneNoInputForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(codeSent ? "Enter OTP" : "SignIn via mobile phone",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontSize: 30, color: mainThemeColor)))),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  "After entering the phone number you will be sent an OTP",
                  style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontSize: 10, color: mainThemeColor)))),
          SizedBox(
            height: codeSent ? 10 : 20,
          ),
          codeSent
              ? Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text.rich(
                    TextSpan(
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          textStyle: TextStyle(color: mainThemeColor)),
                      text: 'OPT sent to ', // default text style
                      children: <TextSpan>[
                        TextSpan(
                            text: this.phoneNo,
                            style: GoogleFonts.montserrat(
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                )
              : Container(),
          codeSent
              ? Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 30),
                  child: InkWell(
                    child: Text(
                      "Tap here to change number.",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                    onTap: () {
                      setState(() {
                        this.codeSent = false;
                      });
                    },
                  ),
                )
              : Container(),
          codeSent ? otpInput() : phoneInput(),
          Expanded(
            child: Container(),
          ),
          codeSent
              ? Center(
                  child: SpinKitPumpingHeart(
                  size: 25,
                  color: mainThemeColor,
                ))
              : Container(),
          signInVerifyButton()
        ],
      ),
    );
  }

  Widget phoneInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Theme(
        data: new ThemeData(
          primaryColor: mainThemeColor,
          primaryColorDark: mainThemeColor,
        ),
        child: new TextField(
            keyboardType: TextInputType.phone,
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: mainThemeColor)),
                hintText: '+92 33 XXXXXXXX',
                labelText: 'Enter Phone Number',
                prefixIcon: const Icon(
                  Icons.phone,
                  color: Color.fromRGBO(255, 183, 201, 0.9),
                ),
                prefixText: ' ',
                labelStyle: GoogleFonts.montserrat()),
            onChanged: (val) {
              this.phoneNo = val;
            }),
      ),
    );
  }

  Widget signInVerifyButton() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.symmetric(
          vertical: 25,
        ),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: FlatButton(
          color: mainThemeColor,
          child: Text(
            codeSent ? "Verify" : "Sign In",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white, fontSize: 25)),
          ),
          onPressed: () {
            codeSent
                ? AuthService().signInWithOTP(smsCode, verificationID)
                : verifyPhone(phoneNo);
          },
        ),
      ),
    );
  }

  Widget otpInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: PinPut(
        selectedFieldDecoration: _pinSelectedDecoration,
        followingFieldDecoration: _pinPutDecoration,
        submittedFieldDecoration: _pinDoneDecoration,
        fieldsCount: 6,
        onSubmit: (String pin) {
          this.smsCode = pin;
          AuthService().signInWithOTP(smsCode, verificationID);
        },
      ),
    );
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
