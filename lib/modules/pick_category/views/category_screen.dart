import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';
import 'package:shaboo/constants/ui_constants.dart';

import 'package:shaboo/modules/pick_category/controllers/category_controller.dart';
import 'package:shaboo/modules/pick_category/views/sample-image.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';

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
          actions: [
            FlatButton(
              onPressed: () async => _controller.handleSelectCategories(),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPaddingHorizontal, vertical: 10),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return Text(
                      'Tiếp theo (${_controller.numberOfSelectedCategories}/10)',
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ],
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
                    child: Text('Không tìm thấy danh mục nào',
                        style: kTitleTextStyle.copyWith(
                            fontWeight: FontWeight.w400, color: kGreyColor)),
                  );
                }
                return BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                  return GridView.builder(
                    itemCount: sampleImageLink.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 40,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => _controller.updateSelectedCategories(
                          selectCategory: _snapshot.data[index]),
                      child: ListTile(
                        title: Stack(
                          children: [
                            Container(
                              height: size.height / 4,
                              child: Image.network(
                                sampleImageLink[index],
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return LoadingWidget(isImage: true);
                                },
                              ),
                            ),
                            Container(
                              height: size.height / 4,
                              color:
                                  _controller.isSelected(_snapshot.data[index])
                                      ? Colors.black.withOpacity(0.4)
                                      : Colors.black.withOpacity(0),
                              child: _controller
                                      .isSelected(_snapshot.data[index])
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white)),
                                          child: Icon(Icons.check,
                                              color: Colors.white, size: 18),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            _snapshot.data[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                });
              }),
        ),
      ),
    );
  }
}
