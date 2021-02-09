import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/shared_models/post/category.dart';
import 'package:shaboo/services/api/user_api.dart';

class UserModel {
  int _userID;
  String firstName;
  String lastName;
  String userName;
  String _password;
  String email;
  String phone;
  UserGender gender;
  String birthday;
  String avatar;
  String facebook;
  List<CategoryModel> categories;

  UserModel({
    int userID,
    this.firstName,
    this.lastName,
    this.userName,
    String password,
    this.email,
    this.phone,
    this.gender,
    this.birthday,
    this.avatar,
    this.facebook,
    this.categories,
  })  : _userID = userID,
        _password = password;

  Map<String, dynamic> toJson() => {
        'userID': _userID,
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'password': _password,
        'email': email,
        'phone': phone,
        'gender': gender,
        'birthday': birthday,
        'avatar': avatar,
        'categories': categories,
      };

  get userId => this._userID;
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userModel = UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      birthday: json['birthday'],
      avatar: json['avatar'],
      facebook: json['facebook'],
      categories: CategoryModel.toList(json['categories']),
    );
    userModel._userID = json['id'];
    return userModel;
  }

  static getGeneralInfoUser(String id) async {
    final response = await UserApi.getUserById(id);
    return UserModel.fromJson(response['data']);
  }
}
