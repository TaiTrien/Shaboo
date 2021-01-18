import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/api/book_api.dart';
import 'package:shaboo/api/constants.dart';
import 'package:shaboo/api/user_api.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/model/post/category.dart';
import 'package:shaboo/model/user/user.dart';
import 'package:shaboo/utils/notify.dart';

class CategoryController {
  BuildContext context;
  UserBloc _userBloc;
  List<CategoryModel> selectedCategories;
  CategoryController({this.context}) {
    _userBloc = BlocProvider.of<UserBloc>(context);
    selectedCategories = List<CategoryModel>();
  }

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

  handleSelectCategories() async {
    if (categories.isEmpty) return Notify().error(message: "Vui lòng chọn ít nhất 1 thể loại");
    var response = await UserApi.editInfo(currentUser: currentUser);
    print(response);
  }

  updateSelectedCategories({CategoryModel selectCategory}) {
    selectedCategories = currentUser.categories;

    if (selectedCategories == null)
      selectedCategories = [selectCategory];
    else {
      var contains = categories.where((category) => category.categoryID == selectCategory.categoryID);
      if (contains.isNotEmpty)
        selectedCategories.removeWhere((category) => category.categoryID == selectCategory.categoryID);
      else
        selectedCategories.add(selectCategory);
    }
    //TODO: fix data here in User model after make edit info page
    UserModel _currentUser = UserModel(
      userID: userId ?? 'string',
      firstName: firstName ?? 'string',
      lastName: lastName ?? 'string',
      email: email ?? 'email@gmail.com',
      phone: phone ?? '0906839130',
      gender: gender ?? 'MALE',
      userName: userName ?? 'string',
      avatar: avatar ?? '',
      birthday: birthday ?? '1999-05-28',
      categories: selectedCategories,
    );
    _userBloc.add(UpdateUserData(_currentUser));
  }

  bool isSelected(CategoryModel selectCategory) {
    if (categories == null) return false;
    var contains = categories.where((category) => category.categoryID == selectCategory.categoryID);
    return contains.isNotEmpty;
  }

  get currentUser => _userBloc.state.currentUser;
  get userId => currentUser.userId;
  get firstName => currentUser.firstName;
  get lastName => currentUser.lastName;
  get userName => currentUser.userName;
  get email => currentUser.email;
  get phone => currentUser.phone;
  get gender => currentUser.gender;
  get birthday => currentUser.birthday;
  get facebook => currentUser.facebook;
  get avatar => currentUser.avatar;
  get categories => currentUser.categories;
  get numberOfSelectedCategories => currentUser.categories != null ? categories.length : 0;
}
