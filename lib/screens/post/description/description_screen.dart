import 'package:flutter/material.dart';
import 'package:shaboo/components/bottom_button.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/description/components/des_textfield.dart';
import 'package:shaboo/screens/post/description/description_controller.dart';
import 'package:shaboo/screens/post/image/components/note_board.dart';

class DescriptionScreen extends StatefulWidget {
  final PageController pageController;

  const DescriptionScreen({Key key, this.pageController}) : super(key: key);
  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  DescriptionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DescriptionController(context: context, pageController: widget.pageController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => _controller.outFocus(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
              child: Column(
                children: [
                  DescriptTextField(
                    maxLines: 1,
                    controller: _controller.titleController,
                    label: 'Post Title',
                  ),
                  SizedBox(height: 20),
                  DescriptTextField(
                    controller: _controller.descController,
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
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPress: _controller.handleUpdateCurrentPost,
        title: 'Next step',
      ),
    );
  }
}
