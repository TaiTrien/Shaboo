import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/lazy_load/lazyload_bloc.dart';
import 'package:shaboo/blocs/review/review_bloc.dart';
import 'package:shaboo/components/stateful/lazy_load_item.dart';
import 'package:shaboo/components/stateful/lazy_load_list.dart';
import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/data/models/review/review.dart';
import 'package:shaboo/data/repositories/implement/review/review_repo_impl.dart';
import 'package:shaboo/modules/review/components/review_tile.dart';
import 'package:shaboo/modules/review/detail/detail_review_screen.dart';

class ListReviewScreen extends StatelessWidget {
  final String bookId;
  final String userId;
  final ReviewType reviewType;

  const ListReviewScreen(
      {Key key, this.bookId, this.userId, @required this.reviewType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(builder: (context, state) {
      if (state is ReviewLoadingState) {
        return CircularProgressIndicator();
      }
      return BlocProvider<LazyLoadBloc>(
        create: (context) => LazyLoadBloc(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddingHorizontal + 10,
            vertical: kDefaultPaddingVerical,
          ),
          child: reviewType == ReviewType.Owned
              ? BlocProvider<LazyLoadBloc>(
                  create: (context) => LazyLoadBloc(),
                  child: ListReviewOwned(userId: userId))
              : ListViewBasedOnBook(
                  bookId: this.bookId,
                ),
        ),
      );
    });
  }
}

class ListReviewOwned extends StatefulWidget {
  final String userId;
  const ListReviewOwned({
    Key key,
    this.userId,
  }) : super(key: key);

  @override
  _ListReviewOwnedState createState() => _ListReviewOwnedState();
}

class _ListReviewOwnedState extends State<ListReviewOwned> {
  ReviewRepoImpl _reviewRepo;
  var _lazyLoadBloc;
  int _currentPage;
  int _take;
  @override
  void initState() {
    _reviewRepo = RepositoryProvider.of<ReviewRepoImpl>(context);
    _lazyLoadBloc = BlocProvider.of<LazyLoadBloc>(context);
    _currentPage = 1;
    _take = 10;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadList(
      onRefresh: handleRefresh,
      onLoadMore: handleLoadMore,
      listSeperator: Divider(color: kBorderColor),
      child:
          BlocBuilder<LazyLoadBloc, LazyLoadState>(builder: (context, state) {
        return ReviewTile(
          urlImage: LazyLoadItem.of(context).itemData.userModel.avatar,
          title: LazyLoadItem.of(context).itemData.bookModel.name,
          subTitle: LazyLoadItem.of(context).itemData.review,
          onPress: () =>
              toDetailScreen(selectedReview: LazyLoadItem.of(context).itemData),
        );
      }),
    );
  }

  handleRefresh() {
    _currentPage = 1;
    _lazyLoadBloc.add(LoadMore(
      clearCachedData: true,
      fetchData:
          _reviewRepo.getReviews(page: _currentPage, userId: widget.userId),
    ));
  }

  handleLoadMore() {
    _currentPage++;
    _lazyLoadBloc.add(LoadMore(
        fetchData:
            _reviewRepo.getReviews(page: _currentPage, userId: widget.userId)));
  }

  toDetailScreen({ReviewModel selectedReview}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailReviewScreen(
        selectedReview: selectedReview,
      );
    }));
  }
}

class ListViewBasedOnBook extends StatefulWidget {
  final String bookId;

  const ListViewBasedOnBook({
    Key key,
    this.bookId,
  }) : super(key: key);

  @override
  _ListViewBasedOnBookState createState() => _ListViewBasedOnBookState();
}

class _ListViewBasedOnBookState extends State<ListViewBasedOnBook> {
  ReviewRepoImpl _reviewRepo;
  var _lazyLoadBloc;
  int _currentPage;
  int _take;
  @override
  void initState() {
    _reviewRepo = RepositoryProvider.of<ReviewRepoImpl>(context);
    _lazyLoadBloc = BlocProvider.of<LazyLoadBloc>(context);
    _currentPage = 1;
    _take = 10;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadList(
      onRefresh: handleRefresh,
      onLoadMore: handleLoadMore,
      listSeperator: Divider(color: kBorderColor),
      child:
          BlocBuilder<LazyLoadBloc, LazyLoadState>(builder: (context, state) {
        return ReviewTile(
          urlImage: LazyLoadItem.of(context).itemData.userModel.avatar,
          title: LazyLoadItem.of(context).itemData.review,
          subTitle: LazyLoadItem.of(context).itemData.review,
        );
      }),
    );
  }

  handleRefresh() {
    _currentPage = 1;
    _lazyLoadBloc.add(LoadMore(
      clearCachedData: true,
      fetchData:
          _reviewRepo.getReviews(page: _currentPage, bookId: widget.bookId),
    ));
  }

  handleLoadMore() {
    _currentPage++;
    _lazyLoadBloc.add(LoadMore(
        fetchData:
            _reviewRepo.getReviews(page: _currentPage, bookId: widget.bookId)));
  }
}
