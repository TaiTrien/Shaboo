import 'package:shaboo/screens/auth/login/login_screen.dart';
import 'package:shaboo/screens/auth/sign_up/sign_up_screen.dart';
import 'package:shaboo/screens/category/category_screen.dart';
import 'package:shaboo/screens/loading/loading_screen.dart';
import 'package:shaboo/screens/main_screen.dart';
import 'package:shaboo/screens/on_boarding/on_boarding_screen.dart';
import 'package:shaboo/screens/profile/profile_screen.dart';

final routes = {
  '/onBoardingScreen': (context) => OnBoardingScreen(),
  '/categoryScreen': (context) => CategoryScreen(),
  '/loginScreen': (context) => LoginScreen(),
  '/signupScreen': (context) => SignupScreen(),
  '/mainScreen': (context) => MainScreen(),
  '/profileScreen': (context) => ProfileScreen(),
  '/loadingScreen': (context) => LoadingScreen(),
};
