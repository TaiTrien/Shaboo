import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class ReviewsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPaddingHorizontal + 10,
        vertical: kDefaultPaddingVerical,
      ),
      child: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          title: Text(
            'Michael Jack',
            style: kHeadingTextStyle.copyWith(
              fontSize: 20,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
            maxLines: 3,
            style: kDefaultTextStyle.copyWith(fontSize: 18),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ),
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: kBorderColor,
          );
        },
      ),
    );
  }
}
