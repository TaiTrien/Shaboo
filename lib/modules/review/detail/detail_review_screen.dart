import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/lazy_load/lazyload_bloc.dart';
import 'package:shaboo/blocs/review/review_bloc.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/components/stateless/popup_menu.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/modules/review/components/sliver_header_review.dart';
import 'package:shaboo/modules/review/edit/edit_review_screen.dart';
import 'package:shaboo/utils/notify.dart';

class DetailReviewScreen extends StatefulWidget {
  final ReviewModel selectedReview;

  const DetailReviewScreen({Key key, @required this.selectedReview})
      : super(key: key);

  @override
  _DetailReviewScreenState createState() => _DetailReviewScreenState();
}

class _DetailReviewScreenState extends State<DetailReviewScreen> {
  ReviewBloc _reviewBloc;
  @override
  void initState() {
    _reviewBloc = BlocProvider.of<ReviewBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<ReviewBloc, ReviewState>(listener: (context, state) {
      if (state is DeleteSuccessState) {
        Notify().success(message: 'Xoá thành công');
        Navigator.pop(context);
      } else if (state is ReviewErrorState) {
        Notify().error(message: state.message);
      }
    }, builder: (context, state) {
      if (state is ReviewLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
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
                  leading: IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Stack(children: [
                    LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(height: constraints.maxHeight - 50);
                    }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                          radius: 45,
                          child: ClipOval(
                              child: Image.network(
                            widget.selectedReview.userModel.avatar,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return LoadingWidget(isImage: true);
                            },
                          ))),
                    )
                  ])),
                  actions: [
                    PopupMenu(onSelect: handleSelectMenu, items: [
                      PopupMenuItem(
                        value: MenuValue.EDIT,
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Transform(
                            transform: Matrix4.translationValues(-16, 0.0, 0.0),
                            child: Text("Sửa đánh giá"),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                          value: MenuValue.DELETE,
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Transform(
                              transform:
                                  Matrix4.translationValues(-16, 0.0, 0.0),
                              child: Text("Xoá đánh giá"),
                            ),
                          ))
                    ])
                  ]),
              SliverHeaderView(
                userName: widget.selectedReview.userModel.firstName +
                    ' ' +
                    widget.selectedReview.userModel.lastName,
                score: widget.selectedReview.score.toDouble(),
              ),
            ];
          },
        ),
      );
    });
  }

  handleSelectMenu(value) {
    if (value == MenuValue.EDIT) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EditReviewScreen(selectedReview: widget.selectedReview);
      }));
    } else if (value == MenuValue.DELETE) {
      _reviewBloc.add(DeleteReview(widget.selectedReview));
    }
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
        padding:
            const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
