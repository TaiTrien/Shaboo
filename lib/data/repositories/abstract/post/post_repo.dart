import 'package:shaboo/data/models/post/post.dart';

abstract class PostReposity {
  Future<dynamic> addPost({PostModel post});
  Future<dynamic> updatePost({PostModel post});
  Future<dynamic> getPostById({int id});
}
