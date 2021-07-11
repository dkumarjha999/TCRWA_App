import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';


class Board {
 @ required String key;
  String date;
  String time;
  String subject;
  String description;
  String createdOn;

  Board(this.subject, this.description,this.date,this.time,this.createdOn);    // if required make date and time as optional parameter

  Board.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        date = snapshot.value["date"],
        time = snapshot.value["time"],
        subject = snapshot.value["subject"],
        description = snapshot.value["description"],
        createdOn=snapshot.value['createdOn'];

  toJson() {
    return {
      "date":date,
      "time":time,
      "subject": subject,
      "description" : description,
      "createdOn":createdOn,
    };
  }


}