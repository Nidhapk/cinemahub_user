import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/movie_model.dart';

abstract class ComingsoonMovieState extends Equatable {
  const ComingsoonMovieState();
  @override
  List<Object> get props => [];
}

class ComingMoviesInitial extends ComingsoonMovieState {
 const  ComingMoviesInitial();
  @override
  List<Object> get props => [];
}

class ComingSoonMoviesLoading extends ComingsoonMovieState {
 const ComingSoonMoviesLoading();
  @override
  List<Object> get props => [];
} // General loading state if needed

class ComingSoonMoviesSuccess extends ComingsoonMovieState {
  final List<MovieClass> comingSoonMovies;

  const ComingSoonMoviesSuccess({
    required this.comingSoonMovies,
  });
  @override
  List<Object> get props => [comingSoonMovies];
}

class ComingMoviesError extends ComingsoonMovieState {
  final String message;
  const ComingMoviesError(this.message);
  @override
  List<Object> get props => [message];
}
