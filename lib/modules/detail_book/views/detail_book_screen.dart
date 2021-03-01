import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/detail_book/components/sliver_hearder_section.dart';
import 'package:shaboo/modules/detail_book/views/book_desc_tab.dart';
import 'package:shaboo/modules/detail_book/views/posts_tab.dart';
import 'package:shaboo/modules/detail_book/views/reviews_tab.dart';

class DetailBookScreen extends StatefulWidget {
  @override
  _DetailBookScreenState createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
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

  Widget _floatingBtn() {
    switch (_tabController.index) {
      case 1:
        return FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.edit),
          backgroundColor: kPrimaryColor,
        );
        break;
      case 2:
        return FloatingActionButton(
          onPressed: () {},
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
              BookDescTab(),
              ReviewsTab(),
              PostsTab(),
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
                      color: kLightblueColor,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: size.width * 0.1),
                        child: Image.asset('assets/images/book_cover.jpg'),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.close_rounded, size: 30),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              SliverHeaderSection(
                backgroundColor: Colors.white,
                bookName: 'Tess of the Road',
                author: 'Rachel Hartman',
                score: 9.5,
              ),
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.white,
                titleSpacing: 0.0,
                title: TabBar(
                  labelColor: Colors.black,
                  labelStyle: kDefaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                  indicatorColor: kSecondaryColor,
                  unselectedLabelColor: kGreyColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(text: 'Miêu tả'),
                    Tab(text: 'Đánh giá(10)'),
                    Tab(text: 'Trao đổi(10)'),
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
