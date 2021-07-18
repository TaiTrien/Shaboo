import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/components/stateful/custom_textfield.dart';
import 'package:shaboo/components/stateful/date_time_picker.dart';
import 'package:shaboo/components/stateless/avatar.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/components/stateless/widget_with_label.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/updateInfo/validator.dart';
import 'package:shaboo/utils/formatter.dart';
import 'package:shaboo/utils/notify.dart';
import 'package:shaboo/utils/photo.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var _firstNameController;
  var _lastNameController;
  var _phoneController;
  var _emailController;
  var _facebookLinkController;
  var _userBloc;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _facebookLinkController = TextEditingController();
    _userBloc = BlocProvider.of<UserBloc>(context);

    var _currentUser = _userBloc.state.currentUser;

    _firstNameController.text = _currentUser?.firstName;
    _lastNameController.text = _currentUser?.lastName;
    _phoneController.text = _currentUser?.phone;
    _emailController.text = _currentUser?.email;
    _facebookLinkController.text = _currentUser?.facebook;
  }

  handleUpdateInfo() {
    if (this._firstNameController.text.trim() == '') {
      Notify().error(message: 'Vui lòng điền họ của bạn');
    } else if (this._lastNameController.text.trim() == '') {
      Notify().error(message: 'Vui lòng điền tên của bạn');
    } else if (this._emailController.text.trim() == '') {
      Notify().error(message: 'Vui lòng nhập email của bạn');
    } else if (!Validator.isEmail(this._emailController.text.trim())) {
      Notify().error(message: 'Email không hợp lệ');
    } else if (this._phoneController.text.trim() == '') {
      Notify().error(message: 'Vui lòng nhập số điện thoại');
    } else if (!Validator.isPhoneNumber(this._phoneController.text.trim())) {
      Notify().error(message: 'Số điện thoại không hợp lệ');
    } else {
      var _currentUser = _userBloc.state.currentUser;

      _currentUser.firstName = this._firstNameController.text.trim();
      _currentUser.lastName = this._lastNameController.text.trim();
      _currentUser.email = this._emailController.text.trim();
      _currentUser.phone = this._phoneController.text.trim();
      _currentUser.facebook = this._facebookLinkController.text?.trim();
      _userBloc.add(EditUserInfo(_currentUser));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Cập nhật thông tin',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              this.handleUpdateInfo();
            },
            child: Text(
              'Lưu',
              style: kDefaultTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is EditSucceed) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is EditProcessing) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar(
                    //   avatarUrl: state.currentUser?.avatar,
                    //   onPress: () async {
                    //     PickedFile avatar = await Photo.getPhotoFromGallery();
                    //     _userBloc.add(UploadAvatar(File(avatar.path)));
                    //   },
                    // ),
                    SizedBox(height: 10),
                    WidgetWithLabel(
                        label: 'Họ của bạn',
                        isRequired: true,
                        child: CustomTextField(
                          controller: _firstNameController,
                          mainColor: kBorderColor,
                          labelText: 'VD: Võ',
                        )),
                    SizedBox(height: 20),
                    WidgetWithLabel(
                      label: 'Tên của bạn',
                      isRequired: true,
                      child: CustomTextField(
                        controller: _lastNameController,
                        mainColor: kBorderColor,
                        labelText: 'VD: Triển',
                      ),
                    ),
                    SizedBox(height: 20),
                    WidgetWithLabel(
                      label: 'Sinh nhật của bạn',
                      child: DateTimePicker(
                        onConfirmCallBack: (selectedDate) => _userBloc.state.currentUser.birthday = selectedDate,
                        maxDate: DateTime.now(),
                        initDate: state.currentUser?.birthday != null
                            ? Formatter.formateStringToDate(date: state.currentUser?.birthday)
                            : Formatter.formateStringToDate(date: DateTime.now().toString()),
                      ),
                    ),
                    SizedBox(height: 20),
                    WidgetWithLabel(
                        label: 'Email để liên hệ',
                        textColor: Colors.grey,
                        isRequired: true,
                        child: CustomTextField(
                          enabled: false,
                          controller: _emailController,
                          keyboard: TextInputType.emailAddress,
                          mainColor: kBorderColor,
                          labelText: 'VD: email@example.com',
                        )),
                    SizedBox(height: 20),
                    WidgetWithLabel(
                      textColor: Colors.grey,
                      label: 'Số điện thoại',
                      isRequired: true,
                      child: CustomTextField(
                        enabled: false,
                        controller: _phoneController,
                        keyboard: TextInputType.number,
                        mainColor: kBorderColor,
                        labelText: 'VD: 090******',
                      ),
                    ),
                    SizedBox(height: 20),
                    WidgetWithLabel(
                      textColor: Colors.grey,
                      label: 'Đường dẫn Facebook liên hệ',
                      child: CustomTextField(
                        enabled: false,
                        controller: _facebookLinkController,
                        mainColor: kBorderColor,
                        labelText: 'VD: www.facebook.com/example/',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
