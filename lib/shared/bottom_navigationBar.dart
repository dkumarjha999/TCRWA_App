import 'package:flutter/material.dart';
import 'package:tcrwa_app/models/hex_rgb_color.dart';
import 'package:tcrwa_app/ui/gallery_ui/multi_img_home.dart';
import 'package:tcrwa_app/ui/home_page_ui/new_home.dart';
import 'package:tcrwa_app/ui/myinfo/myinfo_mainpage.dart';
import 'package:tcrwa_app/ui/notice_board_ui/notices.dart';

class MyBottomNavbar extends StatefulWidget {
  @override
  _MyBottomNavbarState createState() => _MyBottomNavbarState();
}

class _MyBottomNavbarState extends State<MyBottomNavbar> {
  Color _colorAppbar = HexColor("02528A");

  int _currentIndex = 0;
  final List<Widget> _children = [
    // passing pages in index wise
    NewHome(),
    MyProfile(),
    GalleryPage(),
    NoticeBoard()
  ];

  void onTappedBar(int index) {
    if (this.mounted) {
      super.setState(() {
        _currentIndex = index; // setting currntly tapped index value
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex], // calling page index to call it
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: _colorAppbar,
          type: BottomNavigationBarType.fixed,
          onTap: onTappedBar,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.red,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text(
                  "Home",
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text(
                  "MyInfo",
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.folder,
                ),
                title: Text(
                  "Gallery",
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.announcement,
                ),
                title: Text(
                  "Notices",
                )),
          ],
        ));
  }
}
