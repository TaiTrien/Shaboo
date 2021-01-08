import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/description/components/des_textfield.dart';
import 'package:shaboo/screens/post/description/description_controller.dart';
import 'package:shaboo/screens/post/image/components/note_board.dart';

class DescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = DescriptionController(context: context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
          child: Column(
            children: [
              DescriptTextField(
                controller: _controller.titleController,
                label: 'Post Title',
              ),
              SizedBox(height: 20),
              DescriptTextField(
                controller: _controller.descriptionController,
                label: 'Description',
              ),
              SizedBox(height: 20),
              NoteBoard(
                notes: [
                  TextSpan(text: 'Notes:\n', style: kTitleTextStyle.copyWith(color: kPrimaryColor)),
                  TextSpan(
                    text: '\n- You should write status of your book.\n',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  TextSpan(
                    text: '\n- Please describe your book and your expection as detailed as possible.\n',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  TextSpan(
                    text: '\n- PLEASE DO NOT TRY TO SALE ANYTHING.',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
