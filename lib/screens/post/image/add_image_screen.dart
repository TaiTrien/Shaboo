import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaboo/components/bottom_button.dart';

import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/image/add_image_controller.dart';
import 'package:shaboo/screens/post/image/components/fancy_fab.dart';
import 'package:shaboo/screens/post/image/components/image_list.dart';
import 'package:shaboo/screens/post/image/components/note_board.dart';

class AddImageScreen extends StatefulWidget {
  @override
  _AddImageScreenState createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  AddImageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AddImageController(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FancyFab(
      //   onAccessPhotos: _controller.handleUploadFromGallery,
      //   onAccessCamera: _controller.handleUploadFromCamera,
      // ),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: 10),
                child: Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DottedBorder(
                            color: Colors.black,
                            strokeWidth: 1,
                            child: Container(
                              height: 100,
                              width: 80,
                              child: IconButton(
                                icon: Icon(Icons.photo_camera, size: 50),
                                onPressed: _controller.onAccessCamera,
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ),
              //ImageList(onPress: _controller.onAccessCamera),
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
