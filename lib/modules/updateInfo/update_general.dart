import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/components/stateful/custom_textfield.dart';
import 'package:shaboo/components/stateful/date_time_picker.dart';
import 'package:shaboo/components/stateless/default_button.dart';
import 'package:shaboo/components/stateless/widget_with_label.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/updateInfo/update_contact.dart';

class UpdateGeneralInfo extends StatefulWidget {
  @override
  _UpdateGeneralInfoState createState() => _UpdateGeneralInfoState();
}

class _UpdateGeneralInfoState extends State<UpdateGeneralInfo> {
  var firstNameController;
  var lastNameController;
  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
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
                  onConfirmCallBack: (selectedDate) => print(selectedDate),
                ),
              ),
              Spacer(),
              DefaultButton(
                text: 'Tiếp tục',
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => UpdateContactInfo()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
