import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/constants/model_constant.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/data/models/post/book.dart';
import 'package:shaboo/data/models/post/post.dart';
import 'package:shaboo/modules/book/detail_book/components/sliver_hearder_section.dart';
import 'package:shaboo/modules/book/detail_book/views/book_desc_tab.dart';
import 'package:shaboo/modules/main/feed/add_post/post_form.dart';
import 'package:shaboo/modules/post/list_post/views/list_post.dart';
import 'package:shaboo/modules/review/add/add_review_screen.dart';
import 'package:shaboo/modules/review/list_review/list_review_screen.dart';

class DetailBookScreen extends StatefulWidget {
  final BookModel selectedBook;

  const DetailBookScreen({Key key, this.selectedBook}) : super(key: key);
  @override
  _DetailBookScreenState createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostBloc>(context);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  _handleTabChange() {
    setState(() {});
  }

  _updateCurrentPost() {
    PostModel _currentPost = PostModel(
      title: '',
      description: '',
      images: null,
      location: null,
      book: widget.selectedBook,
    );
    _postBloc.add(UpdateCurrentPost(_currentPost));
  }

  Widget _floatingBtn() {
    switch (_tabController.index) {
      case 1:
        return FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddReviewScreen(
                        selectedBook: widget.selectedBook,
                      ))),
          child: Icon(Icons.edit),
          backgroundColor: kPrimaryColor,
        );
        break;
      case 2:
        return FloatingActionButton(
          onPressed: () => {
            this._updateCurrentPost(),
            showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (context) => Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: PostForm(),
                    ))
          },
          child: Icon(Icons.add),
          backgroundColor: kPrimaryColor,
        );
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          body: TabBarView(
            children: <Widget>[
              BookDescTab(bookDesc: widget.selectedBook.description),
              ListReviewScreen(
                bookId: widget.selectedBook.id.toString(),
                reviewType: ReviewType.BasedOnBook,
              ),
              ListPostWidget(
                  postType: PostType.BasedOnBook,
                  bookId: widget.selectedBook.id),
            ],
            controller: _tabController,
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: true,
                automaticallyImplyLeading: false,
                expandedHeight: size.height / 2,
                flexibleSpace: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.2,
                            vertical: size.width * 0.1),
                        child: widget.selectedBook.thumbnailUrl != null
                            ? Image.network(
                                widget.selectedBook.thumbnailUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return LoadingWidget(isImage: true);
                                },
                              )
                            : Image.asset(
                                'assets/icons/book-placeholder.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.close_rounded, size: 30),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SliverHeaderSection(
                backgroundColor: Colors.white,
                bookName: widget.selectedBook.name,
                author: widget.selectedBook.authors.isEmpty
                    ? 'Trống'
                    : widget.selectedBook.authors[0].name,
                score: widget.selectedBook.rating?.finalScore,
              ),
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.white,
                titleSpacing: 0.0,
                title: TabBar(
                  labelColor: Colors.black,
                  labelStyle: kDefaultTextStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  indicatorColor: kSecondaryColor,
                  unselectedLabelColor: kGreyColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(text: 'Miêu tả'),
                    Tab(text: 'Đánh giá'),
                    Tab(text: 'Trao đổi'),
                  ],
                  controller: _tabController,
                ),
              ),
            ];
          },
        ),
        floatingActionButton: _floatingBtn(),
      ),
    );
  }
}
