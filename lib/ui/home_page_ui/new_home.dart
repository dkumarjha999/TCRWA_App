import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:intl/intl.dart';
import 'package:tcrwa_app/services/auth_service.dart';
import 'package:tcrwa_app/shared/sidebar.dart';
import 'package:tcrwa_app/ui/helpline_ui/helpline_numbers.dart';
import 'package:tcrwa_app/ui/gallery_ui/multi_img_home.dart';
import 'package:tcrwa_app/ui/myinfo/myinfo_mainpage.dart';
import 'package:tcrwa_app/ui/neighbour_ui/neighbor.dart';
import 'package:tcrwa_app/ui/notice_board_ui/notices.dart';

class NewHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewHomeState();
  }
}

class _NewHomeState extends State<NewHome> {
  static const int tabletBreakpoint = 600; // >600 is tablet screen
  final double _minimumPadding = 5.0;

  Color _colorAppbar = HexColor("02528A");
  final String homeImage = 'images/home-photo-bg.jpg';
  final String myInfo = 'images/My-Info.png';
  final String gallery = 'images/Gallery.png';
  final String noticeBoard = 'images/Notice-Board.png';
  final String helpLine = 'images/Helpline.png';
  final String neighbours = 'images/Neighbours.png';
  final String settings = 'images/Settings.png';

  // final AuthService _authService = AuthService();

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //backgroundColor: Colors.greenAccen,
          title: Text(
            "Alert",
            style: TextStyle(color: Colors.red, fontSize: 25),
          ),
          content: new Text("Do you really want to logout for now ?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text('No'),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: FlatButton(
                child: Text('Yes'),
                color: Colors.red,
                onPressed: () {
                  AuthServicePhone().signOut();
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthServicePhone().handleAuth(),
                    ),
                  );
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
    // imp to get sizes
    var shortestSide = MediaQuery.of(context)
        .size
        .shortestSide; // give shortest side of device
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait &&
        shortestSide < tabletBreakpoint) {
      // mobile
      return (_buildMobileLayout(context));
    } else {
      // this is tablet
      return (_buildTabletLayout(context));
    }
  }

  Widget _buildMobileLayout(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 8;
    double _height = MediaQuery.of(context).size.height / 13;
    double _boxHeight = MediaQuery.of(context).size.height / 6.6;
    return Scaffold(
      drawer: sidebarBuilder(context),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: _colorAppbar,
        titleSpacing: -10.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Home",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                //fontStyle: FontStyle.italic
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
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              _showDialog();
            },
          ),
        ],
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
                    padding: EdgeInsets.only(right: 2.0, bottom: 2.0),
                    child: Container(
                      color: Colors.white,
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                myInfo,
                                width: _width,
                                height: _height,
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
                        onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProfile(),
                            ),
                          ),
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2),
                    child: Container(
                      color: Colors.white,
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                gallery,
                                width: _width,
                                height: _height,
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
                        onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GalleryPage(),
                            ),
                          )
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0, bottom: 2),
                    child: Container(
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                noticeBoard,
                                width: _width,
                                height: _height,
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoticeBoard(),
                            ),
                          ),
                          /*
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) NoticeBoard(),
                            ),
                          ),
                          */ // use to route to other page
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
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                helpLine,
                                width: _width,
                                height: _height,
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
                        onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpLineNumbers(),
                            ),
                          ),
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0),
                    child: Container(
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                neighbours,
                                width: _width,
                                height: _height,
                                // color: _colorAppbar,
                                //color: _colorAppbar,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.0),
                              child: Text(
                                "Neighbour",
                                style: TextStyle(
                                  color: _colorAppbar,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Neighbour(),
                            ),
                          ),
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0),
                    child: Container(
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Image.asset(
                                settings,
                                width: _width,
                                height: _height,
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

  Widget _buildTabletLayout(BuildContext context) {
    /*
    double _width = MediaQuery.of(context).size.width / 10;
    double _height = MediaQuery.of(context).size.height / 15;
    double _boxHeight = MediaQuery.of(context).size.height / 6;
    return Scaffold(
      drawer: sidebarBuilder(context),
      appBar: AppBar(
        backgroundColor: _colorAppbar,
        titleSpacing: -10.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Home",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                //fontStyle: FontStyle.italic
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
              child: getImageAssetTab(homeImage),
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
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                myInfo,
                                width: _width,
                                height: _height,
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
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                gallery,
                                width: _width,
                                height: _height,
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
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Gallery()),
                          )
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0, bottom: 2),
                    child: Container(
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                noticeBoard,
                                width: _width,
                                height: _height,
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
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                helpLine,
                                width: _width,
                                height: _height,
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
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HelpLineNumbers()),
                          )
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0, right: 2.0),
                    child: Container(
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                neighbours,
                                width: _width,
                                height: _height,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Neighbour()),
                          )
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2.0),
                    child: Container(
                      height: _boxHeight,
                      child: RaisedButton(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                settings,
                                width: _width,
                                height: _height,
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
    */
    return Center(child: CircularProgressIndicator());
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
                    height: _minimumPadding * 6, color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget getImageAssetTab(String val) {
    AssetImage assetImage = AssetImage(val);
    Image image = Image(
      image: assetImage,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
                    height: _minimumPadding * 5.4, color: Colors.white),
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
