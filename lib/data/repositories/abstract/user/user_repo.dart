import 'dart:io';
import 'package:shaboo/data/models/user/user.dart';

abstract class UserReposity {
  Future<dynamic> getMyProfile();
  Future<dynamic> updateProfile({UserModel user});

  Future<dynamic> uploadAvatar({File avatar});

  Future<dynamic> getInfoById({String id});
}
