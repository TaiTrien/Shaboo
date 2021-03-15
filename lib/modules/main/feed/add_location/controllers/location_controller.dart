import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/blocs/post/post_bloc.dart';
import 'package:shaboo/data/models/post/post.dart';
import 'package:shaboo/modules/main/feed/add_location/detailed_location/views/detailed_location.dart';
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
    if (selectedCity == null) return Notify().error(message: 'Hãy chọn tỉnh/thành của bạn');
    if (selectedDistrict == null) return Notify().error(message: 'Hãy chọn quận/huyện của bạn');
    if (selectedWard == null) return Notify().error(message: 'Hãy chọn phường/xã của bạn');
    PostModel _currentPost = PostModel(
      title: title,
      description: desc,
      images: images,
      location: selectedWard["path_with_type"],
      book: book ?? null,
    );
    _postBloc.add(UpdateCurrentPost(_currentPost));
    toNextPage();
  }

  get currentPost => _postBloc.state.currentPost;
  get title => currentPost.title;
  get desc => currentPost.description;
  get images => currentPost.images;
  get book => currentPost.book;

  get cities => _locationBloc.state.locations.values.toList();
  get districts => _locationBloc.state.selectedCity["quan-huyen"].values.toList();
  get wards => _locationBloc.state.selectedDistrict["xa-phuong"].values.toList();

  get selectedCity => _locationBloc.state.selectedCity;
  get selectedDistrict => _locationBloc.state.selectedDistrict;
  get selectedWard => _locationBloc.state.selectedWard;

  get selectedCityName => selectedCity == null ? "Tỉnh/thành" : selectedCity["name_with_type"];
  get selectedDistrictName => selectedDistrict == null ? "Quận/huyện" : selectedDistrict["name_with_type"];
  get selectedWardName => selectedWard == null ? "Phường/xã" : selectedWard["name_with_type"];

  toCityList(dynamic location) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedLocationScreen(locations: location)));

  toDistrictList() {
    if (selectedCity == null) return Notify().error(message: 'Hãy chọn tỉnh/thành của bạn');
    return toCityList(districts);
  }

  toWardList() {
    if (selectedCity == null) return Notify().error(message: 'Hãy chọn tỉnh/thành của bạn');
    if (selectedDistrict == null) return Notify().error(message: 'Hãy chọn quận/huyện của bạn');
    return toCityList(wards);
  }

  //navigator
  toNextPage() => pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
  toExit() => Navigator.pop(context);
}
