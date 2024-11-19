import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
  @override
  List<Object> get props => [];
}

class CheckLocationStatus extends LocationEvent {
  const CheckLocationStatus();
  @override
  List<Object> get props => [];
}

class ToggleLocation extends LocationEvent {
  const ToggleLocation();
  @override
  List<Object> get props => [];
}
