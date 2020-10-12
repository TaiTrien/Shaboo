import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shaboo/routes.dart';
import 'package:shaboo/screens/on_boarding/on_boarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/onBoardingScren',
      routes: routes,
    );
  }
}
