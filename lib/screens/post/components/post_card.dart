import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/components/loading_widget.dart';

class PostCard extends StatelessWidget {
  final int itemCount;
  const PostCard({
    Key key,
    @required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => ExchangePage()));
          },
          child: Card(
            elevation: 1.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      child: Hero(
                        tag: 'imgTag',
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://pbs.twimg.com/media/EcJgt56U4AEzvel.jpg',
                          placeholder: (context, url) => Container(
                            height: 150.0,
                            width: 110.0,
                            child: LoadingWidget(
                              isImage: true,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/icons/book-placeholder.png',
                            fit: BoxFit.fill,
                            height: 150.0,
                            width: 110.0,
                          ),
                          fit: BoxFit.fill,
                          height: 150.0,
                          width: 120.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        Hero(
                          tag: 'titleTag',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              'Cần trao đổi sách này lấy Đắc nhân tâm',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0365B0),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Sách mới, rất giữ sách, có bọc ngoài sách',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: <Widget>[
                            Image.asset('assets/icons/location.png',
                                scale: 1.5),
                            Text(
                              '1.5km',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Q.12, TP. Hồ Chí Minh',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Theme.of(context).textTheme.caption.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
