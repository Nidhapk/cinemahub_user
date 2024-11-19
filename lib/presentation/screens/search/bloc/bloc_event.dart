import 'package:equatable/equatable.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();
  @override
  List<Object> get props => [];
}

class MovieSearchingByNameEvent extends SearchMovieEvent {
  final String query;
 const MovieSearchingByNameEvent(this.query);
  @override
  List<Object> get props => [query];
}
