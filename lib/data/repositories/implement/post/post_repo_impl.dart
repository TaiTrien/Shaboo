import 'package:shaboo/data/models/post/post.dart';
import 'package:shaboo/data/providers/remote/api/post_api.dart';
import 'package:shaboo/data/repositories/abstract/post/post_repo.dart';

class PostRepoImpl implements PostReposity {
  @override
  Future addPost({PostModel post}) async {
    var response = await PostApi.uploadPost(post: post);
    if (response != null) return response;
  }

  @override
  Future getPostById({int id}) async {
    final response = await PostApi.getPostById(id);
    if (response != null) return PostModel.fromJson(response['data']);
  }

  @override
  Future updatePost({PostModel post}) async {
    var response = await PostApi.updatePost(selectedPost: post);
    if (response != null) return response;
  }
}
