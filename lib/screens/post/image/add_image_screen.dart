import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';

import 'package:shaboo/components/bottom_button.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/image/add_image_controller.dart';
import 'package:shaboo/screens/post/image/components/image_container.dart';
import 'package:shaboo/screens/post/image/components/note_board.dart';

class AddImageScreen extends StatelessWidget {
  final PageController pageController;

  const AddImageScreen({Key key, this.pageController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AddImageController _controller = AddImageController(context: context, pageController: pageController);

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
                    BlocBuilder<PostBloc, PostState>(
                      builder: (context, state) {
                        return Text(
                          '${_controller.numberOfImages}/6',
                          style: kTitleTextStyle.copyWith(fontWeight: FontWeight.normal, color: kGreyColor),
                        );
                      },
                    ),
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
                        return BlocBuilder<PostBloc, PostState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ImageContainer(
                                onPress: _controller.uploadImageFromCamera,
                                uploadedImage: _controller.getUpLoadedImages(i),
                              ),
                            );
                          },
                        );
                      },
                    )),
              ),
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
        onPress: _controller.handleUpdateCurrentPost,
        title: 'Next step',
      ),
    );
  }
}

//
