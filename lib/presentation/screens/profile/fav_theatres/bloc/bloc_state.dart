import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/theatre_model.dart';

abstract class FavTheatresInFavState extends Equatable {
  const FavTheatresInFavState();
  @override
  List<Object> get props => [];
}

class FavTheatreInitialStateInfav extends FavTheatresInFavState {
  const FavTheatreInitialStateInfav();
  @override
  List<Object> get props => [];
}

class FavTheatreLaodedState extends FavTheatresInFavState {
  final List<TheatreModel> theatreModel;
  const FavTheatreLaodedState(this.theatreModel);
   @override
  List<Object> get props => [theatreModel];
}
class FavTheatreLaodederrorState extends FavTheatresInFavState {
  final String error;
  const FavTheatreLaodederrorState(this.error);
   @override
  List<Object> get props => [error];
}