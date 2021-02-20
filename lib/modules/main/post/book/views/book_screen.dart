import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/modules/main/post/book/components/book_list.dart';
import 'package:shaboo/shared_components/stateless/search_bar.dart';
import 'package:shaboo/constants/ui_constants.dart';

import 'package:shaboo/modules/main/post/book/controllers/book_controller.dart';

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
                    child: SearchBar(),
                  ),
                  SizedBox(height: 20),
                  BookList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
