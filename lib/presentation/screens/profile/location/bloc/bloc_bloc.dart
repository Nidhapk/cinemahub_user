import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:userside/presentation/screens/profile/location/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/profile/location/bloc/bloc_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Location _location = Location();

  LocationBloc() : super(const LocationInitial()) {
    on<CheckLocationStatus>((event, emit) async {
      final isEnabled = await _location.serviceEnabled();
      if (isEnabled) {
        emit(const LocationEnabled());
      } else {
        emit(const LocationDisabled());
      }
    });

    on<ToggleLocation>((event, emit) async {
      final isEnabled = await _location.serviceEnabled();
      if (isEnabled) {
        await _location.requestService();
        emit(const LocationDisabled());
      } else {
        final success = await _location.requestService();
        if (success) {
          emit(const LocationEnabled());
        } else {
          emit(const LocationDisabled());
        }
      }
    });
  }
}
