import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class NoteBoard extends StatelessWidget {
  const NoteBoard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
