import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  /// method to get location data
  Future<LocationData> getCurrentLocation() async {
    final locationData = await Location().getLocation();
    assert(locationData != null);
    return locationData;
  }
}
