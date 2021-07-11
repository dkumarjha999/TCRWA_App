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

class EditFamilyMemberProfile extends StatefulWidget {
  final String _userId; // passing user id to its extended class
  const EditFamilyMemberProfile(this._userId);

  @override
  _EditFamilyMemberProfileState createState() =>
      _EditFamilyMemberProfileState();
}

class _EditFamilyMemberProfileState extends State<EditFamilyMemberProfile> {
  Color _colorAppbar = HexColor("02528A");
  final _formKey = GlobalKey<FormState>(); // for form validation
  final dateFormat = DateFormat("d-MMM-yyyy");
  final _updatedNameController=TextEditingController();
  final _phoneNumberController=TextEditingController();
  final _emailController=TextEditingController();
  final _bloodGroupController=TextEditingController();
  final _relationController=TextEditingController();
  String _currentUid = '';
  String _newName='';
  String _email='';
  String _mobileNo='';
  String _birthday='';
  String _bloodGroup='';
  String _relation='';
  String _oldImageUrl='';
  File _profileImage;
  String _uploadedProfileImageURL;

  Map<String, dynamic> documentFields;

  @override
  void initState() {
    super.initState();
    _getCurrentUid();    // first get current user id then only call fetch data
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      print("fetching data");
      print(widget._userId);
      FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
      String authid = _currentUser.uid;
      print(authid);
      Firestore.instance
          .collection('userProfile')
          .document(_currentUid)
          .collection('Family')
          .document(widget._userId)
          .get()
          .then((ds) {
        if (ds.exists) {
         setState(() {

           // controller for showing old values
           _updatedNameController.text = ds.data['updatedName'];
           _phoneNumberController.text=ds.data['mobNo'];
           ds.data['email'].isNotEmpty?_emailController.text=ds.data['email']:_emailController.text='xyz@gmail.com';
           _bloodGroupController.text=ds.data['bloodGroup'].toLowerCase();
           _relationController.text=ds.data['relation'].toLowerCase();

           //setting value as old value
           _newName = ds.data['updatedName'];
           ds.data['email'].isNotEmpty?_email = ds.data['email']:_email='xyz@gmail.com';
            _mobileNo = ds.data['mobNo'];
            _birthday = ds.data['dob'];
            _bloodGroup = ds.data['bloodGroup'];
            _relation = ds.data['relation'];
            _oldImageUrl = ds.data['profileImageUrl'];
          });
        }
      });
    } catch (e) {
      print("error");
      print(e);
    }
  }

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = File(pickedFile.path);
      print(_profileImage.toString());
      print(_newName);
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
            "Edit Family Member",
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
                              image:
                                  _oldImageUrl != null && _profileImage == null
                                      ? NetworkImage(
                                          _oldImageUrl,
                                        )
                                      : _profileImage == null
                                          ? AssetImage(
                                              'images/emptyProfileImage.png')
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
                    controller: _updatedNameController,
                    keyboardType: TextInputType.text,
                   // initialValue: _newName,
                    decoration:
                        formFieldDecoration().copyWith(labelText: 'Name'),
                    validator: (val) => val.isEmpty ? 'Enter your Name' : null,
                    onChanged: (val) {
                      setState(() {
                        _newName = val;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    // initialValue: _mobileNo,
                    keyboardType: TextInputType.number,
                    decoration: formFieldDecoration().copyWith(
                      labelText: 'Phone Number',
                    ),
                    validator: (val) {
                      if (val.length != 13) {
                        return 'Not a valid Mob No with +91';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _mobileNo = val;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                   // initialValue: _email,
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
                    padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
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
                    controller: _bloodGroupController,
                    //initialValue: _bloodGroup,
                    decoration: formFieldDecoration()
                        .copyWith(labelText: 'Blood Group'),
                    validator: (val) {
                      if (val.length > 3) {
                        return 'Enter a valid Blood Group';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _bloodGroup = val.toUpperCase();
                      });
                    },
                  ),
                  TextFormField(
                    controller: _relationController,
                    //initialValue: _relation,
                    decoration:
                        formFieldDecoration().copyWith(labelText: 'Relation'),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter a relation with family Head';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _relation = val.toUpperCase();
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
                            _uploadMemberProfile(_profileImage);
                          } else if (_profileImage == null) {
                            _uploadMemberProfileWithoutUploadingNewImage();
                          } else {
                            profileImageAlertDialog(context,
                                'Hi $_newName please select profile image,you have provide a profile image');
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

  Future<void> _uploadMemberProfile(_profileImage) async {
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
          .collection('Family')
          .document(widget._userId)
          .setData({
        'profileImageUrl': _uploadedProfileImageURL,
        'updatedName': _newName,
        'mobNo': _mobileNo,
        'email': _email,
        'dob': _birthday,
        'bloodGroup': _bloodGroup,
        'relation': _relation,
        'lastUpdateOn': _curDayTime,
      }, merge: true).then((_) {
        print('Profile Updated with image');
        profileCreatedAlertDialog(context,
            'Hi $_newName  Your profile has been updated successfully');
      }).catchError((e) {
        print(e);
        profileCreatedAlertDialog(context,
            'Hi $_newName something went wrong,please check your mobile network and try again');
      });
    } else {
      _uploadMemberProfile(_profileImage);
    }
  }

  Future<void> _uploadMemberProfileWithoutUploadingNewImage() async {
    _getCurrentUid();
    print('uploading profile without image');
    DateTime _current = DateTime.now();
    var _curDayTime = DateFormat('d- MMM-yyyy').format(_current).toString();
    //String documentID = DateTime.now().millisecondsSinceEpoch.toString();
    print(_currentUid);
    Firestore.instance
        .collection('userProfile')
        .document(_currentUid)
        .collection('Family')
        .document(widget._userId)
        .setData({
      'updatedName': _newName,
      'mobNo': _mobileNo,
      'email': _email,
      'dob': _birthday,
      'bloodGroup': _bloodGroup,
      'relation': _relation,
      'lastUpdateOn': _curDayTime,
    }, merge: true).then((_) {
      print('Profile updated without image');
      profileCreatedAlertDialog(
          context, 'Hi $_newName  Your profile has been updated successfully');
    }).catchError((e) {
      print(e);
      profileCreatedAlertDialog(context,
          'Hi $_newName something went wrong,please check your mobile network and try again');
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
