import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/movies_repository.dart';
import 'package:userside/presentation/screens/search/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/search/bloc/bloc_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieStates> {
  SearchMovieBloc() : super(const SearchMoviesInitialState()) {
    on<MovieSearchingByNameEvent>(searchingMoviebyName);
  }

  Future<void> searchingMoviebyName(
      MovieSearchingByNameEvent event, Emitter<SearchMovieStates> emit) async {
    try {
      
      if (event.query.isEmpty) {
        emit(const SearchMoviesInitialState());
      } else {
        final movies = await MoviesRepository().filterMoviesByName(event.query);
      emit(SearchMovieSuccessState(movies));
      }
      
    } catch (e) {
      emit(
        SearchMovieFailuresState('error: $e'),
      );
    }
  }
}
