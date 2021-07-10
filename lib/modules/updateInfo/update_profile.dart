import 'package:flutter/material.dart';
import 'package:shaboo/components/stateful/custom_textfield.dart';
import 'package:shaboo/components/stateless/avatar.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/components/stateless/widget_with_label.dart';
import 'package:shaboo/constants/ui_constants.dart';

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

  final url =
      'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80';

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _facebookLinkController = TextEditingController();
    // _userBloc = BlocProvider.of<UserBloc>(context);

    // firstNameController.text = _userBloc.state.currentUser?.firstName;
    // lastNameController.text = _userBloc.state.currentUser?.lastName;
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
          onPressed: () {},
        ),
        actions: [
          TextButton(
            onPressed: () {},
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avatar(
                  avatarUrl: this.url,
                  onPress: () {},
                ),
                SizedBox(height: 10),
                WidgetWithLabel(
                    label: 'Họ của bạn',
                    isRequired: true,
                    child: CustomTextField(
                      controller: _firstNameController,
                      keyboard: TextInputType.emailAddress,
                      mainColor: kBorderColor,
                      labelText: 'VD: Võ',
                    )),
                SizedBox(height: 20),
                WidgetWithLabel(
                  label: 'Tên của bạn',
                  isRequired: true,
                  child: CustomTextField(
                    controller: _lastNameController,
                    keyboard: TextInputType.emailAddress,
                    mainColor: kBorderColor,
                    labelText: 'VD: Triển',
                  ),
                ),
                SizedBox(height: 20),
                WidgetWithLabel(
                    label: 'Email để liên hệ',
                    isRequired: true,
                    child: CustomTextField(
                      controller: _emailController,
                      keyboard: TextInputType.emailAddress,
                      mainColor: kBorderColor,
                      labelText: 'VD: email@example.com',
                    )),
                SizedBox(height: 20),
                WidgetWithLabel(
                  label: 'Số điện thoại',
                  isRequired: true,
                  child: CustomTextField(
                    controller: _phoneController,
                    keyboard: TextInputType.number,
                    mainColor: kBorderColor,
                    labelText: 'VD: 090******',
                  ),
                ),
                SizedBox(height: 20),
                WidgetWithLabel(
                  label: 'Đường dẫn Facebook liên hệ',
                  child: CustomTextField(
                    controller: _facebookLinkController,
                    keyboard: TextInputType.emailAddress,
                    mainColor: kBorderColor,
                    labelText: 'VD: www.facebook.com/example/',
                  ),
                ),
                SizedBox(height: 20),
                WidgetWithLabel(
                  label: 'Đường dẫn Facebook liên hệ',
                  child: CustomTextField(
                    controller: _facebookLinkController,
                    keyboard: TextInputType.emailAddress,
                    mainColor: kBorderColor,
                    labelText: 'VD: www.facebook.com/example/',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
