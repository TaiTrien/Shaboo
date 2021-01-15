import 'package:shaboo/constants.dart';

class UserModel {
  int _userID;
  String firstName;
  String lastName;
  String userName;
  String _password;
  String role = "USER";
  String email;
  String phone;
  UserGender gender;
  String birthday;
  String avatar;

  UserModel({
    int userID,
    this.firstName,
    this.lastName,
    this.userName,
    String password,
    this.role,
    this.email,
    this.phone,
    this.gender,
    this.birthday,
    this.avatar,
  })  : _userID = userID,
        _password = password;

  Map<String, dynamic> toJson() => {
        'userID': _userID,
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'password': _password,
        'role': role,
        'email': email,
        'phone': phone,
        'gender': gender,
        'birthday': birthday,
        'avatar': avatar,
      };
}
