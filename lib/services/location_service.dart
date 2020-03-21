import 'package:location/location.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  LocationService._internal();
  factory LocationService() => _instance;
  static final Location _location = Location();

  ///Static function to check location service
  static Future<void> locationServiceStatus() async {
    bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  ///Static function to request location permission
  static Future<void> permissionStatus() async {
    PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }
  }

  ///Static function to get location data
  static Future<LocationData> getCurrentLocation() async {
    await locationServiceStatus();
    await permissionStatus();
    final locationData = await _location.getLocation();
    assert(locationData != null);
    return locationData;
  }
}
