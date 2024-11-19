import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/movie_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();
  @override
  List<Object> get props => [];
}

class MoviesInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MovieState {
  @override
  List<Object> get props => [];
} // General loading state if needed

class MoviesSuccess extends MovieState {
 
 final List<MovieClass> todaysMovies;

 const MoviesSuccess(
      {required this.todaysMovies,
     });
 @override
      List<Object> get props => [todaysMovies];
}

class MoviesError extends MovieState {
  final String message;
 const  MoviesError(this.message);
   @override
  List<Object> get props => [message];
}
