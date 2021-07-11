import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final double _minimumPadding = 5.0;
  int height;
  Color _colorAppbar = HexColor("02528A");
  final String homeImage = 'images/home-photo-bg.jpg';
  final String myInfo = 'images/My-Info.png';
  final String gallery = 'images/Gallery.png';
  final String noticeBoard = 'images/Notice-Board.png';
  final String helpLine = 'images/Helpline.png';
  final String neighbours = 'images/Neighbours.png';
  final String settings = 'images/Settings.png';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _colorAppbar,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'images/home-menu-icon.png',
              fit: BoxFit.cover,
              height: 22,
            ),
            Padding(
              padding: EdgeInsets.only(left: _minimumPadding * 1),
              child: Text(
                "Home",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  //fontStyle: FontStyle.italic
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: _minimumPadding * 4),
            ),
            Image.asset(
              'images/top-TCRWA-logo.png',
              fit: BoxFit.cover,
              height: 30,
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 1.0, right: 1.0),
            child: Container(
              color: Colors.white,
              child: getImageAsset(homeImage),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 2.0, bottom: 2),
                    child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 6,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                myInfo,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.height / 12,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text(
                                "My Info",
                                style: TextStyle(
                                  color: _colorAppbar,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2),
                    child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 6,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                gallery,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.height / 12,
                                //color: _colorAppbar,
                                //color: _colorAppbar,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text(
                                "Gallery",
                                style: TextStyle(
                                  color: _colorAppbar,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0, bottom: 2),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                noticeBoard,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.height / 12,
                                // color: _colorAppbar,
                                //color: _colorAppbar,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text(
                                "Notices",
                                style: TextStyle(
                                  color: _colorAppbar,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>NoticeBoard()),);   // use to route to other page
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2.0),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 2.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                helpLine,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.height / 12,
                                //color: _colorAppbar,
                                //color: _colorAppbar,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text(
                                "Helpline",
                                style: TextStyle(
                                  color: _colorAppbar,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                neighbours,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.height / 12,
                                // color: _colorAppbar,
                                //color: _colorAppbar,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text(
                                "Neighbours",
                                style: TextStyle(
                                  color: _colorAppbar,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => {
                        //  Navigator.push(
                         //   context,
                          //  MaterialPageRoute(builder: (context) {
                          //    return Neighbour();
                          //  }),
                        //  ), // use to route to other page
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                settings,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.height / 12,
                                // color: _colorAppbar,
                                //color: _colorAppbar,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3.0),
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                  color: _colorAppbar,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getImageAsset(String val) {
    AssetImage assetImage = AssetImage(val);
    Image image = Image(
      image: assetImage,
      //width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height/2,
      fit: BoxFit.fitWidth,
    );
    return Stack(
      children: <Widget>[
        image,
        Positioned.fill(
          child: Align(
              alignment: Alignment.bottomLeft,
              // used to put date on bottom of image
              child: Text(
                _getCurrentDateTime(),
                style: TextStyle(
                    height: _minimumPadding * 5.2, color: Colors.white),
              )),
        ),
      ],
    );
  }

  String _getCurrentDateTime() {
    DateTime _current = DateTime.now();
    // String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(_current);

    var _curDayTime = DateFormat(' EEEE / d - MMM / yyyy').format(_current);
    return _curDayTime;
  }
}
