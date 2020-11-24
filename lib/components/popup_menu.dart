import "package:flutter/material.dart";
import 'package:shaboo/constants.dart';

class PopupMenu extends StatelessWidget {
  final List<PopupMenuItem> items;
  final Function onSelect;

  const PopupMenu({Key key, this.items, this.onSelect}) : super(key: key);
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal - 5),
      child: PopupMenuButton<dynamic>(
        padding: EdgeInsets.all(0),
        child: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        itemBuilder: (context) => items,
        onSelected: onSelect,
      ),
    );
  }
}
