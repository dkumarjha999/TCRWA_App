import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:tcrwa_app/shared/bottom_navigationBar.dart';
import 'package:tcrwa_app/ui/myinfo/myinfo_mainpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

class EditFamilyHeadProfile extends StatefulWidget {
  @override
  _EditFamilyHeadProfileState createState() => _EditFamilyHeadProfileState();
}

class _EditFamilyHeadProfileState extends State<EditFamilyHeadProfile> {
  Color _colorAppbar = HexColor("02528A");
  final _formKey = GlobalKey<FormState>(); // for form validation
  final dateFormat = DateFormat("d-MMM-yyyy");

  String _currentUid = '';
  String _name;
  String _email;
  String _mobileNo;
  String _birthday;
  String _bloodGroup;
  String _houseNumber;
  String _houseName;
  String _address;
  String _oldImageUrl;
  File _profileImage;
  String _uploadedProfileImageURL;

  Map<String, dynamic> documentFields;

  @override
  void initState() {
    super.initState();
    _getCurrentUid();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
      String authid = _currentUser.uid;
      print(authid);
      Firestore.instance
          .collection('userProfile')
          .document(_currentUid)
          .get()
          .then((ds) {
        if (ds.exists) {
          print(ds.data['userName']);
          setState(() {
            _name = ds.data['userName'].toUpperCase();
            _email = ds.data['email'];
            _mobileNo = ds.data['mobNo'];
            _birthday=ds.data['dob'];
            _bloodGroup= ds.data['bloodGroup'].toLowerCase();
            _houseNumber= ds.data['houseNo'];
            _houseName= ds.data['houseName'];
            _address= ds.data['address'];
            _oldImageUrl = ds.data['profileImageUrl'];
          });
        }
      });
    }catch (e) {
      print(e);
    }
  }

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = File(pickedFile.path);
      print(_profileImage.toString());
    });
  }

  /*
  Future getImage() async {
    var pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedFile;
      print(_profileImage.toString());
    });
  }
*/
  Future<bool> profileImageAlertDialog(
      BuildContext context, String msgContent) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(
            msgContent,
            style: TextStyle(color: _colorAppbar),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              color: Colors.green,
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> profileCreatedAlertDialog(
      BuildContext context, String msgContent) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(
            msgContent,
            style: TextStyle(color: _colorAppbar),
          ),
          contentPadding: EdgeInsets.all(10),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              color: Colors.green,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyBottomNavbar()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        mini: true,
        backgroundColor: _colorAppbar,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyProfile(),
            ),
          );
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            "Edit Family Head",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              //fontStyle: FontStyle.italic
            ),
          ),
        ),
        titleSpacing: -10.0,
        backgroundColor: _colorAppbar,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        children: <Widget>[
          Container(
            child: Form(
              key: _formKey, // to keep track of form values
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: _oldImageUrl != null && _profileImage ==null
                                  ? NetworkImage(
                                      _oldImageUrl,
                                    )
                                  : AssetImage(_profileImage.path),
                            ),
                            border:
                                Border.all(color: _colorAppbar, width: 3.0)),
                      ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: _name,
                    decoration: formFieldDecoration().copyWith(labelText:'Name'),
                    validator: (val) => val.isEmpty ? 'Enter your Name' : null,
                    onChanged: (val) {
                      setState(() {
                        _name = val;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: _mobileNo,
                    keyboardType: TextInputType.number,
                    decoration: formFieldDecoration()
                        .copyWith(labelText: 'Phone Number',),
                    validator: (val) {
                      if (val.length != 13) {
                        return 'Not a valid Mob No with +91 ';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _mobileNo= val;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    initialValue: _email,
                    decoration:
                        formFieldDecoration().copyWith(labelText: 'Email'),
                    validator: (val) {
                      bool isValid = EmailValidator.validate(val);
                      if (isValid) {
                        return null;
                      } else {
                        return 'Enter a valid email';
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0,bottom: 3.0),
                    child: DateTimeField(
                      keyboardType: TextInputType.datetime,
                      format: dateFormat,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: _birthday,
                        filled: true,
                        // labelStyle: TextStyle(
                        //   color: Colors.white,
                        // ),
                      ),
                      onShowPicker: (context, currentValue) async {
                        final DateTime date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            _birthday = dateFormat.format(date).toString();
                          });
                        }
                        return date;
                      },
                    ),
                  ),
                  TextFormField(
                    initialValue: _bloodGroup,
                    decoration:
                        formFieldDecoration().copyWith(labelText: 'Blood Group'),
                    validator: (val) {
                      if (val.length > 3) {
                        return 'Enter a valid Blood Group';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _bloodGroup= val.toUpperCase();
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: _houseNumber,
                    decoration: formFieldDecoration()
                        .copyWith(labelText: 'House Number'),
                    validator: (val) {
                      if (val.length > 5) {
                        return "Enter Valid House Number";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _houseNumber = val;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: _houseName,
                    decoration:
                        formFieldDecoration().copyWith(labelText: 'House Name'),
                    validator: (val) =>
                        val.isEmpty ? 'Enter a house name' : null,
                    onChanged: (val) {
                      setState(() {
                        _houseName = val;
                      });
                    },
                  ),
                  TextFormField(
                    decoration:
                        formFieldDecoration().copyWith(labelText: 'Address'),
                    initialValue: _address,
                    validator: (val) =>
                        val.isEmpty ? 'Enter your address' : null,
                    onChanged: (val) {
                      setState(() {
                        _address = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _formKey.currentState.save();
                          });
                          if (_profileImage != null) {
                            _uploadHeadMemberProfile(_profileImage);
                          }
                          else if(_profileImage==null){
                            _uploadHeadMemberProfileWithoutUploadingNewImage();
                          }
                          else {
                            profileImageAlertDialog(context,
                                'Hi $_name please select profile image,you have provide a profile image');
                          }

                          // _getCurrentUid();
                          // print(_currentUid);
                        }

                        // _formKey.currentState.dispose();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

/*
  Future<bool> _uploadProfileImage(var _profileImage) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref().child('ProfileImg')
        .child('${Path.basename(_profileImage.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_profileImage);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedProfileImageURL = fileURL;
      });
    });
    if (_uploadedProfileImageURL != null) {
      print('Profile Image Uploaded');
      return true;
    }
    return false;
  }
  */

  Future<String> _getCurrentUid() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _currentUid = user.uid.toString();
    });
    return _currentUid;
  }

  Future<void> _uploadHeadMemberProfile(_profileImage) async {
    _getCurrentUid();
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('ProfileImg')
        .child('${Path.basename(_profileImage.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_profileImage);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    setState(() {
      _uploadedProfileImageURL = url.toString();
    });
    if (_uploadedProfileImageURL != null) {
      print('Profile Image Uploaded');
      DateTime _current = DateTime.now();
      var _curDayTime = DateFormat('d- MMM-yyyy').format(_current).toString();
      //String documentID = DateTime.now().millisecondsSinceEpoch.toString();
      print(_currentUid);
      Firestore.instance
          .collection('userProfile')
          .document(_currentUid)
          .setData({
        'profileImageUrl': _uploadedProfileImageURL,
        'userName': _name.toLowerCase(),
        'mobNo': _mobileNo,
        'email': _email,
        'dob': _birthday,
        'bloodGroup': _bloodGroup,
        'houseNo': _houseNumber,
        'houseName': _houseName,
        'address': _address,
        'lastUpdateOn': _curDayTime,
      },merge: true).then((_) {
        print('Profile Updated with image');
        profileCreatedAlertDialog(
            context, 'Hi ${_name.toLowerCase()} your profile has been updated successfully');
      }).catchError((e) {
        print(e);
        profileCreatedAlertDialog(context,
            'Hi ${_name.toLowerCase()} something went wrong,please check your mobile network and try again');
      });
    } else {
      _uploadHeadMemberProfile(_profileImage);
    }
  }

  Future<void> _uploadHeadMemberProfileWithoutUploadingNewImage() async {
    _getCurrentUid();
      print('uploading profile without image');
    DateTime _current = DateTime.now();
    var _curDayTime = DateFormat('d- MMM-yyyy').format(_current).toString();
    //String documentID = DateTime.now().millisecondsSinceEpoch.toString();
    print(_currentUid);
    Firestore.instance
        .collection('userProfile')
        .document(_currentUid)
        .setData({
      'userName': _name.toLowerCase(),
      'mobNo': _mobileNo,
      'email': _email,
      'dob': _birthday,
      'bloodGroup': _bloodGroup,
      'houseNo': _houseNumber,
      'houseName': _houseName,
      'address': _address,
      'lastUpdateOn': _curDayTime,
    },merge: true).then((_) {
      print('Profile updated without image');
      profileCreatedAlertDialog(
          context, 'Hi ${_name.toLowerCase()} your profile has been updated successfully');
    }).catchError((e) {
      print(e);
      profileCreatedAlertDialog(context,
          'Hi ${_name.toLowerCase()} something went wrong,please check your mobile network and try again');
    });
  }


  formFieldDecoration() {
    return InputDecoration(
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0)),
        labelStyle: TextStyle(
          color: _colorAppbar,
        ));
  }
}
