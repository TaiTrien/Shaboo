part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {
  final dynamic payload;

  LocationEvent({this.payload});
}

class UpdateCitiesState extends LocationEvent {
  UpdateCitiesState(Map<String, dynamic> cities) : super(payload: cities);
}

class UpdateDistrictsState extends LocationEvent {
  UpdateDistrictsState(Map<String, dynamic> districts) : super(payload: districts);
}

class UpdateWardsState extends LocationEvent {
  UpdateWardsState(Map<String, dynamic> wards) : super(payload: wards);
}
