import 'package:flutter/material.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/modules/review/components/sliver_header_review.dart';
import 'package:shaboo/modules/review/edit/edit_review_screen.dart';

class DetailReviewScreen extends StatefulWidget {
  final ReviewModel selectedReview;

  const DetailReviewScreen({Key key, @required this.selectedReview}) : super(key: key);

  @override
  _DetailReviewScreenState createState() => _DetailReviewScreenState();
}

class _DetailReviewScreenState extends State<DetailReviewScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: NestedScrollView(
        body: Body(reviewContent: widget.selectedReview.review),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                floating: true,
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: size.height / 4,
                elevation: 0.0,
                title: Text('Chi tiết', style: kHeadingTextStyle),
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: [
                  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(height: constraints.maxHeight - 50);
                  }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                            child: Image.network(
                          widget.selectedReview.userModel.avatar,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return LoadingWidget(isImage: true);
                          },
                        ))),
                  )
                ])),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return EditReviewScreen(selectedReview: widget.selectedReview);
                      }));
                    },
                  ),
                ]),
            SliverHeaderView(
              userName: widget.selectedReview.userModel.firstName + ' ' + widget.selectedReview.userModel.lastName,
              score: widget.selectedReview.score.toDouble(),
            ),
          ];
        },
      ),
    ));
  }
}

class Body extends StatelessWidget {
  final String reviewContent;
  const Body({
    Key key,
    this.reviewContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tags', style: kHeadingTextStyle),
            SizedBox(height: 15),
            Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              children: [
                Chip(
                  label: Text('#Tieuthuyet', style: kDefaultTextStyle.copyWith(color: Colors.white)),
                  backgroundColor: kSecondaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                Chip(
                  label: Text('#laptrinh', style: kDefaultTextStyle.copyWith(color: Colors.white)),
                  backgroundColor: kSecondaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                Chip(
                  label: Text('#kinhdi', style: kDefaultTextStyle.copyWith(color: Colors.white)),
                  backgroundColor: kSecondaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                Chip(
                  label: Text('#lichsu', style: kDefaultTextStyle.copyWith(color: Colors.white)),
                  backgroundColor: kSecondaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              reviewContent,
              style: kDefaultTextStyle.copyWith(fontSize: 18),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
