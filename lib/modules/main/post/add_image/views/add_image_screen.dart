import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/modules/main/post/add_image/components/image_container.dart';
import 'package:shaboo/modules/main/post/components/note_board.dart';

import 'package:shaboo/components/stateless/bottom_button.dart';
import 'package:shaboo/constants/ui_constants.dart';

import 'package:shaboo/modules/main/post/add_image/controllers/add_image_controller.dart';

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
                    Text('Hình ảnh về sách', style: kTitleTextStyle),
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
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: 10.0),
                child: Container(
                    height: 150.0,
                    child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _controller.numberOfImages == 6 ? 6 : _controller.numberOfImages + 1,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ImageContainer(id: i),
                            );
                          },
                        );
                      },
                    )),
              ),
              NoteBoard(
                notes: [
                  TextSpan(text: 'Lưu ý:\n', style: kTitleTextStyle.copyWith(color: kPrimaryColor)),
                  TextSpan(
                    text: '\n- Chụp rõ nét chi tiết về sách của bạn.\n',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  TextSpan(
                    text: '\n- Hình ảnh nên rõ mặt bìa, mặt sau và gáy của sách .\n',
                    style: TextStyle(color: kPrimaryColor, fontSize: 18),
                  ),
                  TextSpan(
                    text: '\n- Hãy chụp trong điều kiện ánh sáng tốt để hình ảnh đẹp hơn.',
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
        title: 'Tiếp tục',
      ),
    );
  }
}
