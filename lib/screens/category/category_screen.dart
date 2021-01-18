import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/category/category_controller.dart';
import 'package:shaboo/screens/category/sample-image.dart';
import 'package:shaboo/screens/post/components/loading_widget.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    CategoryController _controller = CategoryController(context: context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfffafafa),
          elevation: 0,
          title: Text(
            'Thể loại bạn thích',
            style: kHeadingTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
          child: FutureBuilder(
              future: _controller.loadCategories(),
              builder: (context, _snapshot) {
                if (_snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                } else if (_snapshot.hasError) {
                  return Center(
                    child: Text('Đã xảy ra lỗi', style: kTitleTextStyle),
                  );
                } else if (!_snapshot.hasData) {
                  return Center(
                    child: Text('Không tìm thấy danh mục nào', style: kTitleTextStyle),
                  );
                }
                return GridView.builder(
                  itemCount: sampleImageLink.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) => ListTile(
                    title: Container(
                      height: size.height / 4,
                      child: Image.network(
                        sampleImageLink[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return LoadingWidget(isImage: true);
                        },
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        _snapshot.data[index].name,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

//  Column(
//                     children: [
//                       Container(
//                         width: size.width / 2,
//                         height: size.height / 4,
//                         child: Image.network(
//                           sampleImageLink[index],
//                           fit: BoxFit.cover,
//                           loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return LoadingWidget(isImage: true);
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Expanded(
//                         child: Text(
//                           _snapshot.data[index].name,
//                           style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
