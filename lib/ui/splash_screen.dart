import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color _colorAppbar = HexColor("02528A");  //  or use  Color _colorAppbar = Color(0xff02528A); both are same

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => {
        Navigator.of(context).pop(),
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AuthServicePhone().handleAuth()),
        )
      },
    );
  }
  @override
  Widget build(BuildContext context) {
   // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: _colorAppbar),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 70.0,
                      child: Image.asset(
                        "images/tcrwa-logo.png",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 15),
                      child: Image.asset(
                        'images/top-TCRWA-logo.png',
                        fit: BoxFit.cover,
                        cacheHeight: 40,
                      ),
                      /*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                      */
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Center(
                      child: Text(
                        "Welcome To\n  T.C.R.W.A",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
