import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/location/location_bloc.dart';
import 'package:shaboo/constants.dart';
import 'package:shaboo/utils/notify.dart';

class DetailedLocationController {
  BuildContext context;
  LocationBloc _locationBloc;

  DetailedLocationController({this.context}) {
    _locationBloc = BlocProvider.of<LocationBloc>(context);
  }

  handleUpdateSelectedLocation(dynamic selectedLocation) {
    int code = int.tryParse(selectedLocation["code"]);

    if (code < kLimitCodeLocation["city"]) {
      _locationBloc.add(UpdateSelectedCity(selectedLocation));
    } else if (code < kLimitCodeLocation["district"]) {
      if (_locationBloc.state.selectedCity == null) return Notify().error(message: 'Please select your city');
      _locationBloc.add(UpdateSelectedDistrict(selectedLocation));
    } else if (code < kLimitCodeLocation["ward"]) {
      _locationBloc.add(UpdateSelectedWard(selectedLocation));
    }
    Navigator.pop(context);
  }

  toExit() => Navigator.pop(context);
}
