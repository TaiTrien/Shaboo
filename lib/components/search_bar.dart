import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingHorizontal,
              vertical: kDefaultPaddingVerical,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Tìm kiếm",
            hintStyle: TextStyle(fontSize: 16),
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
