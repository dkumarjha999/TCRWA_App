import 'package:flutter/material.dart';
import 'package:tcrwa_app/authenticate/login_page.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/ui/splash_screen.dart';

void main(){
  runApp(
      MaterialApp(
        title: 'TCRWA',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/LoginPage' : (context) => LoginWithPhoneNumber(),
          // we can use routes for pushReplacement to navigate to new page
         // '/Home' : (context) => Home(),
        //  '/Profile' : (context) => Profile(),
        },
        //home:SplashScreen(),   or without routes we have to enable home and we can use other pages

        theme: ThemeData(
         // appBarTheme: AppBarTheme(
         //     color: Colors.black
         // ),
          backgroundColor: Colors.white,
          primaryColor: HexColor("02528A"),
        ),
      ),
  );
}
