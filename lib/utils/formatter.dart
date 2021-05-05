import 'package:intl/intl.dart';

class Formatter {
  static final _dateFormat = new DateFormat('dd-MM-yyyy');
  static formatDate({var date}) {
    return _dateFormat.format(date);
  }
}
