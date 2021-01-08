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
  }

  loadLocationData() async {
    String cities = await DefaultAssetBundle.of(context).loadString("assets/jsons/cities.json");
    String districts = await DefaultAssetBundle.of(context).loadString("assets/jsons/districts.json");
    String wards = await DefaultAssetBundle.of(context).loadString("assets/jsons/wards.json");

    final citiesJson = json.decode(cities);
    final districtsJson = json.decode(districts);
    final wardsJson = json.decode(wards);

    _locationBloc.add(UpdateCitiesState(citiesJson));
    _locationBloc.add(UpdateDistrictsState(districtsJson));
    _locationBloc.add(UpdateWardsState(wardsJson));
  }
}
