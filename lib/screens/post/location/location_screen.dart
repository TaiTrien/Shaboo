import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/components/bottom_button.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/screens/post/location/components/location_selector.dart';
import 'package:shaboo/screens/post/location/components/selector_title.dart';
import 'package:shaboo/screens/post/location/location_controller.dart';

class LocationScreen extends StatelessWidget {
  final PageController pageController;

  const LocationScreen({Key key, this.pageController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _controller =
        LocationController(context: context, pageController: pageController);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectorTitle(
                    title: 'Chọn tỉnh/thành phố của bạn ',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  LocationSelector(
                    location: _controller.selectedCityName,
                    onPress: () => _controller.toCityList(_controller.cities),
                  ),
                  SizedBox(height: 30),
                  SelectorTitle(
                    title: 'Chọn quận/huyện của bạn ',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  LocationSelector(
                    location: _controller.selectedDistrictName,
                    onPress: _controller.toDistrictList,
                  ),
                  SizedBox(height: 30),
                  SelectorTitle(
                    title: 'Chọn phường/xã của bạn ',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  LocationSelector(
                    location: _controller.selectedWardName,
                    onPress: _controller.toWardList,
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPress: _controller.handleUpdateCurrentPost,
        title: 'Tiếp tục',
      ),
    );
  }
}
