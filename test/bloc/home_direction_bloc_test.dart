import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

import '../../lib/services/location_service.dart';

import '../../lib/bloc/home_direction_bloc.dart';

class MockLocationService extends Mock implements LocationService {}

class MockHydratedBlocDelegate extends Mock implements HydratedBlocDelegate {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockHydratedBlocDelegate delegate;
  final locationData =
      LocationData.fromMap({"latitude": 23.5, "longitude": 67.2});

  setUp(() {
    delegate = MockHydratedBlocDelegate();
    BlocSupervisor.delegate = delegate;
  });

  group("HomeDirectionBloc test", () {
    HomeDirectionBloc homeDirectionBloc;
    LocationService locationService;

    setUp(() async {
      locationService = MockLocationService();
      when(locationService.getCurrentLocation())
          .thenAnswer((_) => Future.value(locationData));
      homeDirectionBloc = HomeDirectionBloc(locationService);
    });

    blocTest("Intial state is HomeDirectionNotSetState",
        build: () async => homeDirectionBloc,
        skip: 0,
        expect: [HomeDirectionNotSetState()]);
    blocTest(
        "HomeDirectionBloc emits [HomeDirectionSetState] when HomeDirectionNotSetEvent is added",
        build: () async => homeDirectionBloc,
        act: (HomeDirectionBloc bloc) async => bloc.add(HomeDirectionSetEvent()),
        expect: [HomeDirectionSetState(locationData)]);
  });
}
