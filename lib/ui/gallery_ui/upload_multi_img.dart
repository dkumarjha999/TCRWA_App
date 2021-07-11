import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/shared/bottom_navigationBar.dart';

class UploadImages extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;

  const UploadImages({Key key, this.globalKey}) : super(key: key);

  @override
  _UploadImagesState createState() => new _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  Color _colorAppbar = HexColor("02528A");
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error detected';
  bool isUploading = false;

  final _eventNameText = TextEditingController();
  final _descriptionText = TextEditingController();
  bool _eventNameValidate = false;
  bool _descriptionValidate = false;
  String _eventName = '';
  String _description = '';

  @override
  void dispose() {
    _eventNameText.dispose();
    _descriptionText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(asset.getByteData(quality: 100));
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            // backgroundColor: MultiPickerApp.darker,
            // backgroundDarkerColor: MultiPickerApp.darker,
            height: 50,
            width: 50,
            //  borderDarkerColor: MultiPickerApp.pauseButton,
            //  borderColor: MultiPickerApp.pauseButtonDarker,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            ),
          ),
        );
      }),
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
              builder: (context) => MyBottomNavbar(),
            ),
          );
        },
        tooltip: 'Back',
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: _eventNameText,
                    decoration: InputDecoration(
                      labelText: 'Event Name ',
                      suffixIcon: IconButton(
                        onPressed: () => _eventNameText.clear(),
                        icon: Icon(Icons.clear),
                      ),
                      errorText: _eventNameValidate
                          ? 'Event Name Can\'t Be Empty'
                          : null,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: _descriptionText,
                    decoration: InputDecoration(
                      labelText: 'Description ',
                      suffixIcon: IconButton(
                        onPressed: () => _descriptionText.clear(),
                        icon: Icon(Icons.clear),
                      ),
                      errorText: _descriptionValidate
                          ? 'Description Can\'t Be Empty'
                          : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: loadAssets,
                      child: Container(
                        width: 130,
                        height: MediaQuery.of(context).size.height/12,
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            "Pick images", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (images.length == 0) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey[900],
                                  content: Text("No image selected",
                                      style: TextStyle(color: Colors.white)),
                                  actions: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 30,
                                        //  backgroundColor: MultiPickerApp.navigateButton,
                                        //  backgroundDarkerColor: MultiPickerApp.background,
                                        child: Center(
                                            child: Text(
                                          "Ok",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    )
                                  ],
                                );
                              });
                        } else {
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
                          SnackBar snackbar = SnackBar(
                              content: Text('Please wait,uploading Images'));
                          widget.globalKey.currentState.showSnackBar(snackbar);
                          uploadImages(_eventName, _description);
                        }
                      },
                      child: Container(
                        width: 130,
                        height: MediaQuery.of(context).size.height/12,
                        color: _colorAppbar,
                        // backgroundColor: MultiPickerApp.navigateButton,
                        //  backgroundDarkerColor: MultiPickerApp.background,
                        child: Center(
                          child: Text(
                            "Upload Images",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: buildGridView(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void uploadImages(String _eventName, String _description) {
    DateTime _current = DateTime.now();
    var _curDayTime = DateFormat(', d- MMM-yyyy').format(_current);
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          String documentID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance.collection('images').document(documentID).setData({
            'urls': imageUrls,
            'eventName': _eventName,
            'Description': _description,
            'Date': _curDayTime,
          }).then((_) {
            SnackBar snackBar =
                SnackBar(content: Text('Images Uploaded Successfully'));
            widget.globalKey.currentState.showSnackBar(snackBar);
            setState(() {
              _eventNameText.text = '';
              _descriptionText.text = '';
              images = [];
              imageUrls = [];
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print(resultList.length);
      await resultList[0].getThumbByteData(122, 100);
      await resultList[0].getByteData();
      await resultList[0].metadata;
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
   // print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }
}
