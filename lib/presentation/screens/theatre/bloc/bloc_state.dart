import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/theatre_model.dart';

abstract class TheatreState extends Equatable {
  const TheatreState();
  @override
  List<Object> get props => [];
}

class TheatresInitialstate extends TheatreState {
  const TheatresInitialstate();
  @override
  List<Object> get props => [];
}

class TheatresLoadedState extends TheatreState {
  final List<TheatreModel> theatres;
  const TheatresLoadedState(this.theatres);
  @override
  List<Object> get props => [theatres];
}

class TheatresLoadedErrorState extends TheatreState {
  final String error;
  const TheatresLoadedErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class TheatreSelectedState extends TheatreState {
  final TheatreModel theatre;
  final distance;
  const TheatreSelectedState(this.theatre,this.distance);
  @override
  List<Object> get props => [theatre,distance];
}

class TheatresFilteredState extends TheatreState {
  final List<TheatreModel> filteredTheatres;

  const TheatresFilteredState(this.filteredTheatres);
  @override
  List<Object> get props => [filteredTheatres];
}

class TheatresFilteredFailureState extends TheatreState {
  final String error;
  const TheatresFilteredFailureState(this.error);

  @override
  List<Object> get props => [error];
}
