import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/models/notice_board.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:tcrwa_app/ui/notice_board_ui/notices.dart';

class CreateNotice extends StatefulWidget {
  @override
  _CreateNoticeState createState() => _CreateNoticeState();
}

class _CreateNoticeState extends State<CreateNotice> {
  final dateFormat = DateFormat("d-MMM-yyyy");
  final timeFormat = DateFormat("h:mm a");
  final _timeController=TextEditingController();
  final _dateController=TextEditingController();

  Color _colorAppbar = HexColor("02528A");
  List<Board> boardMessages = List();
  Board board;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    board = Board("", "", "", "","");
    _timeController.text=(DateFormat('jm').format(DateTime.now())).toString();
    _dateController.text=(DateFormat('d-MMM-yyy').format(DateTime.now())).toString();
    databaseReference = database.reference().child("notice_board");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  Future<bool> addNoticeAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert',style: TextStyle(color: Colors.red),),
            content: Text('Notice added successfully',style: TextStyle(color: _colorAppbar),),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                color: Colors.green,
                onPressed: () {
                  handleSubmit();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoticeBoard(),
                    ),
                  );
                  /*
                  FirebaseAuth.instance.currentUser().then((user) {

                    if (user != null && usertype = admin ) {
                      Navigator.of(context).pop(); // pop alert dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBottomNavbar(),
                        ),
                      );// once code verified automatically then move to home page
                    } else {
                      Navigator.of(context).pop();
                    }
                   */
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: sidebarBuilder(context),
      backgroundColor: _colorAppbar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        mini: true,
        backgroundColor: _colorAppbar,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NoticeBoard(),
            ),
          );
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _colorAppbar,
        titleSpacing: -10.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Add Notices",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  //fontStyle: FontStyle.italic
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          CircleAvatar(
            backgroundColor: _colorAppbar,
            radius: 60.0,
            child: Image.asset(
              "images/tcrwa-logo.png",
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/top-TCRWA-logo.png",
                  height: 30,
                ),
                /*
                Text(
                  "TCR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "WA",
                  style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),

                */
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
            child: Container(
              child: DateTimeField(
                controller: _dateController,
                format: dateFormat,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Select Date",
                    filled: true,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
                onShowPicker: (context, currentValue) async {
                  final DateTime date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 0)),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2200),
                  );
                  if (date != null && _dateController.text.isNotEmpty) {
                    setState(() {
                      _dateController.text = dateFormat.format(date).toString();
                      board.date = _dateController.text;
                    });
                  }
                  return date;
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Container(
              child: DateTimeField(
                controller: _timeController,
                format: timeFormat,
                decoration: InputDecoration(
                  //border: InputBorder.none,
                  labelText: "Select Time",
                  filled: true,
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  if (time != null && _timeController.text.isNotEmpty) {
                    String _time =
                        time.hour.toString() + ':' + time.minute.toString();
                    setState(() {
                      _timeController.text = _time;
                      board.time = _timeController.text;
                    });
                  }
                  return DateTimeField.convert(time);
                },
              ),
            ),
          ),
          Center(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: TextFormField(
                      validator: (val) {
                        if(val.isEmpty){
                          return 'Enter subject';
                        }
                        else{
                          return null;
                        }
                      },
                      onSaved: (val) => board.subject = val,
                      decoration: InputDecoration(
                          //border: InputBorder.none,
                          labelText: "Subject",
                          hintText: 'Write heading',
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2.0)),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                    child: TextFormField(
                      validator:(val) => val.isEmpty ? 'Enter description' : null,
                      onSaved: (val) => board.description = val,
                      decoration: InputDecoration(
                          //border: InputBorder.none,
                          labelText: "Description",
                          hintText: 'describe event ',
                          filled: true,
                          // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2.0)),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                  //Send or Post button
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    child: Text(
                      "Post Notice",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      if(formKey.currentState.validate()){
                        String _createdOn =(DateFormat('d-MMM-yyy').format(DateTime.now())).toString()+','+(DateFormat('jm').format(DateTime.now())).toString();
                        //(DateFormat('d-MMM-yyy').format(DateTime.now())).toString();
                        board.createdOn=_createdOn;
                        addNoticeAlertDialog(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onEntryAdded(Event event) {
    setState(() {
      boardMessages.add(Board.fromSnapshot(event.snapshot));
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;
    if (_dateController.text != null) {
      board.date = _dateController.text;
    } else {
      board.date = (DateFormat('d-MMM-yyy').format(DateTime.now())).toString();
    }
    if (_timeController.text != null) {
      board.time = _timeController.text;
    } else {
      board.time = (DateFormat('jm').format(DateTime.now())).toString();
    }
    if (form.validate()) {
      form.save();
      form.reset();
      //save form data to the database
      databaseReference.push().set(board.toJson());
    }
  }

  void _onEntryChanged(Event event) {
    var oldEntry = boardMessages.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      boardMessages[boardMessages.indexOf(oldEntry)] =
          Board.fromSnapshot(event.snapshot);
    });
  }
}
