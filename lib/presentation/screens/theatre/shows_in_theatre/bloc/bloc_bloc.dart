import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/shows_repository.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/bloc/bloc_state.dart';

class ShowsInTheatreBloc
    extends Bloc<ShowsInTheatreEvent, ShowsInTheatreStates> {
  ShowsInTheatreBloc() : super(const ShowsInTheatreInitialState()) {
    on<ShowingMoviesUnTheatreEvent>(showingMoviesinTheatre);
  }

  Future<void> showingMoviesinTheatre(ShowingMoviesUnTheatreEvent event,
      Emitter<ShowsInTheatreStates> emit) async {
    emit(
      const ShowsInTheatreInitialState(),
    );
    try {
      final movies = await ShowsRepository()
          .showingMoviesInSelectedTheatre(event.email, event.date);
      log('$movies');
      emit(ShowInTheatreloadedState(movies));
    } catch (e) {
      emit(
        ShowInTheatreloadedErrorState('Error: $e'),
      );
    }
  }
}
