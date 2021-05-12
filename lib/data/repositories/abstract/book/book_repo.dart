import 'package:shaboo/constants/api_constants.dart';

abstract class BookReposity {
  Future<dynamic> search({EOrder eOrder, int page, String bookName});
}
