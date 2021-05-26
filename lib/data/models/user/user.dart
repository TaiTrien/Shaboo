import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/data/models/model.dart';
import 'package:shaboo/data/models/post/category.dart';
import 'package:shaboo/data/providers/remote/api/user_api.dart';

class UserModel implements Model {
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
  bool isUpdatedInfo;
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
    this.isUpdatedInfo,
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
      isUpdatedInfo: json['isUpdatedInfo'],
    );
    userModel._userID = json['id'];
    return userModel;
  }

  static getGeneralInfoUser(String id) async {
    final response = await UserApi.getUserById(id);
    return UserModel.fromJson(response['data']);
  }

  //Getters & setters
  get userId => this._userID;
}
