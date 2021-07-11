import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/shared/bottom_navigationBar.dart';


class HelpLineNumbers extends StatefulWidget {
  @override
  _HelpLineNumbersState createState() => _HelpLineNumbersState();
}

class _HelpLineNumbersState extends State<HelpLineNumbers> {
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
     // drawer: sidebarBuilder(context),
      extendBodyBehindAppBar: false,
      backgroundColor: _colorAppbar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        mini: true,
        backgroundColor: _colorAppbar,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyBottomNavbar(),),);
        }
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _colorAppbar,
        titleSpacing: -10.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Helpline Numbers",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  //fontStyle: FontStyle.italic
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: txtPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Fire Station", style: txtHeaderStyle()),
                        )
                      ],
                    ),
                  ),
                ),
               Column(
                   children: <Widget>[
                     Padding(
                         padding: txtPadding(),
                         child: Row(
                           children: <Widget>[
                             Expanded(
                               child: Text("Fire and Rescue Station, Thrikkakara ",
                                   style: txtStyle()),
                             ),
                           ],
                         ),
                       ),
                   Padding(
                         padding: txtNumPadding(),
                         child: Row(
                           children: <Widget>[

                             Expanded(
                               child: Text("101, 0484-242 3100", style: txtStyle()),
                             ),
                           ],
                         ),
                     ),
                   ],
                 ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: txtPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Ambulance", style: txtHeaderStyle()),
                        )
                      ],
                    ),
                  ),
                ),
               Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("Thrikkakara Grama Panchayath ",
                                 style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "108, 0484-242 2383",
                               style: txtStyle(),
                             ),
                           )
                         ],
                       ),
                     ),
                   ],
                 ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: txtPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Hospital", style: txtHeaderStyle()),
                        )
                      ],
                    ),
                  ),
                ),
               Card(
                 child: Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("Sunrise Hospital ", style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "0484-2428913-16, 99460 01005",
                               style: txtStyle(),
                             ),
                           )
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               Card(
                 child: Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child:
                             Text("B&B Memorial Hospital ", style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[

                           Expanded(
                             child: Text("0484-283 0800 ", style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               Card(
                 child: Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("Kottakkal Arya Vaidya Sala, Kakkanad ",
                                 style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("0484-255 4000", style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               Card(
                 child: Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("Co-Operative Hospital, Thrikkakara ",
                                 style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("101, 0484-242 2383", style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("Kalamassery Medical College ",
                                 style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[

                           Expanded(
                             child: Text("0484-275 4000", style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: txtPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Police", style: txtHeaderStyle()),
                        )
                      ],
                    ),
                  ),
                ),
              Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: txtPadding(),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("Police Control Room ", style: txtStyle()),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: txtNumPadding(),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("100, 1090,112 ", style: txtStyle()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
           Card(
             child: Column(
               children: <Widget>[
                 Padding(
                   padding: txtPadding(),
                   child: Row(
                     children: <Widget>[
                       Expanded(
                         child: Text(
                           "Thrikkakara Police Station ",
                           style: txtStyle(),
                         ),
                       ),
                     ],
                   ),
                 ),
                 Padding(
                   padding: txtNumPadding(),
                   child: Row(
                     children: <Widget>[
                       Expanded(
                         child: Text(
                           "0484-242 3310",
                           style: txtStyle(),
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
               Card(
                 child: Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "Women Police Station ",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "0484-242 6010, 239 4250",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               Card(
                 child: Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "Police Bomb Squad ",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "0484-238 2352",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               Card(
                 child: Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "Women Safety Helpline ",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "1091",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
              Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "Pink Patrol ",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "1515",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: txtPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Gas Booking", style: txtHeaderStyle()),
                        )
                      ],
                    ),
                  ),
                ),
               Card(
                 child: Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("Bharat Gas ", style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("94462 56789", style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "Indane Gas ",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "99618 24365",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: txtPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Maintenance", style: txtHeaderStyle()),
                        )
                      ],
                    ),
                  ),
                ),
               Card(
                 child: Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("Electrician on Call ", style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text("98950 57388, 95447 83694 ",
                                 style: txtStyle()),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             Column(
                   children: <Widget>[
                     Padding(
                       padding: txtPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "Plumber on Call ",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Padding(
                       padding: txtNumPadding(),
                       child: Row(
                         children: <Widget>[
                           Expanded(
                             child: Text(
                               "97468 03453",
                               style: txtStyle(),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: txtPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("KSEB", style: txtHeaderStyle()),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: txtNumPadding(),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Complaint Booking ", style: txtStyle()),
                      ),
                      Expanded(
                        child: Text("0484-242 6614 ", style: txtStyle()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: txtPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child:
                              Text("Water Authority", style: txtHeaderStyle()),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: txtNumPadding(),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("KWA Contractor ", style: txtStyle()),
                      ),
                      Expanded(
                        child: Text("98464 38471 ", style: txtStyle()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: txtPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("TCRWA Quick Response Team",
                              style: txtHeaderStyle()),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: txtNumPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Jortin Antony ", style: txtStyle()),
                        ),
                        Expanded(
                          child: Text("98952 57777 ", style: txtStyle()),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: txtNumPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Hussain CS ", style: txtStyle()),
                        ),
                        Expanded(
                          child: Text("98954 47816 ", style: txtStyle()),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: txtNumPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Meethain( Meemikka) ", style: txtStyle()),
                        ),
                        Expanded(
                          child: Text("94470 50774 ", style: txtStyle()),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: txtNumPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Cyriac Ignatious ", style: txtStyle()),
                        ),
                        Expanded(
                          child: Text("94460 59758 ", style: txtStyle()),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: txtNumPadding(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Rekha Sinu ", style: txtStyle()),
                        ),
                        Expanded(
                          child: Text("94970 23198 ", style: txtStyle()),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: txtNumPadding(),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Usha Premnath ", style: txtStyle()),
                      ),
                      Expanded(
                        child: Text("94460 15631 ", style: txtStyle()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 45,
            child: Card(
              color: _colorAppbar,
              child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Image.asset('images/top-TCRWA-logo.png')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(context) {
    return Container();
  }

  txtStyle() {
    return TextStyle(fontSize: 13, color: Colors.black);
  }

  txtHeaderStyle() {
    return TextStyle(
      fontSize: 18,
      color: Colors.white,
    );
  }

  txtPadding() {
    return EdgeInsets.only(top: 5,);
  }

  txtNumPadding() {
    return EdgeInsets.only( top: 3, bottom: 7);
  }

  cardBorder() {
    return RoundedRectangleBorder(
      side: BorderSide(color: _colorAppbar, width: 1),
      borderRadius: BorderRadius.circular(30),
    );
  }
}
