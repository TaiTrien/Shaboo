import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shaboo/constants/ui_constants.dart';

import 'package:shaboo/models/post/post.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';
import 'package:shaboo/modules/post/preview/controllers/preview_controller.dart';

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
            return Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          PostModel postModel = snapshot.data;
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: size.height),
                  child: Column(children: [
                    Stack(
                      children: [
                        Container(
                          height: size.height * 0.4,
                          width: double.infinity,
                          child: CarouselSlider(
                            items: _controller.getImgSlider(),
                            carouselController: carouselController,
                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                autoPlayInterval: Duration(seconds: 4),
                                aspectRatio: 1.2,
                                viewportFraction: 1),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: _controller.toExit,
                            child: Container(
                              margin: EdgeInsets.all(20.0),
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(width: 2, color: Colors.white)),
                              child: Icon(Icons.close, color: Colors.white, size: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
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
                                      loadingBuilder:
                                          (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return LoadingWidget(isImage: true);
                                      },
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
                      child: RichText(
                        text: TextSpan(
                          text: 'Lời nhắn: ',
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: postModel.description, style: TextStyle(fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () => _controller.toPopupContact(postModel.userId),
                            color: kPrimaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Text("Liên hệ", textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0))),
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
