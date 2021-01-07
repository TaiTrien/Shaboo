import 'package:flutter/cupertino.dart';

class DescriptionController {
  BuildContext context;
  TextEditingController titleController;
  TextEditingController descriptionController;

  DescriptionController({this.context}) {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }
}
