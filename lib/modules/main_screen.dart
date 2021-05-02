import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/comming_soon.dart';
import 'package:shaboo/modules/main/feed/feed/views/feed_screen.dart';
import 'package:shaboo/modules/review/add/add_review_screen.dart';
import 'package:shaboo/modules/review/detail/detail_review_screen.dart';

import 'main/home/views/home_screen.dart';
import 'main/profile/views/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CommingSoonScreen(),
    FeedScreen(),
    CommingSoonScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.calendarMultipleCheck),
              label: 'Event',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.newspaper),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.bell),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kPrimaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
