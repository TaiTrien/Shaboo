import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/constants/ui_constants.dart';
import 'package:shaboo/modules/main/feed/add_location/components/location_selector.dart';

import 'package:shaboo/modules/main/feed/add_location/detailed_location/controllers/detailed_location_controller.dart';

class DetailedLocationScreen extends StatelessWidget {
  final dynamic locations;

  const DetailedLocationScreen({Key key, this.locations}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _controller = DetailedLocationController(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _controller.toExit,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Địa điểm của bạn',
          style:
              kHeadingTextStyle.copyWith(fontSize: 22.0, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return LocationSelector(
                location: locations[index]["name_with_type"].toString(),
                onPress: () =>
                    _controller.handleUpdateSelectedLocation(locations[index]),
              );
            },
          );
        },
      ),
    );
  }
}
