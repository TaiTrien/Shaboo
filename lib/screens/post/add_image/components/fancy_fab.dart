import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';

class FancyFab extends StatefulWidget {
  final Function onAccessCamera;
  final Function onAccessPhotos;

  FancyFab({this.onAccessCamera, this.onAccessPhotos});
  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _buttonColor = ColorTween(
      begin: kPrimaryColor,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        0.5,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.5,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    isOpened ? _animationController.reverse() : _animationController.forward();
    isOpened = !isOpened;
  }

  Widget camera() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: widget.onAccessCamera,
        tooltip: 'Add',
        child: Icon(Icons.photo_camera),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: widget.onAccessPhotos,
        tooltip: 'Image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        splashColor: Colors.transparent,
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: isOpened ? Icon(Icons.close) : Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: camera(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 1.0,
            0.0,
          ),
          child: image(),
        ),
        toggle(),
      ],
    );
  }
}
