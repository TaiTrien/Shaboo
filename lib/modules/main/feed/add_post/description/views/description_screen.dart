import 'package:flutter/material.dart';
import 'package:shaboo/modules/main/feed/add_post/description/components/des_textfield.dart';
import 'package:shaboo/modules/main/feed/components/note_board.dart';
import 'package:shaboo/modules/main/feed/add_post/description/controllers/description_controller.dart';
import 'package:shaboo/components/stateless/bottom_button.dart';
import 'package:shaboo/constants/ui_constants.dart';

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
                  DescriptionTextField(
                    maxLines: 1,
                    controller: _controller.titleController,
                    label: 'Tiêu đề',
                  ),
                  SizedBox(height: 20),
                  DescriptionTextField(
                    controller: _controller.descController,
                    label: 'Mô tả bài đăng',
                  ),
                  SizedBox(height: 20.0),
                  NoteBoard(
                    notes: [
                      TextSpan(text: '*Lưu ý:\n', style: kTitleTextStyle.copyWith(color: kPrimaryColor)),
                      TextSpan(
                        text: '\n- Mô tả rõ ràng về tình trạng của sách.\n',
                        style: TextStyle(color: kPrimaryColor, fontSize: 18),
                      ),
                      TextSpan(
                        text: '\n- Hãy thêm mô tả về tựa sách mà bạn mong muốn được trao đổi.\n',
                        style: TextStyle(color: kPrimaryColor, fontSize: 18),
                      ),
                      TextSpan(
                        text: '\n- Nghiêm cấm bán hàng bằng mọi hình thức.',
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
        title: 'Tiếp tục',
      ),
    );
  }
}
