import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/location/components/location_selector.dart';
import 'package:shaboo/screens/post/location/components/selector_title.dart';
import 'package:shaboo/screens/post/location/location_controller.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = LocationController(context: context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectorTitle(
                    title: 'SELECT YOUR PROVINCE, CITY',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  LocationSelector(
                    location: _controller.selectedCityName,
                    onPress: () => _controller.toDetailedLocation(_controller.cities),
                  ),
                  SizedBox(height: 30),
                  SelectorTitle(
                    title: 'SELECT YOUR DISTRICT',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  LocationSelector(
                    location: _controller.selectedDistrictName,
                    onPress: () => _controller.toDetailedLocation(_controller.districts),
                  ),
                  SizedBox(height: 30),
                  SelectorTitle(
                    title: 'SELECT YOUR WARD',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  LocationSelector(
                    location: _controller.selectedWardName,
                    onPress: () => _controller.toDetailedLocation(_controller.wards),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
