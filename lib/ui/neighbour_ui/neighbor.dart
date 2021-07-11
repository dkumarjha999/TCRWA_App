import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/shared/bottom_navigationBar.dart';

class Neighbour extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NeighbourSearch();
  }
}

class _NeighbourSearch extends State<Neighbour> {
  Color _colorAppbar = HexColor("02528A");
  final _searchController = TextEditingController();
  String _nameForSearch;
  bool _isSearching = false;
  var queryResultSet = [];

  performSearch(String value) {
    setState(() {
      queryResultSet = [];
    });
    if (queryResultSet.length == 0 && value.length != 0) {
      Firestore.instance
          .collection('userProfile')
          .where('userName', isGreaterThanOrEqualTo: value)
          .where('userName', isLessThanOrEqualTo: value + '\uf8ff')
          .getDocuments()
          .then((QuerySnapshot doc) {
        for (int i = 0; i < doc.documents.length; i++) {
          queryResultSet.add(doc.documents[i].data);
         // print(doc.documents[i].data['userName']);
        }
       // print(queryResultSet.length);
      });
    }
  }

  Future<bool> showNeighbourProfileImageAlertDialog(
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

  /*
  Widget _getNeighbour(BuildContext context, String _nameForSearch) {
    if (queryResultSet.length == 0 || _nameForSearch.isEmpty) {
      print("Empty");
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      print("Data");
      return Expanded(
        child: ListView.builder(
          itemCount: queryResultSet.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 20,
                      top: 10,
                      bottom: 10),
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
                      SizedBox(width: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Raman Kumar',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 2.65,
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
            );
          },
        ),
      );
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        mini: true,
        backgroundColor: _colorAppbar,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyBottomNavbar(),
            ),
          );
        },
        tooltip: 'Back',
      ),
      // drawer: sidebarBuilder(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _colorAppbar,
        titleSpacing: -10.0,
        title: Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            "Neighbour",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              //fontStyle: FontStyle.italic
            ),
          ),
        ),
      ),
      body: ListView(
        //_getNeighbour(context, _nameForSearch));
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: _width / 25, left: _width / 50, right: _width / 50),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: _colorAppbar),
                  ),
                  hintText: 'Enter Name Here',
                  labelText: "Search People By Name",
                  prefixIcon: Icon(
                    Icons.search,
                    color: _colorAppbar,
                  ),
                  /*
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _nameForSearch = '';
                      });
                    },
                  ),
                  */
                  hintStyle: TextStyle(color: _colorAppbar, fontSize: 13.0),
                  labelStyle: TextStyle(
                      color: _colorAppbar, fontWeight: FontWeight.bold)),
              onChanged: (val) {
                setState(() {
                  _nameForSearch = val.toLowerCase();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                height: 50,
                child: RaisedButton(
                  color: Colors.red,
                  child: Text(
                    "Clear",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _nameForSearch = '';
                      _isSearching = false;
                    });
                  },
                ),
              ),
              Container(
                width: 100,
                height: 50,
                child: RaisedButton(
                  color: Colors.red,
                  child: Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_nameForSearch.isNotEmpty) {
                      print(_nameForSearch);
                      setState(() {
                        _searchController.text = _nameForSearch;
                        _isSearching = true;
                      });
                      performSearch(_nameForSearch);
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _isSearching == true
              ? queryResultSet.length > 0
                  ? GridView.count(
                      crossAxisCount: 1,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio: (_height / _width * 1.5),
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      primary: false,
                      children: queryResultSet.map((users) {
                        return buildSearchResult(users);
                      }).toList())
                  : Center(child: CircularProgressIndicator())
              : Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget buildSearchResult(user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
                    image: user['profileImageUrl'] != null
                        ? NetworkImage(user['profileImageUrl'])
                        : AssetImage('images/emptyProfileImage.png'),
                  ),
                  border: Border.all(color: _colorAppbar, width: 2.0),
                ),
              ),
              onTap: () {
                showNeighbourProfileImageAlertDialog(
                    context, user['profileImageUrl'], user['userName']);
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 50,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          user['userName'].toUpperCase(),
                          style: TextStyle(
                              fontSize: 13,
                              letterSpacing: .5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Phone No : ${user['mobNo']}',
                          style: TextStyle(
                              letterSpacing: .5,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'DOB : ${user['dob']}',
                          style: TextStyle(
                              letterSpacing: .5,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Blood Group : ${user['bloodGroup'].toUpperCase()}',
                          style: TextStyle(
                              fontSize: 12,
                              letterSpacing: .5,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Address : ${user['address']}',
                          style: TextStyle(
                              letterSpacing: .5,
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
    );
  }
}
