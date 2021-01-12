import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is UpdateLocationsState) {
      yield UpdateState(state, locations: event.payload);
    } else if (event is UpdateSelectedCity) {
      yield UpdateState(
        state,
        selectedCity: event.payload,
        selectedDistrict: null,
        selectedWard: null,
      );
    } else if (event is UpdateSelectedDistrict) {
      yield UpdateState(
        state,
        selectedCity: state.selectedCity,
        selectedDistrict: event.payload,
        selectedWard: null,
      );
    } else if (event is UpdateSelectedWard) {
      yield UpdateState(
        state,
        selectedCity: state.selectedCity,
        selectedDistrict: state.selectedDistrict,
        selectedWard: event.payload,
      );
    }
  }
}
