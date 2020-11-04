import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleSigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: new Container(
          decoration: new BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          child: WebView(
            userAgent: "random",
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'http://10.0.2.2:3001/auth/google',
          ),
        ),
      ),
    );
  }
}
