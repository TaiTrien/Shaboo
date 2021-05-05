import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class NoteBoard extends StatelessWidget {
  final List<TextSpan> notes;
  final double paddingVertical, paddingHorizontal;

  const NoteBoard({
    Key key,
    @required this.notes,
    this.paddingVertical,
    this.paddingHorizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingVertical ?? kDefaultPaddingHorizontal,
          vertical: paddingVertical ?? 15.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor.withOpacity(0.8), width: 2),
          color: kLightblueColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
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
