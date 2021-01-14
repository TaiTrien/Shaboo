import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/components/custom_textfield.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/book/book_controller.dart';
import 'package:shaboo/screens/post/book/components/book_list.dart';

class BookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = BookController(context: context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height),
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: kDefaultPaddingHorizontal + 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kGreyColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomTextField(
                      controller: _controller.searchController,
                      labelText: 'Search your book',
                      icon: Icons.search,
                    ),
                  ),
                  SizedBox(height: 20),
                  BookList(),
                  // FutureBuilder(
                  //   future: _controller.bookModel.getBooks(page: 1, bookName: "A"),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState != ConnectionState.done)
                  //       return Expanded(
                  //         child: Center(
                  //           child: ModalProgressHUD(
                  //             color: Colors.white70,
                  //             child: Container(),
                  //             inAsyncCall: snapshot.connectionState != ConnectionState.done,
                  //           ),
                  //         ),
                  //       );
                  //     else if (!snapshot.hasData) {
                  //       return Expanded(
                  //         child: Center(
                  //           child: Text(
                  //             'No matchingbook was found',
                  //             style: TextStyle(fontSize: 20, color: kGreyColor),
                  //           ),
                  //         ),
                  //       );
                  //     } else if (snapshot.data.isEmpty) {
                  //       return Expanded(
                  //         child: Center(
                  //           child: Text(
                  //             'No matchingbook was found',
                  //             style: TextStyle(fontSize: 20, color: kGreyColor),
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //     return Expanded(
                  //       child: ListView.separated(
                  //         shrinkWrap: true,
                  //         itemCount: snapshot.data.length,
                  //         itemBuilder: (context, index) {
                  //           return Center(
                  //             child: Container(
                  //               padding: EdgeInsets.symmetric(
                  //                 horizontal: kDefaultPaddingHorizontal,
                  //                 vertical: kDefaultPaddingVerical,
                  //               ),
                  //               child: ListTile(
                  //                 leading: Image.network(
                  //                   snapshot.data[index].thumbnailUrl,
                  //                   loadingBuilder:
                  //                       (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                  //                     if (loadingProgress == null) return child;
                  //                     return CircularProgressIndicator();
                  //                   },
                  //                 ),
                  //                 title: Text(
                  //                   snapshot.data[index].bookName,
                  //                   style: TextStyle(
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //                 ),
                  //                 subtitle: Text(
                  //                   snapshot.data[index].shortDesc,
                  //                   maxLines: 3,
                  //                   textAlign: TextAlign.justify,
                  //                 ),
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //         separatorBuilder: (BuildContext context, int index) {
                  //           return Divider(
                  //             color: Colors.black,
                  //             height: 1.0,
                  //           );
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
