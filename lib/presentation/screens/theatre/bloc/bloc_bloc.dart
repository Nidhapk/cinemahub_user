import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:userside/data/services/theatre_repository.dart';
import 'package:userside/presentation/screens/theatre/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/theatre/bloc/bloc_state.dart';

class TheatreBloc extends Bloc<TheatreEvent, TheatreState> {
  TheatreBloc() : super(const TheatresInitialstate()) {
    on<FetchAllTheatresTheatreEvent>(fetchTheatres);
    on<SelectTheatreEvent>(
      (event, emit) {
        final distance = onMarkerTapped(
            markerLocation: event.selectedTheatre.latLng,
            userLocation: event.userLocation);
        emit(
          TheatreSelectedState(
            event.selectedTheatre,distance
          ),
        );
      },
    );
    on<SearchTheatresEvent>(searchTheatresinTheatrePage);
  }

  Future<void> fetchTheatres(
      FetchAllTheatresTheatreEvent event, Emitter<TheatreState> emit) async {
    try {
      final theatres = await TheatreRepository().fetchTheatres();
      emit(
        TheatresLoadedState(theatres),
      );
    } catch (e) {
      emit(
        TheatresLoadedErrorState('Error :$e'),
      );
    }
  }

  Future<void> searchTheatresinTheatrePage(
      SearchTheatresEvent event, Emitter<TheatreState> emit) async {
    try {
      final theatres =
          await TheatreRepository().searchTheatresInTheatrePage(event.query);
      emit(TheatresFilteredState(theatres));
    } catch (e) {
      emit(
        TheatresFilteredFailureState('Error: $e'),
      );
    }
  }
}

onMarkerTapped({required LatLng markerLocation, required LatLng userLocation}) {
  // tappedMarkerLocation = markerLocation;
  Distance distanceCalculator = const Distance();
  return distanceCalculator.as(
      LengthUnit.Kilometer, userLocation, markerLocation);
}
