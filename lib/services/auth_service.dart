import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcrwa_app/authenticate/login_page.dart';
import 'package:tcrwa_app/shared/bottom_navigationBar.dart';

class AuthServicePhone {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return MyBottomNavbar();
        } else {
          return LoginWithPhoneNumber();
        }
      },
    );
  }

  // signIn
  singIn(AuthCredential authCredential) {
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  // singIn with otp
  signInWithOTP(smsCode, verId) {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    singIn(authCredential);
  }

  // sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

 getUserId(){
   return FirebaseAuth.instance.currentUser().toString();
  }
}
