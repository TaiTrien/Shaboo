import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/components/stateful/custom_textfield.dart';
import 'package:shaboo/components/stateful/date_time_picker.dart';
import 'package:shaboo/constants/ui_constants.dart';

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
        padding:
            const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
        child: Container(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetWithLabel(
                  label: 'Họ của bạn',
                  isRequired: true,
                  child: CustomTextField(
                    controller: firstNameController,
                    keyboard: TextInputType.emailAddress,
                    mainColor: kBorderColor,
                  )),
              SizedBox(height: 20),
              WidgetWithLabel(
                label: 'Tên của bạn',
                isRequired: true,
                child: CustomTextField(
                  controller: lastNameController,
                  keyboard: TextInputType.emailAddress,
                  mainColor: kBorderColor,
                ),
              ),
              SizedBox(height: 20),
              WidgetWithLabel(
                label: 'Sinh nhật của bạn',
                child: DateTimePicker(
                  onConfirmCallBack: (selectedDate) => print(selectedDate),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetWithLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  final Widget child;

  const WidgetWithLabel(
      {Key key,
      @required this.label,
      this.isRequired = false,
      @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$label ',
            style: TextStyle(color: Colors.black, fontSize: 18),
            children: [
              isRequired
                  ? TextSpan(text: '*', style: TextStyle(color: Colors.red))
                  : TextSpan(text: '')
            ],
          ),
        ),
        SizedBox(height: 5),
        child,
      ],
    );
  }
}
