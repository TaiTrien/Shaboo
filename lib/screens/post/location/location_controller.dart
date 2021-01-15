import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/model/post/post.dart';
import 'package:shaboo/screens/post/location/detailed_location/detailed_location.dart';
import 'package:shaboo/utils/notify.dart';

class LocationController {
  BuildContext context;
  LocationBloc _locationBloc;
  PostBloc _postBloc;
  PageController pageController;

  LocationController({this.context, this.pageController}) {
    _locationBloc = BlocProvider.of<LocationBloc>(context);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  handleUpdateCurrentPost() {
    if (selectedCity == null) return Notify().error(message: 'Please select your city');
    if (selectedDistrict == null) return Notify().error(message: 'Please select your district');
    if (selectedWard == null) return Notify().error(message: 'Please select your ward');
    PostModel _currentPost =
        PostModel(title: title, desc: desc, images: images, location: selectedWard["path_with_type"]);
    _postBloc.add(UpdateCurrentPost(_currentPost));
    toNextPage();
  }

  get title => _postBloc.state.currentPost.title;
  get desc => _postBloc.state.currentPost.desc;
  get images => _postBloc.state.currentPost.images;

  get cities => _locationBloc.state.locations.values.toList();
  get districts => _locationBloc.state.selectedCity["quan-huyen"].values.toList();
  get wards => _locationBloc.state.selectedDistrict["xa-phuong"].values.toList();

  get selectedCity => _locationBloc.state.selectedCity;
  get selectedDistrict => _locationBloc.state.selectedDistrict;
  get selectedWard => _locationBloc.state.selectedWard;

  get selectedCityName => selectedCity == null ? "Your city" : selectedCity["name_with_type"];
  get selectedDistrictName => selectedDistrict == null ? "Your district" : selectedDistrict["name_with_type"];
  get selectedWardName => selectedWard == null ? "Your ward" : selectedWard["name_with_type"];

  toCityList(dynamic location) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedLocationScreen(locations: location)));

  toDistrictList() {
    if (selectedCity == null) return Notify().error(message: 'Please select your city');
    return toCityList(districts);
  }

  toWardList() {
    if (selectedCity == null) return Notify().error(message: 'Please select your city');
    if (selectedDistrict == null) return Notify().error(message: 'Please select your district');
    return toCityList(wards);
  }

  //navigator
  toNextPage() => pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  toExit() => Navigator.pop(context);
}
