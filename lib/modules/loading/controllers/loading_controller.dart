import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/blocs/user/user_bloc.dart';

class LoadingController {
  BuildContext context;
  LocationBloc _locationBloc;
  UserBloc _userBloc;

  LoadingController({this.context}) {
    _locationBloc = BlocProvider.of<LocationBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);

    handleLoad();
  }

  handleLoad() async {
    await loadLocationData();

    if (!isUpdatedInfo) {
      toUpdateInfo();
    } else if (categories.isEmpty) {
      toCategoryScreen();
    } else
      toMainScreen();
  }

  loadLocationData() async {
    String locations = await DefaultAssetBundle.of(context)
        .loadString("assets/jsons/location-tree.json");
    final locationsJson = await json.decode(locations);
    _locationBloc.add(UpdateLocationsState(locationsJson));
  }

  get currentUser => _userBloc.state.currentUser;
  get categories => currentUser?.categories;
  get isUpdatedInfo => currentUser?.isUpdatedInfo;
  //navigations
  toMainScreen() => Navigator.pushNamedAndRemoveUntil(
      context, '/mainScreen', (context) => false);
  toCategoryScreen() => Navigator.pushNamedAndRemoveUntil(
      context, '/categoryScreen', (context) => false);
  toUpdateInfo() => Navigator.pushNamedAndRemoveUntil(
      context, '/updateGeneralInfo', (context) => false);
}
