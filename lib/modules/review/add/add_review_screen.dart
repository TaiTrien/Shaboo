import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/review/review_bloc.dart';
import 'package:shaboo/components/stateless/default_button.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/utils/notify.dart';

class ReviewScreen extends StatelessWidget {
  final selectedBook;

  const ReviewScreen({Key key, this.selectedBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewBloc, ReviewState>(
      listener: (context, state) {
        if (state is ReviewSuccessState) Navigator.pop(context);
      },
      builder: (context, state) {
        if (state is ReviewErrorState)
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          );
        else if (state is ReviewLoadingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
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
          body: Body(selectedBook: selectedBook),
        );
      },
    );
  }
}

class Body extends StatefulWidget {
  final selectedBook;

  const Body({Key key, this.selectedBook}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var tagController;
  var reviewController;

  double _sliderValue;
  ReviewBloc _reviewBloc;
  ReviewModel _currentReview;

  @override
  void initState() {
    tagController = new TextEditingController();
    reviewController = new TextEditingController();
    _sliderValue = 5.0;
    _reviewBloc = BlocProvider.of<ReviewBloc>(context);

    if (_reviewBloc.state.currentReview != null && _reviewBloc.state.currentReview.bookId == widget.selectedBook.id) {
      _sliderValue = _reviewBloc.state.currentReview.score.toDouble();
      tagController.text = _reviewBloc.state.currentReview.tags;
      reviewController.text = _reviewBloc.state.currentReview.review;
    }

    _currentReview = new ReviewModel(
      score: _sliderValue.toInt(),
      tags: tagController.text ?? "",
      review: reviewController.text ?? "",
      bookId: widget.selectedBook.id,
    );
    super.initState();
  }

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
              child: Text(
                _sliderValue.toStringAsFixed(1),
                style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 50,
                ),
              ),
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
                  _currentReview.score = value.toInt();
                  _reviewBloc.add(UpdateCurrentReview(_currentReview));
                  setState(() {
                    _sliderValue = value;
                  });
                },
                value: _sliderValue,
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
              controller: tagController,
              cursorColor: Colors.black,
              decoration: new InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Thêm tags của bạn",
              ),
              onChanged: (value) {
                _currentReview.tags = value;
                _reviewBloc.add(UpdateCurrentReview(_currentReview));
              },
            ),
            SizedBox(height: 20),
            Text('Đánh giá (*)', style: kHeadingTextStyle),
            SizedBox(height: 10),
            BlocBuilder<ReviewBloc, ReviewState>(
              builder: (context, state) {
                return TextField(
                  cursorColor: Colors.black,
                  controller: reviewController,
                  maxLines: 10,
                  decoration: new InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Hãy chia sẻ cảm nghĩ của bạn về cuốn sách nhé",
                  ),
                  onChanged: (value) {
                    _currentReview.review = value;
                    _reviewBloc.add(UpdateCurrentReview(_currentReview));
                  },
                );
              },
            ),
            SizedBox(height: 20),
            DefaultButton(
              onPress: () {
                if (_currentReview.review.isEmpty) return Notify().error(message: "Chưa đánh giá cuốn sách này");
                _reviewBloc.add(AddReview(_currentReview));
              },
              text: 'Gửi',
            ),
          ],
        ),
      ),
    ));
  }
}
