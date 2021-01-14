import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaboo/components/bottom_button.dart';

import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/image/add_image_controller.dart';
import 'package:shaboo/screens/post/image/components/fancy_fab.dart';
import 'package:shaboo/screens/post/image/components/image_list.dart';
import 'package:shaboo/screens/post/image/components/note_board.dart';

class AddImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = AddImageController(context: context);

    return Scaffold(
      floatingActionButton: FancyFab(
        onAccessPhotos: _controller.onAccessPhotos,
        onAccessCamera: _controller.onAccessCamera,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
                child: Row(
                  children: [
                    Text('Your images', style: kTitleTextStyle),
                    SizedBox(width: 10),
                    Text('0/6', style: kTitleTextStyle.copyWith(fontWeight: FontWeight.normal, color: kGreyColor)),
                  ],
                ),
              ),
              ImageList(onPress: _controller.onAccessCamera),
              NoteBoard(
                notes: [
                  TextSpan(text: 'Notes:\n', style: kTitleTextStyle.copyWith(color: kPrimaryColor)),
                  TextSpan(
                    text: '\n- You should ensure your images about your book are clear.\n',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  TextSpan(
                    text: '\n- Your images should contain front cover, back cover and book information.\n',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  TextSpan(
                    text: '\n- Your images should describe book quality.',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPress: () {},
        title: 'Next step',
      ),
    );
  }
}
