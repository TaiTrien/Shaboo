import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/loginScreen');
        },
        child: Text('Pressme'),
      ),
    );
  }
}
