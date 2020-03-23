import 'package:location/location.dart';

class LocationService {
  ///Static function to get location data
  static Future<LocationData> getCurrentLocation() async {
    final locationData = await Location().getLocation();
    assert(locationData != null);
    return locationData;
  }
}
