import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shaboo/modules/loading/controllers/loading_controller.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = LoadingController(context: context);

    return ModalProgressHUD(
      inAsyncCall: true,
      child: Scaffold(
        body: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
