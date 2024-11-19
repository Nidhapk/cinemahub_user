import 'package:equatable/equatable.dart';

abstract class FavTheatreStates extends Equatable {
  const FavTheatreStates();

  @override
  List<Object> get props => [];
}

class FavTheatreInitialState extends FavTheatreStates {
  const FavTheatreInitialState();
  @override
  List<Object> get props => [];
}

class TheatreFavoriteToggledState extends FavTheatreStates {
  final Map<String, bool>  isFavorite;


  const TheatreFavoriteToggledState(this.isFavorite);
  @override
  List<Object> get props => [isFavorite];
}

class TheatreFavoriteToggleFailureState extends FavTheatreStates {
  final String error;

  const TheatreFavoriteToggleFailureState(this.error);
  @override
  List<Object> get props => [error];
}
