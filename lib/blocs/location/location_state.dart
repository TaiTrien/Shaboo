part of 'location_bloc.dart';

@immutable
abstract class LocationState {
  final Map<String, dynamic> cities;
  final Map<String, dynamic> districts;
  final Map<String, dynamic> wards;

  LocationState({this.cities, this.districts, this.wards});
}

class LocationInitial extends LocationState {
  LocationInitial() : super(cities: null, districts: null, wards: null);
}

class UpdateState extends LocationState {
  UpdateState(
    LocationState oldState, {
    Map<String, dynamic> cities,
    Map<String, dynamic> districts,
    Map<String, dynamic> wards,
  }) : super(
          cities: cities ?? oldState.cities,
          districts: districts ?? oldState.districts,
          wards: wards ?? oldState.wards,
        );
}
