import 'package:equatable/equatable.dart';

abstract class HomeDirectionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeDirectionSetEvent extends HomeDirectionEvent {}

class HomeDirectionChangeEvent extends HomeDirectionEvent {}
