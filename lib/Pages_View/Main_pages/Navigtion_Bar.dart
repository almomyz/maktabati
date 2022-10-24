import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:maktabati2/Pages_View/Main_pages/Main_Page.dart';
import 'package:maktabati2/Pages_View/Main_pages/Publishing_Page.dart';
import 'package:maktabati2/const/Laoding.dart';
import 'package:maktabati2/const/constance.dart';

import 'Authors.dart';
import 'Categories_Page.dart';

class BottomNavBar extends StatefulWidget {
  final page;
  @override
  BottomNavBar({Key? key,this.page}) : super(key: key);
  _BottomNavBarState createState() => _BottomNavBarState();
}


class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 3;
  GlobalKey _bottomNavigationKey = GlobalKey();
   var Screens=[
   Publishing_Page(),
   Authors(),
   Categories_Page(),
   Main_Page(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 3,
          height: 50.0,
          items: const <Widget>[
            Icon(Icons.book, size: 30),
            Icon(Icons.people_alt_outlined, size: 30),
            Icon(Icons.dashboard, size: 30),
            Icon(Icons.home, size: 30),

          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: primary_Color,
          animationCurve: Curves.easeInOut,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: Screens[_page]);
  }
}