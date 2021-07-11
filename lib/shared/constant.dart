import 'package:flutter/material.dart';

const textInputDecoration=InputDecoration(
  //border: InputBorder.none,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black26,width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black54,width: 2.0)
  ),
    labelStyle: TextStyle(
      color: Colors.white,
    )
);