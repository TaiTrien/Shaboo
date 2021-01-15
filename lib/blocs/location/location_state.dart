part of 'location_bloc.dart';

@immutable
abstract class LocationState {
  final Map<String, dynamic> locations;
  final Map<String, dynamic> selectedCity;
  final Map<String, dynamic> selectedDistrict;
  final Map<String, dynamic> selectedWard;

  LocationState({this.locations, this.selectedCity, this.selectedDistrict, this.selectedWard});
}

class LocationInitial extends LocationState {
  LocationInitial() : super(locations: null, selectedCity: null, selectedDistrict: null, selectedWard: null);
}

class UpdateState extends LocationState {
  UpdateState(
    LocationState oldState, {
    Map<String, dynamic> locations,
    Map<String, dynamic> selectedCity,
    Map<String, dynamic> selectedDistrict,
    Map<String, dynamic> selectedWard,
  }) : super(
            locations: locations ?? oldState.locations,
            selectedCity: selectedCity,
            selectedDistrict: selectedDistrict,
            selectedWard: selectedWard);
}
