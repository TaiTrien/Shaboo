import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/connection/connection_cubit.dart';
import 'package:shaboo/blocs/review/review_bloc.dart';
import 'package:shaboo/components/stateless/default_button.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/utils/notify.dart';

class EditReviewScreen extends StatelessWidget {
  final ReviewModel selectedReview;

  const EditReviewScreen({Key key, @required this.selectedReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewBloc, ReviewState>(
      listener: (context, state) {
        if (state is ReviewSuccessState) {
          Notify().success(message: "Cập nhật thành công");
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is ReviewErrorState)
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.headline5,
                ),
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
          body: Body(selectedReview: selectedReview),
        );
      },
    );
  }
}

class Body extends StatefulWidget {
  final ReviewModel selectedReview;

  const Body({Key key, this.selectedReview}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var tagController;
  var reviewController;

  double _sliderValue;
  ReviewBloc _reviewBloc;
  ReviewModel _currentReview;

  bool _canSubmit = true;

  @override
  void initState() {
    tagController = new TextEditingController();
    reviewController = new TextEditingController();
    _reviewBloc = BlocProvider.of<ReviewBloc>(context);

    _sliderValue = widget.selectedReview.score.toDouble();
    tagController.text = widget.selectedReview.tags;
    reviewController.text = widget.selectedReview.review;

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
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                  value: _sliderValue,
                  max: 10,
                  min: 0,
                  activeColor: kPrimaryColor),
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
                );
              },
            ),
            SizedBox(height: 20),
            BlocConsumer<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state is InternetDisconnected) {
                  setState(() {
                    _canSubmit = false;
                  });
                  Notify().error(message: "Chưa kết nối với Internet");
                } else if (state is InternetConnected) {
                  setState(() {
                    _canSubmit = true;
                  });
                  Notify().success(message: "Kết nối thành công với Internet");
                }
              },
              builder: (context, state) {
                return DefaultButton(
                  color: _canSubmit ? kPrimaryColor : kGreyColor,
                  onPress: state is InternetConnected
                      ? () {
                          if (reviewController.text.isEmpty)
                            return Notify().error(message: "Chưa đánh giá cuốn sách này");
                          if (tagController.text.isEmpty)
                            return Notify().error(message: "Chưa thêm tag cho đánh giá này");
                          _currentReview = ReviewModel(
                            id: widget.selectedReview.id,
                            review: reviewController.text,
                            tags: tagController.text,
                            score: _sliderValue.toInt(),
                            bookId: widget.selectedReview.bookId,
                            bookModel: widget.selectedReview.bookModel,
                            userModel: widget.selectedReview.userModel,
                          );
                          _reviewBloc.add(EditReview(_currentReview));
                        }
                      : () {},
                  text: 'Cập nhập',
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
