part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {
  final dynamic payload;

  LocationEvent({this.payload});
}

class UpdateLocationsState extends LocationEvent {
  UpdateLocationsState(Map<String, dynamic> locations) : super(payload: locations);
}

class UpdateSelectedCity extends LocationEvent {
  UpdateSelectedCity(Map<String, dynamic> selectedLocation) : super(payload: selectedLocation);
}

class UpdateSelectedDistrict extends LocationEvent {
  UpdateSelectedDistrict(Map<String, dynamic> selectedDistrict) : super(payload: selectedDistrict);
}

class UpdateSelectedWard extends LocationEvent {
  UpdateSelectedWard(Map<String, dynamic> selectedWard) : super(payload: selectedWard);
}
