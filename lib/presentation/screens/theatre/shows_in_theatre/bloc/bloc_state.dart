import 'package:equatable/equatable.dart';
import 'package:userside/data/services/shows_repository.dart';

abstract class ShowsInTheatreStates extends Equatable {
  const ShowsInTheatreStates();
  @override
  List<Object> get props => [];
}

class ShowsInTheatreInitialState extends ShowsInTheatreStates {
  const ShowsInTheatreInitialState();
  @override
  List<Object> get props => [];
}

class ShowInTheatreloadedState extends ShowsInTheatreStates {
  final Map<String, List<ShowContainer>> shows;
  const ShowInTheatreloadedState(this.shows);
  @override
  List<Object> get props => [shows];
}
class ShowInTheatreloadedErrorState extends ShowsInTheatreStates {
  final String error;
  const ShowInTheatreloadedErrorState(this.error);
  @override
  List<Object> get props => [error];
}