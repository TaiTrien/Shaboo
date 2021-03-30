import 'package:flutter/cupertino.dart';

class LazyLoadItem extends InheritedWidget {
  final dynamic itemData;
  final Widget child;

  LazyLoadItem({this.itemData, this.child});
  @override
  bool updateShouldNotify(covariant LazyLoadItem oldWidget) {
    return itemData != oldWidget.itemData;
  }

  static LazyLoadItem of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LazyLoadItem>();
  }
}
