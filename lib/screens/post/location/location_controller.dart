import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/screens/post/location/detailed_location/detailed_location.dart';

class LocationController {
  BuildContext context;
  LocationBloc _locationBloc;

  LocationController({this.context}) {
    _locationBloc = BlocProvider.of<LocationBloc>(context);
    print(_locationBloc.state.selectedWard);
  }

  get cities => _locationBloc.state.locations.values.toList();
  get districts => _locationBloc.state.selectedCity["quan-huyen"].values.toList();
  get wards => _locationBloc.state.selectedDistrict["xa-phuong"].values.toList();

  get selectedCity => _locationBloc.state.selectedCity;
  get selectedDistrict => _locationBloc.state.selectedDistrict;
  get selectedWard => _locationBloc.state.selectedWard;

  get selectedCityName => selectedCity == null ? "Your city" : selectedCity["name_with_type"];
  get selectedDistrictName => selectedDistrict == null ? "Your district" : selectedDistrict["name_with_type"];
  get selectedWardName => selectedWard == null ? "Your ward" : selectedWard["name_with_type"];

  toDetailedLocation(dynamic location) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedLocationScreen(locations: location),
      ));
  toExit() => Navigator.pop(context);
}
