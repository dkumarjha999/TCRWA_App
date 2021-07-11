

import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/shared/sidebar.dart';
import 'package:tcrwa_app/ui/extra_redundent/add_images.dart';


class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}
class _GalleryState extends State<Gallery> {
  String img = 'images/diwali.gif';
  static const int tabletBreakpoint = 600; // >600 is tablet screen

  Color _colorAppbar = HexColor("02528A");

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
              "Gallery",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                //fontStyle: FontStyle.italic
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2.2),
              child: FlatButton(
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddImages()),
                  )
                },
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(top: 20, left: 10.0, right: 10.0, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: _colorAppbar)),
                  labelText: "Search",
                  hintText: "Event Name ",
                  prefixIcon: Icon(
                    Icons.search,
                    color: _colorAppbar,
                  ),
                  prefixText: ' ',
                  hintStyle: TextStyle(color: _colorAppbar, fontSize: 13.0),
                  labelStyle: TextStyle(
                      color: _colorAppbar, fontWeight: FontWeight.bold)),
              onChanged: (string) {},
            ),
          ),
          gridviewForMobile(context),
          Stack(
            children: <Widget>[
              gridviewForMobile(context),
              Positioned(
                right: 15,
                height: 400,
                width: 340,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: _colorAppbar,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddImages()),)
                  },
                  ),
                ),
              ),
              /*
              Positioned(
                right: 15,
                height: 340,
                width: 340,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: _colorAppbar,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                ),

               */
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
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
              "Gallery",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                //fontStyle: FontStyle.italic
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }

  Widget gridviewForMobile(context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Column(
      children: <Widget>[
        GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          crossAxisCount: 1,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: (itemWidth / itemHeight * 5.5),
          children: List.generate(8, (index) {
            return FlatButton(
              child: Card(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                image: DecorationImage(
                                  image: AssetImage(img),
                                  fit: BoxFit.cover,
                                ))),
                        SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Event : diwali',
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
                                  child: Text(
                                    'Venue : Near Model college',
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
                                    'Time : Diwali celebration from 6PM-8PM ',
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
                                    'Date : 16-November-2019',
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
              onPressed: () {},
            );
          }),
        ),
      ],
    );
  }
}
