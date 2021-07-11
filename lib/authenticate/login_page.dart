import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcrwa_app/services/auth_service.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  @override
  LoginWithPhoneNumberState createState() => LoginWithPhoneNumberState();
}

class LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final _formkey = GlobalKey<FormState>(); // for Mobile number validation
  Color _colorAppbar = HexColor("02528A");
  String phoneNo = '';
  String smsCode = '';
  String verificationId = '';
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //  bool smsver=false;
    return Scaffold(
      backgroundColor: _colorAppbar,
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80),
            height: width / 2.5,
            child:CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 70.0,
              child: Image.asset(
                "images/tcrwa-logo.png",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*
                Image.asset(
                  'images/top-TCRWA-logo.png',
                  fit: BoxFit.cover,
                  cacheHeight: 40,
                ),
                */

                Text(
                  "TCR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: width / 16,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "WA",
                  style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: width / 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Form(
            key: _formkey,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          //border: InputBorder.none,
                          // labelText: 'Phone No',
                          hintText: ' Your Phone Number',
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2.0)),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      validator: (val) =>
                          val.length != 10 ? 'Invalid Number' : null,
                      onChanged: (val) {
                        setState(() {
                          this.phoneNo = '+91' + val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  codeSent
                      ? Container(
                          height: 60,
                          width: width,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                //border: InputBorder.none,
                                labelText: 'OTP',
                                hintText: 'Enter OTP',
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.pink, width: 2.0)),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                )),
                            onChanged: (val) {
                              setState(() {
                                this.smsCode = val;
                              });
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: width,
                    child: RaisedButton(
                      color: Colors.blue[400],
                      child: codeSent
                          ? Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Verify",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          codeSent
                              ? AuthServicePhone()
                                  .signInWithOTP(smsCode, verificationId)
                              : verifyPhone(phoneNo);
                        }
                      },
                      // onPressed: verifyPhone,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  /*
                  Container(
                    height: 50,
                    width: width,
                    child: RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        "Login using Email and Password",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        verifyPhone(phoneNo);
                      },
                    ),
                  ),
                  */
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthServicePhone().singIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print("${authException.message}");
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }
}
