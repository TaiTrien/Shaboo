import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/review/detail/components/sliver_header_review.dart';

class DetailReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: NestedScrollView(
        body: Body(),
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
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      radius: 50,
                    ),
                  )
                ])),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ]),
            SliverHeaderView(
              userName: 'Michael Jack',
              score: 9.5,
            ),
          ];
        },
      ),
    ));
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
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
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
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
