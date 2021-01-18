import 'package:flutter/cupertino.dart';
import 'package:shaboo/api/book_api.dart';
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/model/post/category.dart';

class CategoryController {
  BuildContext context;
  CategoryController({this.context});

  Future<List<CategoryModel>> loadCategories() async {
    var response = await BookApi.getCategories(eOrder: EOrder.ASC);
    List<CategoryModel> categories;
    try {
      categories = CategoryModel.toList(response.data);
      return categories;
    } catch (e) {
      print(e);
    }
    return Future.value();
  }
}
