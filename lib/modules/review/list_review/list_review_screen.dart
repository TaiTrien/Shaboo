import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/lazy_load/lazyload_bloc.dart';
import 'package:shaboo/components/stateful/lazy_load_item.dart';
import 'package:shaboo/components/stateful/lazy_load_list.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/data/repositories/implement/review/review_repo_impl.dart';

class ListReviewScreen extends StatefulWidget {
  final String bookId;
  final String userId;
  final ReviewType reviewType;

  const ListReviewScreen({Key key, this.bookId, this.userId, @required this.reviewType}) : super(key: key);
  @override
  _ListReviewScreenState createState() => _ListReviewScreenState();
}

class _ListReviewScreenState extends State<ListReviewScreen> {
  ReviewRepoImpl _reviewRepo;
  int _currentPage, _take;

  @override
  void initState() {
    super.initState();
    _reviewRepo = RepositoryProvider.of<ReviewRepoImpl>(context);
    _currentPage = 1;
    _take = 10;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LazyLoadBloc>(
      create: (context) => LazyLoadBloc(
        fetchData: _reviewRepo.getReviews(page: _currentPage, bookId: widget.bookId, userId: widget.userId),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPaddingHorizontal + 10,
          vertical: kDefaultPaddingVerical,
        ),
        child: LazyLoadList(
          listSeperator: Divider(color: kBorderColor),
          child: BlocBuilder<LazyLoadBloc, LazyLoadState>(builder: (context, state) {
            return widget.reviewType == ReviewType.Owned ? ListReviewOwned() : ListViewBasedOnBook();
          }),
        ),
      ),
    );
  }
}

class ListReviewOwned extends StatelessWidget {
  const ListReviewOwned({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          radius: 18,
          child: ClipOval(
              child: Image.network(
            LazyLoadItem.of(context).itemData.userModel.avatar,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return LoadingWidget(isImage: true);
            },
          ))),
      title: Text(
        LazyLoadItem.of(context).itemData.bookModel.name,
        maxLines: 1,
        style: kHeadingTextStyle.copyWith(
          fontSize: 20,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        LazyLoadItem.of(context).itemData.review,
        maxLines: 3,
        style: kDefaultTextStyle.copyWith(fontSize: 18),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class ListViewBasedOnBook extends StatelessWidget {
  const ListViewBasedOnBook({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          radius: 18,
          child: ClipOval(
              child: Image.network(
            LazyLoadItem.of(context).itemData.userModel.avatar,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return LoadingWidget(isImage: true);
            },
          ))),
      title: Text(
        LazyLoadItem.of(context).itemData.review,
        maxLines: 1,
        style: kHeadingTextStyle.copyWith(
          fontSize: 20,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        LazyLoadItem.of(context).itemData.review,
        maxLines: 3,
        style: kDefaultTextStyle.copyWith(fontSize: 18),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
