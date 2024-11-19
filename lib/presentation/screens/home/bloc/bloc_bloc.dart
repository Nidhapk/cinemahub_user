import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/shows_repository.dart';
import 'package:userside/presentation/screens/home/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/home/bloc/bloc_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MoviesInitial()) {
    on<FetchTodaysMoviesEvent>(fetchTodaysMovies);
  }

  // Future<void> fetchNowShowingMovies(
  //     FetchShowingMoviesEvent event, Emitter<MovieState> emit) async {
  //   try {

  //     final nowShowingMovies = await MoviesRepository().nowShowingMovies();

  //     // Emit success state with all movie types
  //     emit(MoviesSuccess(
  //       nowShowingMovies: nowShowingMovies,

  //     ));
  //   } catch (e) {
  //     emit(MoviesError('Error fetching Now Showing movies: $e'));
  //   }
  // }

  Future<void> fetchTodaysMovies(
      FetchTodaysMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MoviesLoading());
    try {
      final todaysShows = await ShowsRepository().fetchShowsForToday();
      log('1 $todaysShows');
      final todaysMovies =
          await ShowsRepository().fetchTodaysMoviesByShow(todaysShows);
      log('2 $todaysMovies');

      // Emit success state with all movie types
      emit(MoviesSuccess(
        todaysMovies: todaysMovies,
      ));
    } catch (e) {
      emit(MoviesError('Error fetching Today\'s movies: $e'));
    }
  }
}
