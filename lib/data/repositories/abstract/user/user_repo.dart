import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/data/models/user/user.dart';

abstract class UserReposity {
  Future<dynamic> updateProfile({UserModel user});

  Future<dynamic> uploadAvatar({ReviewModel review});

  Future<dynamic> getInfoById({String id});
}
