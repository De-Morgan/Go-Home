import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:location/location.dart';

import '../services/location_service.dart';
import 'home_direction_event.dart';
import 'home_direction_state.dart';
export 'home_direction_event.dart';
export 'home_direction_state.dart';

class HomeDirectionBloc
    extends HydratedBloc<HomeDirectionEvent, HomeDirectionState> {
  final LocationService _locationService;

  HomeDirectionBloc([LocationService locationService])
      : _locationService = locationService ?? LocationService();

  @override
  HomeDirectionState get initialState =>
      super.initialState ?? HomeDirectionNotSetState();

  @override
  HomeDirectionState fromJson(Map<String, dynamic> json) {
    if (json.containsKey('latitude')) {
      Map<String, double> returnedLocationData = json.cast<String, double>();
      final LocationData locationData =
          LocationData.fromMap(returnedLocationData);
      return HomeDirectionSetState(locationData);
    } else {
      return HomeDirectionNotSetState();
    }
  }

  @override
  Map<String, dynamic> toJson(HomeDirectionState state) {
    if (state is HomeDirectionNotSetState) {
      Map<String, dynamic> map = {};
      return map;
    }

    ///Persist only the latitude and longitude values
    if (state is HomeDirectionSetState) {
      final Map<String, dynamic> data = {
        'latitude': state.locationData.latitude,
        'longitude': state.locationData.longitude,
        //  'accuracy': state.locationData.accuracy,
        // 'altitude': state.locationData.altitude,
        //'speed': state.locationData.speed,
        //'speed_accuracy': state.locationData.speed,
        //'heading': state.locationData.heading,
        //'time': state.locationData.time
      };
      return data;
    }
    return <String, dynamic>{};
  }

  @override
  Stream<HomeDirectionState> mapEventToState(HomeDirectionEvent event) async* {
    if (event is HomeDirectionSetEvent) {
      yield* _mapEventToSetHomeDirectionEvent();
    } else if (event is HomeDirectionChangeEvent) {
      yield* _mapEventToChangeHomeDirectionEvent();
    }
  }

  Stream<HomeDirectionState> _mapEventToSetHomeDirectionEvent() async* {
    try {
      final locationData = await _locationService.getCurrentLocation();
      yield HomeDirectionSetState(locationData);
    } catch (_) {
      yield HomeDirectionNotSetState();
    }
  }

  Stream<HomeDirectionState> _mapEventToChangeHomeDirectionEvent() async* {
    yield HomeDirectionNotSetState();
  }
}
