import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        backgroundColor: Color(0xff02528A),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 12,
                      right: MediaQuery.of(context).size.width / 12,
                      top: 30),
                  child: TextField(
                    obscureText: false,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    onChanged: (String email) {},
                    decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(),
                        labelText: 'Mobile number',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 18,
                      //horizontal: MediaQuery.of(context).size.width / 3
                      right: width/12
                  ),
                  height: MediaQuery.of(context).size.width / 10,
                  width: width/4,
                  color: Colors.blue[400],
                  child: Center(
                    child: Text(
                      "Get Otp",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}