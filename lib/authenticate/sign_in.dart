import 'package:flutter/material.dart';
import 'package:tcrwa_app/authenticate/forgot_password.dart';

import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/services/auth.dart';
import 'package:tcrwa_app/shared/loading.dart';
import 'package:tcrwa_app/ui/home_page_ui/new_home.dart';


class SignIn extends StatefulWidget {
  final Function
      toggleView; // toggle function to toggle between register and sign in
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Color _colorAppbar = HexColor("02528A");
  final AuthServiceEmail _auth = AuthServiceEmail();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
            backgroundColor: _colorAppbar,
            body: ListView(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 60),
                    height: MediaQuery.of(context).size.width / 2.5,
                    child: Image.asset(
                      "images/tcrwa-logo.png",
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 15),
                  child: Row(
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
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            labelText: 'Enter Email',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            )),
                            validator: (val) =>
                                val.isEmpty ? 'enter valid email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                         width: width,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'password',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                )),
                            validator: (val) => val.isEmpty
                                ? 'enter password '
                                : null,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: width,
                          child: RaisedButton(
                            color: Colors.blue[400],
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Loading(),
                                      ),
                                    );
                                });
                                // this will check validation of form
                                dynamic result = await _auth.regwithEmailAndPass(
                                    email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                    'please check your email already exist';
                                  });
                                  email='';
                                  password='';
                                }
                              }
                            },
                          ),
                        ),
                        // if we get the error baseed on email from firebase then it give error if user is not created due to wrong email validation
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 25),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Don't have account?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 25),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewHome(),
                                  ),
                                );
                              },
                              child: Container(
                                child: Text(
                                  "Signup",
                                  style: TextStyle(
                                      color: Colors.blue[400],
                                      fontSize:
                                          MediaQuery.of(context).size.width / 25),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
              ],
            ),
          );
  }
}



/*

 mufinash login page


import 'package:flutter/material.dart';
import 'package:tcrwa_app/ui/new_home.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

enum FormType {
  login,
  register
}

class _LoginState extends State<Login> {

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      print('form is valid, Email: $_email, Password: $_password');
      return true;
    }else{
      print('form is invalid');
      return false;
    }
  }
/*
  void validateAndSubmit() async{
    if (validateAndSave()){
      try {
        if(_formType == FormType.login){
         // FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        //  print('Logged In!! ${user.uid}');

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomePageScreen()),
          // );
        }
      }
      catch (e) {
        print('Error $e');
      }
    }
  }


 */

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 80),
              height: MediaQuery.of(context).size.width / 2.5,
              child: Image.asset(
                "images/tcrwa-logo.png",
              )),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 35),
            child: Row(
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
                )
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 12,
                    right: MediaQuery.of(context).size.width / 12,
                    top: 6),
                child: TextFormField(
                  obscureText: false,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                  onSaved: (value) => _email = value,
                  onChanged: (String email) {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'username',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 12,
                    right: MediaQuery.of(context).size.width / 12,
                    top: 16,
                    bottom: 20),
                child: TextFormField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  onChanged: (String email) {},
                  validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                  onSaved: (value) => _password = value,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'password',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
              Center(

                child:Container(
                  width:MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 6,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 12),
                  height: MediaQuery.of(context).size.width / 7,
                  color: Colors.blue,
                  child: RaisedButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 18),
                    ),
                    onPressed: (){},
                    color: Colors.blue,

                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewHome(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 25),
                    ),
                  ),
                ),
              ),
              Center(child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: width / 4),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Don't have account?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 25),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Text(
                            "Signup",
                            style: TextStyle(
                                color: Colors.blue[400],
                                fontSize: MediaQuery.of(context).size.width / 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ),
            ],
            ),
          )
        ],
      ),
    );
  }
}

 */