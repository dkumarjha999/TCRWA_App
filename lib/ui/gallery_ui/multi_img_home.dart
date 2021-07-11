import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/ui/gallery_ui/upload_multi_img.dart';
import 'package:tcrwa_app/ui/gallery_ui/view_multi_img.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final _globalKey = GlobalKey<ScaffoldState>();
  Color _colorAppbar = HexColor("02528A");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _globalKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: _colorAppbar,
          automaticallyImplyLeading: false, // to remove back arrow
          bottom: PreferredSize(
            preferredSize: Size(10, MediaQuery.of(context).size.height / 60),
            //MediaQuery.of(context).size.height/25  takes length,width
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                tabs: [
                  Tab(
                   // icon: Icon(Icons.image),
                    text: 'Gallery',
                  ),
                  Tab(
                   // icon: Icon(Icons.cloud_upload,),
                    text: "Upload",
                  ),
                ],
                indicatorColor: Colors.red,
                indicatorWeight: 5.0,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ViewImages(),
            UploadImages(
              globalKey: _globalKey,
            ),
          ],
        ),
      ),
    );
  }
}
