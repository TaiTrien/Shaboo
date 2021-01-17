import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/screens/post/preview/preview_controller.dart';

class PreviewPostScreen extends StatefulWidget {
  final int id;

  const PreviewPostScreen({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PreviewPostScreenState();
  }
}

class _PreviewPostScreenState extends State<PreviewPostScreen> {
  int _current = 0;
  PreviewPostController _controller;
  final CarouselController carouselController = CarouselController();
  @override
  void initState() {
    super.initState();
    _controller = PreviewPostController(context: context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _controller.getPost(widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          PostModel postModel = snapshot.data;
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: size.height),
                  child: Column(children: [
                    CarouselSlider(
                      items: _controller.getImgSlider(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          autoPlayInterval: Duration(seconds: 4),
                          aspectRatio: 1.2,
                          viewportFraction: 1),
                    ),
                    Container(
                      height: 100.0,
                      child: ListView.builder(
                        primary: false,
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: postModel.images.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => carouselController.animateToPage(index),
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Stack(
                                  fit: StackFit.loose,
                                  children: <Widget>[
                                    Image.network(
                                      postModel.images[index].link,
                                      fit: BoxFit.cover,
                                      width: 100.0,
                                      height: 100.0,
                                    ),
                                    Container(
                                      color: _current == index ? Colors.transparent : Color.fromRGBO(0, 0, 0, 0.2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                      child: Text(
                        postModel.book.name,
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[Image.asset('assets/icons/location.png', scale: 1.5), Text('2.4 km')],
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: 'Tác giả: ',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: postModel.book.authors.map((item) => item.name).join(', ').toString(),
                                    style: TextStyle(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.0),
                          RichText(
                            text: TextSpan(
                              text: 'Thể loại: ',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: postModel.book.categories.map((item) => item.name).join(', ').toString(),
                                    style: TextStyle(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.0),
                          RichText(
                            text: TextSpan(
                              text: 'Vị trí: ',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: postModel.location, style: TextStyle(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Lời nhắn:',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            postModel.description,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            color: Color(0xFFA81C1C),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15.0),
                            onPressed: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => SupplierPage()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Text(
                                "Nhà cung cấp",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.0),
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {},
                            color: Color(0xFF0365B0),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Text("Nhắn tin", textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0))),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
        });
  }
}
