import 'package:intl/intl.dart';

class Formatter {
  static final _dateFormat = new DateFormat('dd-MM-yyyy');
  static final _dateFormatForSignUp = new DateFormat('yyyy-MM-dd');
  static formatDate({var date}) {
    return _dateFormat.format(date);
  }

  static formateStringToDate({String date}) {
    return _dateFormat.parse(date);
  }

  static formatDateSignUp({var date}) {
    return _dateFormatForSignUp.format(date);
  }
}
