import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';

class NotificationBoard extends StatelessWidget {
  final int itemCount;
  const NotificationBoard({
    Key key,
    @required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
            ),
          ),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Bella \n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Hello from the other side ...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          trailing: Text(
            '6:40',
            style: TextStyle(
              color: kGreyColor,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}
