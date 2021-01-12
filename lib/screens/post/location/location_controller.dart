import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/screens/post/location/detailed_location/detailed_location.dart';
import 'package:shaboo/utils/notify.dart';

class LocationController {
  BuildContext context;
  LocationBloc _locationBloc;

  LocationController({this.context}) {
    _locationBloc = BlocProvider.of<LocationBloc>(context);
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

  toExit() => Navigator.pop(context);
}
