import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class SliverHeaderInfo extends StatelessWidget {
  final Color backgroundColor;
  final String userName;
  final String quote;

  SliverHeaderInfo({this.backgroundColor, this.userName, this.quote});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      floating: false,
      delegate: Delegate(backgroundColor: backgroundColor, userName: userName, quote: quote),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String userName;
  final String quote;

  Delegate({this.quote, this.backgroundColor, this.userName});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor ?? Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingHorizontal,
        vertical: kDefaultPaddingVerical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            userName,
            style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          Text(
            quote ?? 'Câu nói ưu thích',
            style: kDefaultTextStyle.copyWith(fontSize: 20),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
