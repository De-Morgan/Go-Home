import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

import '../../lib/services/location_service.dart';

class MockLocationService extends Mock implements LocationService {}

main() {
  LocationService locationService;

  final locationData =
      LocationData.fromMap({"latitude": 60.5, "longitude": 23.2});

  setUp(() {
    locationService = MockLocationService();
    when(locationService.getCurrentLocation())
        .thenAnswer((_) => Future.value(locationData));
  });

  test("LocationService return $locationData when called ", () async {
    expect(await locationService.getCurrentLocation(), locationData);
  });
}
