import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/utils/formatter.dart';

class DateTimePicker extends StatefulWidget {
  final Function onConfirmCallBack;
  final DateTime maxDate;
  final DateTime initDate;

  const DateTimePicker(
      {Key key, this.onConfirmCallBack, this.maxDate, this.initDate})
      : super(key: key);
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  var _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = Formatter.formatDate(date: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: kGreyColor),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
            ),
      ),
      child: ListTile(
        onTap: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            onConfirm: (date) {
              setState(() {
                _selectedDate = Formatter.formatDate(date: date);
              });
              widget.onConfirmCallBack(_selectedDate);
            },
            currentTime: widget.initDate ?? DateTime.now(),
            locale: LocaleType.vi,
            maxTime: widget.maxDate,
          );
        },
        leading: Icon(Icons.calendar_today),
        title: Text(_selectedDate.toString() ??
            Formatter.formatDate(date: widget.initDate)),
      ),
    );
  }
}
