import 'package:equatable/equatable.dart';

abstract class NowShowingMovieMovieState extends Equatable {
  const NowShowingMovieMovieState();
  @override
  List<Object> get props => [];
}

class ComingMoviesInitial extends NowShowingMovieMovieState {
 const  ComingMoviesInitial();
  @override
  List<Object> get props => [];
}

class NowShowingMoviesLoading extends NowShowingMovieMovieState {
 const NowShowingMoviesLoading();
  @override
  List<Object> get props => [];
} // General loading state if needed

class NowShowingMoviesSuccess extends NowShowingMovieMovieState {
  final List<Map<String, Object>>  nowShowingMovies;

  const NowShowingMoviesSuccess({
    required this.nowShowingMovies,
  });
  @override
  List<Object> get props => [nowShowingMovies];
}

class NowShowingMoviesError extends NowShowingMovieMovieState {
  final String message;
  const NowShowingMoviesError(this.message);
  @override
  List<Object> get props => [message];
}
