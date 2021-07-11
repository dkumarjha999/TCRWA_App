import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/shared/bottom_navigationBar.dart';
import 'package:tcrwa_app/ui/myinfo/add_New_Member.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcrwa_app/ui/myinfo/add_main_member_profile.dart';
import 'package:tcrwa_app/ui/myinfo/edit_family_member_profile.dart';
import 'package:tcrwa_app/ui/myinfo/edit_main_member_profile.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>
    with SingleTickerProviderStateMixin {
  TabController controller;
  Color _colorAppbar = HexColor("02528A");

  //  var firebaseUser = await FirebaseAuth.instance.currentUser();
  // Firestore.instance.collection("userProfile").document(firebaseUser.uid).get().then((value){
  //  print(value.data); ---->> it print all collection value of user
  // }).catchError((e){});
  // return _currentUid

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _colorAppbar,
        titleSpacing: -10.0,
        /*
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.directions),
          ),
        ],

         */

        bottom: PreferredSize(
          preferredSize: Size(10, MediaQuery.of(context).size.height / 60),
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5,
            isScrollable: false,
            tabs: <Widget>[
              Tab(
               // icon: Icon(Icons.person),
                text: 'MyProfile',
              ),
              Tab(
                // icon: Icon(Icons.people),
                text: 'Family',
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          ProfileView(),
          FamilyView(),
        ],
      ),
    );
  }
}

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _currentUid = '';
  Color _colorAppbar = HexColor("02528A");

  Future<String> _getCurrentUid() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _currentUid = user.uid.toString();
    });
    //  var firebaseUser = await FirebaseAuth.instance.currentUser();
    // Firestore.instance.collection("userProfile").document(firebaseUser.uid).get().then((value){
    //  print(value.data); ---->> it print all  value of user
    // }).catchError((e){});
    // return _currentUid;

    return _currentUid;
  }

  Future<bool> showMemberProfileImageAlertDialog(
      BuildContext context, String profileUrl, String userName) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var _height = MediaQuery.of(context).size.height;
        return AlertDialog(
          title: Text(
            userName,
            style: TextStyle(color: _colorAppbar),
          ),
          content: Container(
            height: _height - 400,
            // child: documentFields['profileImageUrl'] != null
            //   ? Image.network(documentFields['profileImageUrl'],fit:BoxFit.cover,)
            // : Image.asset('images/profileImgNull.png'),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: profileUrl != null
                    ? NetworkImage(profileUrl)
                    : AssetImage('images/emptyProfileImage.png'),
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Stream<DocumentSnapshot> userProfileFieldStream() {
    return Firestore.instance
        .collection('userProfile')
        .document(_currentUid)
        .snapshots();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentUid();
    Color _colorAppbar = HexColor("02528A");
    //double _width = MediaQuery.of(context).size.width;
    //double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        mini: true,
        backgroundColor: _colorAppbar,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MyBottomNavbar()));
        },
      ),
      /*
      SpeedDial(
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyBottomNavbar(),
                  ),
                );
              },
              label: 'Back To Home',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelBackgroundColor: _colorAppbar),
          // FAB 2
          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: _colorAppbar,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FamilyHeadProfile(),
                  ),
                );
              },
              label: 'Your Profile',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelBackgroundColor: _colorAppbar),
        ],
      ),

      */

      // body:CircularProgressIndicator(),
      body: Container(
        child: _userProfileBody(),
      ),
    );
  }

  Widget _userProfileBody() {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('userProfile')
          .document(_currentUid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          //snapshot -> AsyncSnapshot of DocumentSnapshot
          //snapshot.data -> DocumentSnapshot
          //snapshot.data.data -> Map of fields that you need :)
          Map<String, dynamic> documentFields = snapshot.data.data;
          if (documentFields != null) {
            return ListView(
              //Center(child: CircularProgressIndicator()),
              children: <Widget>[
                Container(
                  child: Stack(
                    overflow: Overflow.visible,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: _height / 2.5,
                              width: _width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'images/profile-background-image.jpg'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: _height / 10,
                        child: FlatButton(
                          child: Container(
                            height: 110.0,
                            width: 110.0,
                            // child: documentFields['profileImageUrl'] != null
                            //   ? Image.network(documentFields['profileImageUrl'],fit:BoxFit.cover,)
                            // : Image.asset('images/profileImgNull.png'),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: documentFields['profileImageUrl'] != null
                                    ? NetworkImage(
                                        documentFields['profileImageUrl'],
                                      )
                                    : AssetImage('images/profileImgNull.png'),
                              ),
                              border:
                                  Border.all(color: _colorAppbar, width: 2.0),
                            ),
                          ),
                          onPressed: () {
                            showMemberProfileImageAlertDialog(
                              context,
                              documentFields['profileImageUrl'],
                              documentFields['userName'],
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: _height / 3.8,
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  documentFields['userName'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              //SizedBox(width: 5.0,)
                            ],
                          ),
                        ),
                      ),
                      /*
                            Positioned(
                              top: _height / 3.7,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 1),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.height / 2.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.place, color: Colors.white),
                                      iconSize: 10.0,
                                    ),
                                    Text(
                                      "House,Opal Drive,Fox Milne,MK15 0ZR.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    //SizedBox(width: 5.0,)
                                  ],
                                ),
                              ),
                            ),
                            */
                      Align(
                        heightFactor: .5,
                        child: Container(
                          margin: EdgeInsets.only(left: _width - 50),
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: RawMaterialButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditFamilyHeadProfile()));
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.create,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                    backgroundColor: _colorAppbar,
                                  ),
                                  // shape: CircleBorder(),
                                  // elevation: 2.0,
                                  // fillColor: Color(0xff02528A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*
                      Positioned(
                        top: _height / 4.5,
                        left: _width / 2,
                        child: FlatButton(
                          child: Icon(
                            Icons.camera_alt,
                            size: 35,
                            color: Colors.white,
                          ),

                        ),
                      )
                      */
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _width / 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Email"),
                          SizedBox(
                            width: _width / 4,
                          ),
                          Expanded(child: Text(documentFields['email']))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _width / 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Mobile No"),
                          SizedBox(
                            width: _width / 3,
                          ),
                          Expanded(child: Text(documentFields['mobNo']))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _width / 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("BloodGroup"),
                          SizedBox(
                            width: _width / 2,
                          ),
                          Expanded(child: Text(documentFields['bloodGroup']))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _width / 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("DOB"),
                          SizedBox(
                            width: _width / 2,
                          ),
                          Expanded(child: Text(documentFields['dob']))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _width / 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("House Number"),
                          SizedBox(
                            width: _width / 2.3,
                          ),
                          Expanded(child: Text(documentFields['houseNo']))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _width / 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("House Name"),
                          SizedBox(
                            width: _width / 3,
                          ),
                          Expanded(child: Text(documentFields['houseName']))
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: _width / 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Address"),
                          SizedBox(
                            width: _width / 4,
                          ),
                          Expanded(
                              child: AutoSizeText(
                            documentFields['address'],
                            minFontSize: 12,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return _sampleProfileBody();
          }
        } else {
          return _sampleProfileBody();
        }
      },
    );
  }

  Widget _sampleProfileBody() {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return ListView(
      //Center(child: CircularProgressIndicator()),
      children: <Widget>[
        Container(
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: _height / 2.5,
                      width: _width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            AssetImage('images/profile-background-image.jpg'),
                      )),
                    ),
                  )
                ],
              ),
              Positioned(
                top: _height / 8,
                child: Container(
                  height: 90.0,
                  width: 90.0,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //  image: AssetImage('images/back.jpg'),
                      // ),
                      border: Border.all(color: Colors.white, width: 3.0)),
                ),
              ),
              Positioned(
                top: _height / 3.8,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Sample User Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      //SizedBox(width: 5.0,)
                    ],
                  ),
                ),
              ),
              /*
                            Positioned(
                              top: _height / 3.7,
                              child: Container(
                                padding: EdgeInsets.only(bottom: 1),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.height / 2.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.place,
                                          color: Colors.white),
                                      iconSize: 10.0,
                                    ),
                                    Text(
                                      "House,Opal Drive,Fox Milne,MK15 0ZR.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    //SizedBox(width: 5.0,)
                                  ],
                                ),
                              ),
                            ),
                            */
              Align(
                heightFactor: .4,
                child: Container(
                  margin: EdgeInsets.only(left: _width - 50),
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: RawMaterialButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FamilyHeadProfile()));
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          shape: CircleBorder(),
                          elevation: 2.0,
                          fillColor: Color(0xff02528A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
        ),
        Card(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Email"),
                  SizedBox(
                    width: _width / 3,
                  ),
                  Expanded(child: Text("araminta@gmail.com"))
                ],
              ),
            ),
          ),
        ),
        Card(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Mobile No"),
                  SizedBox(
                    width: _width / 3,
                  ),
                  Expanded(child: Text("+91 7736452245"))
                ],
              ),
            ),
          ),
        ),
        Card(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("BloodGroup"),
                  SizedBox(
                    width: _width / 2,
                  ),
                  Expanded(child: Text('B+'))
                ],
              ),
            ),
          ),
        ),
        Card(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Birthday"),
                  SizedBox(
                    width: _width / 3,
                  ),
                  Expanded(child: Text("27-August-2002"))
                ],
              ),
            ),
          ),
        ),
        Card(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("House Number"),
                  SizedBox(
                    width: _width / 2.2,
                  ),
                  Expanded(child: Text("80"))
                ],
              ),
            ),
          ),
        ),
        Card(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("House Name"),
                  SizedBox(
                    width: _width / 2.2,
                  ),
                  Expanded(child: Text("Sapna"))
                ],
              ),
            ),
          ),
        ),
        Card(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Address"),
                  SizedBox(
                    width: _width / 4,
                  ),
                  Expanded(
                      child: AutoSizeText(
                    'Unity Road, Thhrikkakara , Cochin-862021',
                    minFontSize: 12,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FamilyView extends StatefulWidget {
  @override
  _FamilyViewState createState() => _FamilyViewState();
}

class _FamilyViewState extends State<FamilyView> {
  Color _colorAppbar = HexColor("02528A");
  String _currentUid = '';

  Future<String> _getCurrentUid() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _currentUid = user.uid.toString();
    });
    return _currentUid;
  }

  Future<bool> profileImageAlertDialog(
      BuildContext context, String msgContent) {
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
            msgContent,
            style: TextStyle(color: _colorAppbar),
          ),
          // contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyProfile()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> memberProfileDeleteAlertDialog(
      BuildContext context, String msgContent, String userName) {
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
            msgContent,
            style: TextStyle(color: _colorAppbar),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
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
                  Firestore.instance
                      .collection('userProfile')
                      .document(_currentUid)
                      .collection('Family')
                      .document(userName)
                      .delete();
                  Navigator.of(context).pop();
                  profileImageAlertDialog(context,
                      '$userName profile has been deleted successfully from your family member');
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> memberProfileUpdateAlertDialog(
      BuildContext context, String msgContent, String _userName) {
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
            msgContent,
            style: TextStyle(color: _colorAppbar),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
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
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditFamilyMemberProfile(_userName)));
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> showMemberProfileImageAlertDialog(
      BuildContext context, String profileUrl, String userName) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var _height = MediaQuery.of(context).size.height;
        return AlertDialog(
          title: Text(
            userName,
            style: TextStyle(color: _colorAppbar),
          ),
          content: Container(
            height: _height - 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: profileUrl != null
                    ? NetworkImage(profileUrl)
                    : AssetImage('images/emptyProfileImage.png'),
              ),
            ),
          ),
          // contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUid();
  }

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    //  double _height=MediaQuery.of(context).size.height;
    print(_currentUid);

    return Scaffold(
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyBottomNavbar()));
              },
              label: 'Back To Home',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelBackgroundColor: _colorAppbar),
          // FAB 2
          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: _colorAppbar,
              onTap: () {
                if (Firestore.instance
                        .collection('userProfile')
                        .document(_currentUid)
                        .get()
                        .hashCode !=
                    null) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => InfoForm()));
                } else {
                  profileImageAlertDialog(context,
                      'Hi user please add family head profile then only you will be able to add family member profile');
                }
              },
              label: 'Add Member',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelBackgroundColor: _colorAppbar),
        ],
      ),
      body: _familyMembers(),
      /*

      */
    );
  }

  Widget _familyMembers() {
    var doc = Firestore.instance
        .collection('userProfile')
        .document(_currentUid)
        .collection('Family')
        .snapshots();
    return StreamBuilder(
        stream: doc,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: new CircularProgressIndicator());
          if (!snapshot.hasData) {
            profileImageAlertDialog(context,
                'Hi user please add family head profile then only you will be able to add family member profile');
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
              child: Center(
                child: Column(children: <Widget>[
                  Text(
                    " Alert",
                    style: TextStyle(
                        color: Colors.red, letterSpacing: 1.0, fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: MediaQuery.of(context).size.width / 5,
                        right: MediaQuery.of(context).size.width / 5),
                    child: Expanded(
                      child: Text(
                        "If you are new user please add MyProfile(i.e Family Head) then only you will be able to  add other members of your family",
                        style: TextStyle(
                            color: _colorAppbar,
                            letterSpacing: .5,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: CircularProgressIndicator(),
                  )
                ]),
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onLongPress: () {
                        memberProfileDeleteAlertDialog(
                            context,
                            'Do you really want to delete **[ ${snapshot.data.documents[index]['updatedName']} ]** from your family member ?',
                            snapshot.data.documents[index]['userName']);
                      },
                      onDoubleTap: () {
                        memberProfileUpdateAlertDialog(
                            context,
                            'Do you really want to update ${snapshot.data.documents[index]['updatedName']} profile ?',
                            snapshot.data.documents[index]['userName']);
                      },
                      child: Card(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 5.0, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                child: Container(
                                  height: 70.0,
                                  width: 70.0,
                                  // child: documentFields['profileImageUrl'] != null
                                  //   ? Image.network(documentFields['profileImageUrl'],fit:BoxFit.cover,)
                                  // : Image.asset('images/profileImgNull.png'),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: snapshot.data.documents[index]
                                                  ['profileImageUrl'] !=
                                              null
                                          ? NetworkImage(
                                              snapshot.data.documents[index]
                                                  ['profileImageUrl'])
                                          : AssetImage(
                                              'images/emptyProfileImage.png'),
                                    ),
                                    border: Border.all(
                                        color: _colorAppbar, width: 2.0),
                                  ),
                                ),
                                onTap: () {
                                  showMemberProfileImageAlertDialog(
                                      context,
                                      snapshot.data.documents[index]
                                          ['profileImageUrl'],
                                      snapshot.data.documents[index]
                                          ['updatedName']);
                                },
                              ),
                              /*
                                Container(
                                  height: 70.0,
                                  width: 70.0,
                                  // child: snapshot.data.documents[index]
                                  //            ['profileImageUrl'] !=
                                  //       null
                                  //   ? Image.network(snapshot.data.documents[index]
                                  //      ['profileImageUrl'])
                                  // : Image.asset('images/profileImgNull.png'),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      image: DecorationImage(
                                        image: snapshot.data.documents[index]
                                                    ['profileImageUrl'] !=
                                                null
                                            ? NetworkImage(snapshot.data
                                                .documents[index]['profileImageUrl'])
                                            : Image.asset(
                                                'images/profileImgNull.png'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                */
                              SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            snapshot.data.documents[index]
                                                ['updatedName'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            maxLines: 4,
                                          ),
                                        ),
                                        Expanded(
                                          child: AutoSizeText(
                                            ' (${snapshot.data.documents[index]['relation'].toUpperCase()})',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                            minFontSize: 10,
                                            maxFontSize: 15,
                                            maxLines: 4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Expanded(
                                            child: Text(
                                              'Mob : ${snapshot.data.documents[index]['mobNo']}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Expanded(
                                            child: Text(
                                              'Blood Group : ${snapshot.data.documents[index]['bloodGroup']}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          child: Expanded(
                                            child: Text(
                                              'DOB : ${snapshot.data.documents[index]['dob']}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'Email : ${snapshot.data.documents[index]['email']}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        });




    /*
    StreamBuilder(
        stream: Firestore.instance.document('userProfile/$_currentUid').collection('Family').getDocuments(),
        builder: (context,snapshot) {
          print(snapshot.data);
          if(! snapshot.hasData && snapshot.connectionState==ConnectionState.none) {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
              child: Center(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("No Member Added Yet"),
                  ),
                  CircularProgressIndicator()
                ]),
              ),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                print("3");
                return Card(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              height: 50.0,
                              width: 50.0,
                              child: Image.network(_defaultProfileImg),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                // image: DecorationImage(
                                // image: AssetImage('images/back.jpg'),
                                //fit: BoxFit.cover,
                                //  )
                              )),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'userName',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    '(Husband)',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Date of Birth:26-february',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Blood Group:B+',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Mob :9589322323',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
    */
  }
}

/*

family view

 ListView(
        //Center(child: CircularProgressIndicator(),),
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 50.0,
                        width: 50.0,
                        child: Image.network(_defaultProfileImg),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                           // image: DecorationImage(
                             // image: AssetImage('images/back.jpg'),
                              //fit: BoxFit.cover,
                          //  )
                )),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Brad pitt',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '(Husband)',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Date of Birth:26-february',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Blood Group:B+',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Mob :9589322323',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('images/back.jpg'),
                              fit: BoxFit.cover,
                            ))),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Robert De Niro',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '(Son)',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Date of Birth:31-January',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Blood Group:AB+',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('images/back.jpg'),
                              fit: BoxFit.cover,
                            ))),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Meryl Streep',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '(Mother)',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Date of Birth:21-april',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Blood Group:B-',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                          image: AssetImage('images/back.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'George Streep',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '(Son)',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: _width / 2.65,
                              child: Text(
                                'Date of Birth:11-January',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: _width / 2.65,
                              child: Text(
                                'Blood Group:B+',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('images/back.jpg'),
                              fit: BoxFit.cover,
                            ))),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Mathew Streep',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '(son)',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Date of Birth:31-January',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Blood Group:B+',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('images/back.jpg'),
                              fit: BoxFit.cover,
                            ))),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Kiara Streep',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '(daughter)',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Date of Birth:29-January',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Blood Group:B+',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('images/back.jpg'),
                              fit: BoxFit.cover,
                            ))),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Reenu Streep',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '(daughter)',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Date of Birth:31-January',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Blood Group:B+',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: AssetImage('images/back.jpg'),
                              fit: BoxFit.cover,
                            ))),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Biju Streep',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '(Son)',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Date of Birth:11-march',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2.65,
                              child: Text(
                                'Blood Group:B+',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),


 */

// Firestore.instance.collection('userProfile').document(_currentUid).snapshots()   // *** Main member
/*Scaffold(
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyBottomNavbar(),
                  ),
                );
              },
              label: 'Back To Home',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelBackgroundColor: _colorAppbar),
          // FAB 2
          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: _colorAppbar,
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FamilyHeadProfile(),),);
              },
              label: 'Your Profile',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              labelBackgroundColor: _colorAppbar),
        ],
      ),

      /*
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        mini: true,
        backgroundColor: _colorAppbar,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyBottomNavbar()));
        },
      ),
      */
      body: ListView(
        //Center(child: CircularProgressIndicator()),
        children: <Widget>[
          Container(
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: _height / 2.5,
                        width: _width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('images/profile-background-image.jpg'),
                        )),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: _height / 8,
                  child: Container(
                    height: 90.0,
                    width: 90.0,
                    child: Icon(Icons.person,size: 60,color: Colors.white,),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                       // image: DecorationImage(
                       //   fit: BoxFit.cover,
                       //  image: AssetImage('images/back.jpg'),
                      // ),
                        border: Border.all(color: Colors.white, width: 3.0)),
                  ),
                ),
                Positioned(
                  top: _height / 3.8,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Araminta",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                        //SizedBox(width: 5.0,)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: _height / 3.7,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 1),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.height / 2.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.place, color: Colors.white),
                          iconSize: 10.0,
                        ),
                        Text(
                          "House,Opal Drive,Fox Milne,MK15 0ZR.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                          ),
                        ),
                        //SizedBox(width: 5.0,)
                      ],
                    ),
                  ),
                ),
                Align(
                  heightFactor: .4,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width - 50),
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: RawMaterialButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.create,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            shape: CircleBorder(),
                            elevation: 2.0,
                            fillColor: _colorAppbar,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("House Number"),
                    SizedBox(
                      width: _width / 2.2,
                    ),
                    Expanded(child: Text("80"))
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("House Name"),
                    SizedBox(
                      width: _width / 2.2,
                    ),
                    Expanded(child: Text("Sapna"))
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Email"),
                    SizedBox(
                      width: _width / 3,
                    ),
                    Expanded(child: Text("araminta@gmail.com"))
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Mobile No"),
                    SizedBox(
                      width: _width / 3,
                    ),
                    Expanded(child: Text("+91 7736452245"))
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Birthday"),
                    SizedBox(
                      width: _width / 2,
                    ),
                    Expanded(child: Text("27-August"))
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(left: _width / 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Address"),
                    SizedBox(
                      width: _width / 4,
                    ),
                    Expanded(
                        child: AutoSizeText(
                      'Unity Road, Thhrikkakara , Cochin-862021',
                      minFontSize: 12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    */
