import 'package:flutter/material.dart';
import 'package:shaboo/size_config.dart';

const kPrimaryColor = Color(0xFF0365B0);
const kSecondaryColor = Color(0xFFFF6824);
const kLightblueColor = Color(0xFFD6E3F3);
const kTitleColor = Color(0xFF334a68);
const kGreyColor = Color(0xFF979797);
const kGreenColor = Color(0xFF1D9800);
const kBorderColor = Color(0xFFBCBCBC);

const kAnimationDuration = Duration(milliseconds: 200);

final kHeadingTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final kTitleTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final kDefaultTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.normal,
  fontFamily: 'Helvetica Neue',
  color: Colors.black,
);

const kDefaultPaddingVerical = 15.0;
const kDefaultPaddingHorizontal = 20.0;
const defaultDuration = Duration(milliseconds: 250);

// Form Error
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

//ENUM
enum MenuValue {
  SETTINGS,
  SIGNOUT,
  EDIT,
  DELETE,
}

List<String> motionList = [
  'Cực kì không thích',
  'Không thích',
  'Bình thường',
  'Thích',
  'Rất thích',
];
