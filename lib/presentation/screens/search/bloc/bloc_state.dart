import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/movie_model.dart';

abstract class SearchMovieStates extends Equatable {
  const SearchMovieStates();
  @override
  List<Object> get props => [];
}

class SearchMoviesInitialState extends SearchMovieStates {
  const SearchMoviesInitialState();
  @override
  List<Object> get props => [];
}
class SearchMoviesloadingState extends SearchMovieStates {
  const SearchMoviesloadingState();
  @override
  List<Object> get props => [];
}
class SearchMovieSuccessState extends SearchMovieStates {
  final List<MovieClass> movies;
  const SearchMovieSuccessState(this.movies);
  @override
  List<Object> get props => [movies];
}

class SearchMovieFailuresState extends SearchMovieStates {
  final String error;
  const SearchMovieFailuresState(this.error);
  @override
  List<Object> get props => [error];
}
