import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/data/models/user/user.dart';
import 'package:shaboo/data/providers/remote/api/user_api.dart';
import 'package:shaboo/data/repositories/abstract/user/user_repo.dart';

class UserRepoImpl implements UserReposity {
  @override
  Future getInfoById({String id}) async {
    final response = await UserApi.getUserById(id);
    return UserModel.fromJson(response['data']);
  }

  @override
  Future updateProfile({UserModel user}) async {
    final response = await UserApi.editInfo(currentUser: user);
    return response;
  }

  @override
  Future uploadAvatar({ReviewModel review}) {
    // TODO: implement uploadAvatar
    throw UnimplementedError();
  }

  @override
  Future getMyProfile() async {
    final response = await UserApi.getMyProfile();
    return response;
  }
}
