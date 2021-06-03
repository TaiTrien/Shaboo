import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/data/models/user/user.dart';
import 'package:shaboo/data/providers/remote/api/user_api.dart';
import 'package:shaboo/data/repositories/abstract/user/user_repo.dart';

class UserRepoImpl implements UserReposity {
  // @override
  // Future<dynamic> getUsers(
  //     {EOrder eOrder, int page, String bookId, String userId}) async {
  //   var response = await UserApi.getUsers(
  //       eOrder: eOrder ?? EOrder.ASC,
  //       page: page ?? 1,
  //       bookId: bookId ?? '',
  //       userId: userId ?? '');
  //   if (response != null)
  //     return ListUser.fromJson(response);
  //   else if (response == null) throw Exception('Fetching data error');
  // }

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
}
