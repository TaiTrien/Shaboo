import 'package:flutter/material.dart';
import 'package:shaboo/shared_components/stateless/default_button.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/size_config.dart';

// This is the best practice
import 'onboarding_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> onBoardingData = [
    {
      "title": 'Sách',
      "subTitle":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
      "image": "assets/images/book.svg"
    },
    {
      "title": 'Xứng đáng',
      "subTitle":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
      "image": "assets/images/savings.svg"
    },
    {
      "title": 'Chia sẻ',
      "subTitle":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
      "image": "assets/images/share.svg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onBoardingData.length,
                itemBuilder: (context, index) => SplashContent(
                  title: onBoardingData[index]["title"],
                  subTitle: onBoardingData[index]['subTitle'],
                  image: onBoardingData[index]["image"],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onBoardingData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    DefaultButton(
                      text: "Bắt đầu",
                      onPress: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/loginScreen',
                          (context) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
