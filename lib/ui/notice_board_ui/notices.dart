import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/models/notice_board.dart';
import 'package:tcrwa_app/shared/bottom_navigationBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tcrwa_app/ui/notice_board_ui/add_notice.dart';

class NoticeBoard extends StatefulWidget {
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  Color _colorAppbar = HexColor("02528A");

  List<Board> boardMessages = List();
  Board board;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    board = Board("", "", "", "", "");
    databaseReference = database.reference().child("notice_board");
    databaseReference.orderByChild('createdOn').onChildAdded.listen(_onEntryAdded);
    databaseReference.orderByChild('createdOn').onChildChanged.listen(_onEntryChanged);
  }

  Future<bool> deleteNoticeAlertDialog(
      BuildContext context, String _noticeId, int _index) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert',
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            'Do you really want to delete this notice ?',
            style: TextStyle(color: _colorAppbar),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: FlatButton(
                child: Text('Yes'),
                color: Colors.green,
                onPressed: () async {
                  databaseReference
                      .child(_noticeId)
                      .remove(); // removing from database
                  boardMessages.removeAt(_index); // removing from main screen
                  // setState(() {
                  //   databaseReference.onChildChanged.listen(_onEntryRemoved);
                  //  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: sidebarBuilder(context),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        backgroundColor: _colorAppbar,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          // FAB 1
          SpeedDialChild(
              child: Icon(Icons.arrow_back_ios),
              backgroundColor: _colorAppbar,
              onTap: () {
                /* do anything */
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyBottomNavbar()));
              },
              label: "Back To Home",
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelBackgroundColor: _colorAppbar),
          // FAB 2
          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: _colorAppbar,
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => CreateNotice()));
              },
              label: 'Add Notice',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelBackgroundColor: _colorAppbar)
        ],
      ),

      /*FloatingActionButton(
        child: Icon(Icons.add),
        mini: true,
        backgroundColor: _colorAppbar,
        onPressed: () {
          Navigator.push(
             context, MaterialPageRoute(builder: (context) => CreateNotice()));
        },
        tooltip: 'Add Notice',
      ),

       */
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
                "Notices",
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: StreamBuilder(
              stream: databaseReference.orderByChild('createdOn').onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  // primary: false,
                  padding: EdgeInsets.all(8.0),
                  itemCount: boardMessages.length,
                  itemBuilder: (_, int index) {
                    return Card(
                      child: ListTile(
                        leading: Text(
                          boardMessages[index].time,
                          style: TextStyle(color: _colorAppbar),
                        ),
                        title:  Text(
                          boardMessages[index].subject,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle:  Text(boardMessages[index].description),
                        trailing: Text(
                            boardMessages[index].date,
                            style: TextStyle(color: Colors.red),
                          ),
                        onLongPress: () {
                          deleteNoticeAlertDialog(
                              context, boardMessages[index].key, index);
                        },
                      ),
                    );
                  },
                );
              },
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
