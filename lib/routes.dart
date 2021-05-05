import 'package:path/path.dart';
import 'package:shaboo/modules/pick_category/views/category_screen.dart';
import 'package:shaboo/modules/loading/views/loading_screen.dart';
import 'package:shaboo/modules/main_screen.dart';
import 'package:shaboo/modules/on_boarding/views/on_boarding_screen.dart';
import 'package:shaboo/modules/updateInfo/update_contact.dart';

import 'modules/auth/login/views/login_screen.dart';
import 'modules/auth/sign_up/views/sign_up_screen.dart';
import 'modules/main/profile/views/profile_screen.dart';
import 'modules/updateInfo/update_general.dart';

final routes = {
  '/onBoardingScreen': (context) => OnBoardingScreen(),
  '/categoryScreen': (context) => CategoryScreen(),
  '/loginScreen': (context) => LoginScreen(),
  '/signupScreen': (context) => SignupScreen(),
  '/mainScreen': (context) => MainScreen(),
  '/profileScreen': (context) => ProfileScreen(),
  '/loadingScreen': (context) => LoadingScreen(),
  '/updateGeneralInfo': (context) => UpdateGeneralInfo(),
  '/updateContactInfo': (context) => UpdateContactInfo(),
};
