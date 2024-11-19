import 'package:equatable/equatable.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();
  @override
  List<Object> get props => [];
}

class LocationEnabled extends LocationState {
  const LocationEnabled();
  @override
  List<Object> get props => [];
}

class LocationDisabled extends LocationState {
  const LocationDisabled();

  @override
  List<Object> get props => [];
}
