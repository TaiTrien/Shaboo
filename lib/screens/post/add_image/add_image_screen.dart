import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaboo/screens/post/add_image/add_image_controller.dart';
import 'package:shaboo/screens/post/add_image/components/fancy_fab.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/add_image/components/image_list.dart';
import 'package:shaboo/screens/post/add_image/components/note_board.dart';

class AddImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = AddImageController(context: context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _controller.toExit,
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          'Images',
          style: kHeadingTextStyle.copyWith(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text(
              'Next',
              style: kTitleTextStyle.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: FancyFab(
        onAccessPhotos: _controller.onAccessPhotos,
        onAccessCamera: _controller.onAccessCamera,
      ),
      body: Container(
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
            NoteBoard(),
          ],
        ),
      ),
    );
  }
}
