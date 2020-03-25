import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

abstract class HomeDirectionState extends Equatable {}

class HomeDirectionSetState extends HomeDirectionState {
  final LocationData locationData;
  HomeDirectionSetState(this.locationData);
  @override
  List<Object> get props => [locationData];
}

class HomeDirectionNotSetState extends HomeDirectionState {
  @override
  List<Object> get props => [];
}
