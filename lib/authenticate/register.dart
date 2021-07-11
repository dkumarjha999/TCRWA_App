
import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/services/auth.dart';
import 'package:tcrwa_app/shared/constant.dart';
import 'package:tcrwa_app/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Color _colorAppbar = HexColor("02528A");
  final AuthServiceEmail _auth = AuthServiceEmail();
  final _formKey = GlobalKey<FormState>(); // for form validation
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              backgroundColor: _colorAppbar,
              elevation: 0.0,
              title: Text("Register"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person,color: Colors.white,),
                  label: Text("Sign In",style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    widget
                        .toggleView(); // here toggle view is widget so we have not used this.toggleView
                  },
                )
              ],
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              children: <Widget>[
                Container(
                  child: Form(
                    key: _formKey, // to keep track of form values
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText:
                              true, // for giving password as hidden value
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ char long'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              // this will check validation of form
                              dynamic result = await _auth.regwithEmailAndPass(
                                  email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                  'please check your Email / this email already exist';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // if we get the error baseed on email from firebase then it give error if user is not created due to wrong email validation
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
