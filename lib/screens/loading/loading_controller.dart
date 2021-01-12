import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';

class LoadingController {
  BuildContext context;
  LocationBloc _locationBloc;

  LoadingController({this.context}) {
    _locationBloc = BlocProvider.of<LocationBloc>(context);
    handleLoad();
  }

  handleLoad() async {
    await loadLocationData();
    toMainScreen();
  }

  loadLocationData() async {
    String locations = await DefaultAssetBundle.of(context).loadString("assets/jsons/location-tree.json");
    final locationsJson = await json.decode(locations);
    _locationBloc.add(UpdateLocationsState(locationsJson));
  }

  toMainScreen() => Navigator.pushNamedAndRemoveUntil(context, '/mainScreen', (context) => false);
}
