import 'package:flutter/material.dart';
import 'package:shaboo/components/stateful/custom_textfield.dart';
import 'package:shaboo/components/stateful/date_time_picker.dart';
import 'package:shaboo/components/stateless/default_button.dart';
import 'package:shaboo/components/stateless/widget_with_label.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/main/feed/components/note_board.dart';

class UpdateContactInfo extends StatefulWidget {
  @override
  _UpdateContactInfoState createState() => _UpdateContactInfoState();
}

class _UpdateContactInfoState extends State<UpdateContactInfo> {
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
        title: Text('Thông tin liên hệ'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Lưu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddingHorizontal,
            vertical: kDefaultPaddingVerical + 20),
        child: Container(
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                WidgetWithLabel(
                    label: 'Email để liên hệ',
                    isRequired: true,
                    child: CustomTextField(
                      controller: firstNameController,
                      keyboard: TextInputType.emailAddress,
                      mainColor: kBorderColor,
                      labelText: 'VD: email@example.com',
                    )),
                SizedBox(height: 20),
                WidgetWithLabel(
                  label: 'Số điện thoại',
                  isRequired: true,
                  child: CustomTextField(
                    controller: lastNameController,
                    keyboard: TextInputType.emailAddress,
                    mainColor: kBorderColor,
                    labelText: 'VD: 090******',
                  ),
                ),
                SizedBox(height: 20),
                WidgetWithLabel(
                  label: 'Đường dẫn Facebook liên hệ',
                  child: CustomTextField(
                    controller: lastNameController,
                    keyboard: TextInputType.emailAddress,
                    mainColor: kBorderColor,
                    labelText: 'VD: www.facebook.com/example/',
                  ),
                ),
                SizedBox(height: 40),
                NoteBoard(
                  paddingHorizontal: 0,
                  paddingVertical: 0,
                  notes: [
                    TextSpan(
                        text: 'Lưu ý:\n',
                        style: kTitleTextStyle.copyWith(color: kPrimaryColor)),
                    TextSpan(
                      text:
                          '\n- Những thông tin bạn cung cấp giúp thuận tiện liên lạc.\n',
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                    TextSpan(
                      text:
                          '\n- Chúng tôi không sử dụng nhằm những mục đích xấu.\n',
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
