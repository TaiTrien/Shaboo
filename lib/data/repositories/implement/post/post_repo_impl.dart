import 'package:shaboo/data/models/post/book.dart';
import 'package:shaboo/data/models/post/post.dart';
import 'package:shaboo/data/providers/remote/api/book_api.dart';
import 'package:shaboo/constants/api_constants.dart';
import 'package:shaboo/data/providers/remote/api/post_api.dart';
import 'package:shaboo/data/repositories/abstract/post/post_repo.dart';

class PostRepoImpl implements PostReposity {
  @override
  Future search({EOrder eOrder, int page, String bookName}) async {
    var response = await BookApi.searchBook(
        eOrder: eOrder ?? EOrder.ASC,
        page: page ?? 1,
        bookName: bookName ?? '');

    if (response != null) return ListBook.fromJson(response);
  }

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
