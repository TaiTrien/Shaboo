import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/components/stateful/custom_textfield.dart';
import 'package:shaboo/components/stateful/date_time_picker.dart';
import 'package:shaboo/components/stateless/default_button.dart';
import 'package:shaboo/components/stateless/widget_with_label.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/updateInfo/update_contact.dart';
import 'package:shaboo/utils/notify.dart';

class UpdateGeneralInfo extends StatefulWidget {
  @override
  _UpdateGeneralInfoState createState() => _UpdateGeneralInfoState();
}

class _UpdateGeneralInfoState extends State<UpdateGeneralInfo> {
  var firstNameController;
  var lastNameController;
  UserBloc _userBloc;
  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    _userBloc = BlocProvider.of<UserBloc>(context);

    firstNameController.text = _userBloc.state.currentUser?.firstName;
    lastNameController.text = _userBloc.state.currentUser?.lastName;
  }

  handleUpdateGeneralInfo() {
    if (this.firstNameController.text.trim() == '') {
      Notify().error(message: 'Vui lòng điền họ của bạn');
    } else if (this.lastNameController.text.trim() == '') {
      Notify().error(message: 'Vui lòng điền tên của bạn');
    } else {
      _userBloc.state.currentUser.firstName =
          this.firstNameController.text.trim();
      _userBloc.state.currentUser.lastName =
          this.lastNameController.text.trim();

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => UpdateContactInfo()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cơ bản'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddingHorizontal,
            vertical: kDefaultPaddingVerical + 20),
        child: Container(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WidgetWithLabel(
                  label: 'Họ của bạn',
                  isRequired: true,
                  child: CustomTextField(
                    controller: firstNameController,
                    keyboard: TextInputType.emailAddress,
                    mainColor: kBorderColor,
                    labelText: 'VD: Nguyễn',
                  )),
              SizedBox(height: 20),
              WidgetWithLabel(
                label: 'Tên của bạn',
                isRequired: true,
                child: CustomTextField(
                  controller: lastNameController,
                  keyboard: TextInputType.emailAddress,
                  mainColor: kBorderColor,
                  labelText: 'VD: Như',
                ),
              ),
              SizedBox(height: 20),
              WidgetWithLabel(
                label: 'Sinh nhật của bạn',
                child: DateTimePicker(
                  onConfirmCallBack: (selectedDate) =>
                      _userBloc.state.currentUser.birthday = selectedDate,
                  maxDate: DateTime.now(),
                ),
              ),
              Spacer(),
              DefaultButton(
                text: 'Tiếp tục',
                onPress: () {
                  this.handleUpdateGeneralInfo();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
