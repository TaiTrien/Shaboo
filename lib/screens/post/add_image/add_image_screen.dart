import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shaboo/screens/post/add_image/add_image_controller.dart';
import 'package:shaboo/screens/post/add_image/components/fancy_fab.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/add_image/components/image_list.dart';

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
            ImageList(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: kDefaultPaddingHorizontal,
                  left: kDefaultPaddingHorizontal,
                  top: kDefaultPaddingVerical,
                  bottom: 100,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor.withOpacity(0.8), width: 2),
                    color: kSecondaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
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
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
