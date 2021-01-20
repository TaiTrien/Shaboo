import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class ArticleNotFoundScreen extends StatelessWidget {
  final Function onPress;

  const ArticleNotFoundScreen({Key key, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: Image.asset(
                "assets/images/article_not_found.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.07,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 13),
                      blurRadius: 25,
                      color: Color(0xFF56B3C2).withOpacity(0.17),
                    ),
                  ],
                ),
                child: FlatButton(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  onPressed: onPress,
                  child: Text(
                    "Trở lại".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
