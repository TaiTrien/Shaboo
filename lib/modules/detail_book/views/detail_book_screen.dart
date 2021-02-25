import 'package:flutter/material.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/detail_book/components/sliver_hearder_section.dart';

class DetailBookScreen extends StatefulWidget {
  @override
  _DetailBookScreenState createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          body: TabBarView(
            children: <Widget>[
              BookDescriptionScreen(),
              ReviewsScreen(),
              PostsScreen(),
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
                    Tab(
                      text: 'Miêu tả',
                    ),
                    Tab(
                      text: 'Đánh giá(10)',
                    ),
                    Tab(
                      text: 'Trao đổi',
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}

class BookDescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal + 10, vertical: kDefaultPaddingVerical),
      child: Text(
        ' selectedBook.description',
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}

class ReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPaddingHorizontal + 10,
          vertical: kDefaultPaddingVerical,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            title: Text(
              'Michael Jack',
              style: kHeadingTextStyle.copyWith(
                fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
              maxLines: 3,
              style: kDefaultTextStyle.copyWith(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
          ),
          itemCount: 20,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: kBorderColor,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.edit,
        ),
      ),
    );
  }
}

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPaddingHorizontal + 10,
          vertical: kDefaultPaddingVerical,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 100,
                      minHeight: 100,
                      maxWidth: 120,
                      maxHeight: 150,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/book_cover.jpg',
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tess of the Road',
                          style: kHeadingTextStyle.copyWith(
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                          maxLines: 5,
                          style: kDefaultTextStyle.copyWith(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          itemCount: 20,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: kBorderColor,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.thumbnail,
    this.title,
    this.user,
    this.viewCount,
  });

  final Widget thumbnail;
  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _VideoDescription(
              title: title,
              user: user,
              viewCount: viewCount,
            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key key,
    this.title,
    this.user,
    this.viewCount,
  }) : super(key: key);

  final String title;
  final String user;
  final int viewCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            user,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$viewCount views',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 106.0,
      children: <CustomListItem>[
        CustomListItem(
          user: 'Flutter',
          viewCount: 999000,
          thumbnail: Container(
            decoration: const BoxDecoration(color: Colors.blue),
          ),
          title: 'The Flutter YouTube Channel',
        ),
        CustomListItem(
          user: 'Dash',
          viewCount: 884000,
          thumbnail: Container(
            decoration: const BoxDecoration(color: Colors.yellow),
          ),
          title: 'Announcing Flutter 1.0',
        ),
      ],
    );
  }
}

// ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: Container(
//               height: 500,
//               color: Colors.red,
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minWidth: 100,
//                   minHeight: 500,
//                   maxWidth: 120,
//                   maxHeight: 550,
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Image.asset(
//                     'assets/images/book_cover.jpg',
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//             title: Text(
//               'Michael Jack',
//               style: kHeadingTextStyle.copyWith(
//                 fontSize: 20,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//             subtitle: Text(
//               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
//               maxLines: 3,
//               style: kDefaultTextStyle.copyWith(fontSize: 18),
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.justify,
//             ),
//           ),
