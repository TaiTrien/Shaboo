import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class SliverHeaderSection extends StatelessWidget {
  final Color backgroundColor;
  final String bookName;
  final String author;
  final double score;

  SliverHeaderSection(
      {this.backgroundColor, this.bookName, this.author, this.score});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: Delegate(
          backgroundColor: backgroundColor,
          bookName: bookName,
          author: author,
          score: score),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String bookName;
  final String author;
  final double score;

  Delegate({this.backgroundColor, this.bookName, this.author, this.score});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bookName,
            style: kHeadingTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                author,
                style: kDefaultTextStyle.copyWith(color: kGreyColor),
              ),
              // Text(
              //   '9.5/10',
              //   style: kDefaultTextStyle.copyWith(color: kSecondaryColor, fontWeight: FontWeight.bold),
              // )
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
