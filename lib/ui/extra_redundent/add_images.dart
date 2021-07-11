import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pPath;
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/shared/sidebar.dart';

class AddImages extends StatefulWidget {
  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  static const int tabletBreakpoint = 600; // >600 is tablet screen
  Color _colorAppbar = HexColor("02528A");
  File _takenImage;
  final _eventNameText = TextEditingController();
  final _descriptionText = TextEditingController();
  bool _eventNameValidate = false;
  bool _descriptionValidate = false;
  String _eventName;
  String _description;


  @override
  void dispose() {
    _eventNameText.dispose();
    _descriptionText.dispose();
    super.dispose();
  }

  final picker = ImagePicker();
  Future chooseFile() async {
    await picker.getImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _takenImage = File(image.path);
      });
    });
  }

  /*
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = File(pickedFile.path);
      print(_profileImage.toString());
    });
  }
  */


  Future<void> _takePicture(String _eventName, String _description) async {
    final appDir = await pPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(_takenImage.path);
     await _takenImage.copy('${appDir.path}/$fileName');
   // var _imageToStore = PictureModel(
   ///     eventName: _eventName, picName: savedImage, description: _description);
    _storeImage() {
    //  Provider.of<Pictures>(context, listen: false).storeImage(_imageToStore);
    }
    _storeImage();
  }

  /*   direct image upload

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('gallery/${path.basename(_takenImage.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_takenImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  */

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
              "Create Album",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                //fontStyle: FontStyle.italic
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            child: TextField(
              controller: _eventNameText,
              decoration: InputDecoration(
                labelText: 'Enter Event Name ',
                errorText:
                    _eventNameValidate ? ' Event Name Can\'t Be Empty' : null,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            child: TextField(
              controller: _descriptionText,
              decoration: InputDecoration(
                labelText: 'Description ',
                errorText:
                    _descriptionValidate ? 'Description Can\'t Be Empty' : null,
              ),
            ),
          ),
          _takenImage != null
              ? Image.asset(
            _takenImage.path,
            height: 180,
          )
         : Center(
            child: FlatButton.icon(
              icon: Icon(
                Icons.photo_camera,
                size: 100,
              ),
              label: Text(""),
              onPressed: () {
                chooseFile();
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top:10.0,bottom: 10),
              child: Center(
                child: Container(
                  height: 50,
                  width: 200,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _eventNameText.text.isEmpty
                            ? _eventNameValidate = true
                            : _eventNameValidate = false;
                        _eventName = _eventNameText.text;
                        _descriptionText.text.isEmpty
                            ? _descriptionValidate = true
                            : _descriptionValidate = false;
                        _description = _descriptionText.text;
                      });
                      _takePicture(_eventName, _description);
                    },
                    child: Text('Submit'),
                    textColor: Colors.white,
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      //side: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
            ),
          ),
        ],
      ),
      //bottomNavigationBar: bottomNavBAr(),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
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
              "Create Album",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                //fontStyle: FontStyle.italic
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            child: TextFormField(
              decoration: InputDecoration(
                  //.collapse to remove underline we can use
                  hintText: 'Event Name'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            child: TextFormField(
              decoration: InputDecoration(
                  //.collapse to remove underline we can use
                  hintText: 'Description'),
            ),
          ),
          Center(
            child: FlatButton.icon(
              icon: Icon(
                Icons.photo_camera,
                size: 100,
              ),
              label: Text(""),
              onPressed: () {
                chooseFile();
              },
            ),
          ),
          RaisedButton(
            textColor: Colors.white,
            color: Colors.pink,
            child: Text("Upload"),
            onPressed: () {
              // getImage();
              // _takePicture(_eventName, _description)
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              //side: BorderSide(color: Colors.red)),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: bottomNavBAr(),
    );
  }

/*
  void uploadImageGetUid() async {
    print("fun call ");

    FirebaseAuth _auth=FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;

    final database=FirebaseDatabase.instance.reference().child("User").child(uid);


    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child("myinfo/"+sampleImage.path
        ?.split("/")
        ?.last); // to get image name only
    final StorageUploadTask task =
    firebaseStorageRef.putFile(sampleImage);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String str = await taskSnapshot.ref.getDownloadURL();
    if (str!=null) {
      database.set({
        "downloadimgUrl":str
      });
      showAlertDialog(context);
    }
    else{
      print("Upload not done");
    }
    // here you write the codes to input the data into firestore
  }



 */

/*
  String sampleImage;

  Future getImage() async {
   // var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = 'iam.jpg';
    });
  }


  Widget _buildMobileLayout(BuildContext context) {
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
              "Create Album",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                //fontStyle: FontStyle.italic
              ),
            ),
          ],
        ),
      ),
      body:Form(
        child:  ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10,bottom: 5,left: 10,right: 10),
              child: TextFormField(
                decoration: InputDecoration(   //.collapse to remove underline we can use
                    hintText: 'Name'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10,bottom: 5,left: 10,right: 10),
              child: TextFormField(
                decoration: InputDecoration(   //.collapse to remove underline we can use
                    hintText: 'Description'
                ),
              ),
            ),

            /*
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4,
                  right: MediaQuery.of(context).size.width / 4,
                  top: 180),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.pink,
                child: Text("Select Images"),
                onPressed: () {
                  // getImage();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  //side: BorderSide(color: Colors.red)),
                ),
              ),
            ),

            */
          ],
        ),
      ),
      bottomNavigationBar: bottomNavBAr(),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
              "AddImages",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                //fontStyle: FontStyle.italic
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Center(
              child: sampleImage == null
                  ? Text("Please Select An Image")
                  : enableUpload(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 4,
                right: MediaQuery.of(context).size.width / 4,
                top: 150),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.pink,
              child: Text("Select An Image"),
              onPressed: () {
               // getImage();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)),
            ),
          ),
        ],
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add new image file ',
        child: Icon(Icons.add),
      ),

       */
    );
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        children: <Widget>[
          /*
          Image.file(
            sampleImage,
            height: MediaQuery.of(context).size.height ,
            width: MediaQuery.of(context).size.width,
          ),

           */
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: RaisedButton(
              elevation: 7.0,
              child: Text('Upload Image'),
              textColor: Colors.white,
              color: Colors.pink,
              onPressed: () {
               // uploadImageGetUid();
              },
            ),
          )
        ],
      ),
    );
  }


  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget remindButton = FlatButton(
        child: Text("Ok"),
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).pop(AddImages());
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Iamge Added"),
      content: SizedBox(
          child: Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50,
          )),
      actions: [
        remindButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget bottomNavBAr() {
    return (BottomNavigationBar(
      backgroundColor: _colorAppbar,
      type: BottomNavigationBarType.fixed,
      onTap: (newIndex) => setState(
            () => _index = newIndex,
      ),
      currentIndex: _index,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: Colors.white),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text(
              "MyInfo",
              style: TextStyle(color: Colors.white),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.folder,
              color: Colors.white,
            ),
            title: Text(
              "Gallery",
              style: TextStyle(color: Colors.white),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.announcement,
              color: Colors.white,
            ),
            title: Text(
              "Notices",
              style: TextStyle(color: Colors.white),
            )),
      ],
    ));

  }


 */
}
