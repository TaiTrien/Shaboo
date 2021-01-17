import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/model/user/user.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactController {
  BuildContext context;
  ContactController({this.context});

  // toPreviewPostScreen(PostModel postModel) => Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => PreviewPostScreen(id: postModel.id)));

  openMessenger(String username) async {
    print(username);
    await launch('https://m.me/$username');
  }

  toExit() => Navigator.pop(context);

  getInfoUser(String id) async => await UserModel.getGeneralInfoUser(id);
}
