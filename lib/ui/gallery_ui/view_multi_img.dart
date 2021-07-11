import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/shared/bottom_navigationBar.dart';

class ViewImages extends StatelessWidget {

  final Color _colorAppbar = HexColor("02528A");
  List<NetworkImage> _listOfImages = <NetworkImage>[];

  Future<bool> deleteImageAlertDialog(
      BuildContext context, String imageSubCollectionID) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(
            'After clicking [yes] this image folder will be deleted forever from gallery, do you really want to delete this gallery folder?',
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
                  //for(int i=0;i<_listOfImages.length;i++){
                  //}
                  Firestore.instance
                      .collection('images')
                      .document(imageSubCollectionID)
                      .delete();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /*

   String storageUrl = "Chat-Images/1498804025000.png";
 StorageReference storageReference = FirebaseStorage.getInstance().getReference().child(storageUrl);
 storageReference.delete().addOnSuccessListener(new OnSuccessListener<Void>() {
      @Override
      public void onSuccess(Void aVoid) {
           // File deleted successfully
           Log.d(TAG, "onSuccess: deleted file");
      }
      }).addOnFailureListener(new OnFailureListener() {
      @Override
      public void onFailure(@NonNull Exception exception) {
            // Uh-oh, an error occurred!
            Log.d(TAG, "onFailure: did not delete file");
         }
      });

   */

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('images').orderBy('Date',descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        _listOfImages = [];
                        for (int i = 0;
                            i <
                                snapshot
                                    .data.documents[index].data['urls'].length;
                            i++) {
                          _listOfImages.add(NetworkImage(
                              snapshot.data.documents[index].data['urls'][i]));
                        }
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 2.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 20,
                                    child: Text(
                                      " Event Name : ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text(
                                      snapshot.data.documents[index]
                                          .data['eventName'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text(
                                      snapshot
                                          .data.documents[index].data['Date'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.0, top: 2.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 20,
                                    child: Text(
                                      " Description : ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text(
                                      snapshot.data.documents[index]
                                          .data['Description'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //  margin: EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.height / 1.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                  child: Carousel(
                                    boxFit: BoxFit.cover,
                                    images: _listOfImages,
                                    autoplay: false,
                                    indicatorBgPadding: 5.0,
                                    dotPosition: DotPosition.bottomCenter,
                                    animationCurve: Curves.fastOutSlowIn,
                                    animationDuration:
                                        Duration(milliseconds: 3000),
                                  ),
                                  onLongPress: () {
                                    deleteImageAlertDialog(
                                        context,
                                        snapshot
                                            .data.documents[index].documentID);
                                  }),
                            ),
                          ],
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
