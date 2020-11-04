import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/auth/login/login_screen.dart';
import 'package:shaboo/screens/auth/sign_up/sign_up_screen.dart';
import 'package:shaboo/screens/home/home_screen.dart';
import 'package:shaboo/screens/notification/notification_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    LoginScreen(),
    SignupScreen(),
    NotificationScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: kPrimaryColor,
        inactiveIconColor: kSecondaryColor,
        textColor: kPrimaryColor,
        tabs: [
          TabData(iconData: MdiIcons.home, title: "Home"),
          TabData(iconData: MdiIcons.calendarMultipleCheck, title: "Events"),
          TabData(iconData: MdiIcons.bell, title: "Notifications"),
          TabData(iconData: Icons.account_circle, title: "Profile"),
        ],
        onTabChangedListener: (position) {
          setState(() {
            _selectedIndex = position;
          });
        },
      ),
    );
  }
}
