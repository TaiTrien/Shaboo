import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shaboo/models/user/user.dart';
import 'package:shaboo/modules/main/feed/pop_contact/controllers/popup_contact_controller.dart';

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
                margin: EdgeInsets.only(top: 45.0),
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
                      'Việc đọc rất quan trọng. Nếu bạn biết cách đọc, cả thế giới sẽ mở ra cho bạn',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            color: Colors.green,
                            shape: CircleBorder(),
                            onPressed: () => _controller.openTel(userModel.phone),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                MdiIcons.phone,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            )),
                        FlatButton(
                            color: Colors.orange,
                            shape: CircleBorder(),
                            onPressed: () => _controller.openMessage(userModel.phone),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(MdiIcons.message, size: 25.0, color: Colors.white),
                            )),
                        FlatButton(
                            color: Colors.blue,
                            shape: CircleBorder(),
                            onPressed: () => _controller.openMessenger(userModel.facebook),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Icon(MdiIcons.facebookMessenger, size: 30.0, color: Colors.white),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                      imageUrl: userModel.avatar,
                      imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                      placeholder: (context, url) => Container(
                            child: Icon(MdiIcons.accountCircle),
                          ),
                      errorWidget: (context, url, error) => Image.asset(
                            'assets/icons/book-placeholder.png',
                            fit: BoxFit.cover,
                          ),
                      fit: BoxFit.cover),
                ],
              ),
            ],
          );
        });
  }
}
