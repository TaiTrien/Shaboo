import 'package:flutter/material.dart';
import 'package:shaboo/components/stateless/default_button.dart';
import 'package:shaboo/constants/ui_constants.dart';

class EditReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Đánh giá của bạn',
          style: kHeadingTextStyle,
        ),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: ConstrainedBox(
      constraints: BoxConstraints(minHeight: size.height),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal, vertical: kDefaultPaddingVerical),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text('9.5',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 50,
                  )),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text('Cực kì thích', style: kDefaultTextStyle.copyWith(color: kGreyColor)),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: Slider(
                onChanged: (value) {
                  print(value);
                },
                value: 3,
                max: 10,
                min: 0,
                activeColor: kPrimaryColor,
              ),
            ),
            SizedBox(height: 20),
            Text('Tags', style: kHeadingTextStyle),
            SizedBox(height: 10),
            Text('Thêm tags như: #kinhdi, #kinhte, ...', style: kDefaultTextStyle.copyWith(color: kGreyColor)),
            SizedBox(height: 20),
            TextField(
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Thêm tags của bạn",
              ),
            ),
            SizedBox(height: 20),
            Text('Đánh giá', style: kHeadingTextStyle),
            SizedBox(height: 10),
            TextField(
              cursorColor: Colors.black,
              maxLines: 10,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Hãy chia sẻ cảm nghĩ của bạn về cuốn sách nhé",
              ),
            ),
            SizedBox(height: 20),
            DefaultButton(
              onPress: () {},
              text: 'Gửi',
            ),
          ],
        ),
      ),
    ));
  }
}
