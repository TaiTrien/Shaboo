import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class DescriptTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const DescriptTextField({
    Key key,
    @required this.label,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.label, style: kTitleTextStyle),
          TextField(
            controller: this.controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
              isDense: true,
            ),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
