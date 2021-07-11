import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/shared/bottom_navigationBar.dart';
import 'package:tcrwa_app/ui/helpline_ui/helpline_numbers.dart';
import 'package:tcrwa_app/ui/gallery_ui/multi_img_home.dart';
import 'package:tcrwa_app/ui/myinfo/myinfo_mainpage.dart';
import 'package:tcrwa_app/ui/neighbour_ui/neighbor.dart';
import 'package:tcrwa_app/ui/notice_board_ui/notices.dart';

Widget sidebarBuilder(BuildContext context) {
  Color _colorAppbar = HexColor("02528A");
  return Drawer(
    child: Container(
      width: 50,
      color:_colorAppbar,
       child: ListView(
         children: <Widget>[
        /*
        UserAccountsDrawerHeader(
          accountName: Text("Deepak Kumar"),
          accountEmail: Text("deepak123@gmail.com"),
          currentAccountPicture: GestureDetector(
            onTap: () => print("This is deepak"),
            child: CircleAvatar(
                // backgroundImage: ,
                ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://cdn1.tripoto.com/media/filter/tst/img/1524784/Image/1569842291_kerala.jpg')),
          ),
          Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomeRoute()));

        ),
         */
        SizedBox(height: 15,),
        ListTile(
          title: Text("Home",style: TextStyle(color: colorStyle()),),
          trailing: Icon(Icons.home,color: colorStyle(),),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MyBottomNavbar()));
          },
        ),
           Divider(),
        ListTile(
          title: Text("My Info",style: TextStyle(color: colorStyle()),),
          trailing: Icon(Icons.person,color: colorStyle(),),

          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MyProfile()));
          },
        ),
           Divider(),
        ListTile(
          title: Text("Gallery",style: TextStyle(color: colorStyle()),),
          trailing: Icon(Icons.folder,color: colorStyle(),),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => GalleryPage()));
          },
        ),
           Divider(),
        ListTile(
          title: Text("Notices",style: TextStyle(color: colorStyle()),),
          trailing: Icon(Icons.announcement,color: colorStyle(),),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NoticeBoard()));
          },
        ),
           Divider(),
        ListTile(
          title: Text("Helpline",style: TextStyle(color: colorStyle()),),
          trailing: Icon(Icons.call,color: colorStyle(),),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HelpLineNumbers()));
          },
        ),
           Divider(),
        ListTile(
          title: Text("Neighbour",style: TextStyle(color: colorStyle()),),
          trailing: Icon(Icons.search,color: colorStyle(),),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Neighbour()));
          },
        ),
           Divider(),
        ListTile(
          title: Text("Settings",style: TextStyle(color: colorStyle()),),
          trailing: Icon(Icons.settings,color: colorStyle(),),
          onTap: () {
            //Navigator.of(context).pop();
            //Navigator.of(context).push(MaterialPageRoute(
               // builder: (BuildContext context) => Neighbour()));
          },
        ),
        /*
        ListTile(
          title: Text("Logout"),
          trailing: Icon(Icons.offline_pin),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Neighbour()));
          },
        ),
         */
        Divider(),
        ListTile(
            title: Text("Close",style: TextStyle(color: colorStyle()),),
            trailing: Icon(Icons.close,color: colorStyle(),),
            onTap: () {
              Navigator.of(context).pop();
            }),
      ],
    ),
      ),
  );
}

Color colorStyle(){
  final col=Colors.white;
  return col;
}
