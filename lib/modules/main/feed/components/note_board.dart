import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class NoteBoard extends StatelessWidget {
  final List<TextSpan> notes;
  const NoteBoard({
    Key key,
    @required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: 15.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor.withOpacity(0.8), width: 2),
          color: kLightblueColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: kDefaultPaddingVerical + 5),
          child: RichText(
            text: TextSpan(
              children: this.notes,
            ),
          ),
        ),
      ),
    );
  }
}
