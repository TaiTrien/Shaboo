import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/model/user/user.dart';
import 'package:shaboo/screens/post/components/loading_widget.dart';
import 'package:shaboo/screens/post/pop_contact/popup_contact_controller.dart';

class PopupContact extends StatefulWidget {
  final String userId;

  const PopupContact({Key key, this.userId}) : super(key: key);

  @override
  _PopupContactState createState() => _PopupContactState();
}

class _PopupContactState extends State<PopupContact> {
  ContactController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new ContactController(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return FutureBuilder(
        future: _controller.getInfoUser(widget.userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.connectionState != ConnectionState.done)
            return Center(child: CircularProgressIndicator());
          UserModel userModel = snapshot.data;
          return Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20.0, top: 45.0 + 20.0, right: 20.0, bottom: 20.0),
                margin: EdgeInsets.only(top: 40.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, offset: Offset(0, 10), blurRadius: 5),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '${userModel.lastName} ${userModel.firstName}',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'widget.descriptions',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                          onPressed: () => _controller.openMessenger(userModel.facebook),
                          child: Text(
                            'Nhắn tin',
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                right: 20.0,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 45.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(45.0)),
                    child: CachedNetworkImage(
                        imageUrl: userModel.avatar,
                        placeholder: (context, url) => Container(
                              height: 150.0,
                              width: 110.0,
                              child: LoadingWidget(
                                isImage: true,
                              ),
                            ),
                        errorWidget: (context, url, error) => Image.asset(
                              'assets/icons/book-placeholder.png',
                              fit: BoxFit.cover,
                              height: 150.0,
                              width: 110.0,
                            ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
