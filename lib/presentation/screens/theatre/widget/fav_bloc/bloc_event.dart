import 'package:equatable/equatable.dart';

abstract class FavTheatreEvent extends Equatable {
  const FavTheatreEvent();
  @override
  List<Object> get props => [];
}
class ToggleFavoriteEventInTheatre extends FavTheatreEvent {
  final String theatreId;
  final String userId;
  final bool isFavorite;

  const ToggleFavoriteEventInTheatre({
    required this.theatreId,
    required this.userId,
    required this.isFavorite,
  });
   @override
  List<Object> get props => [theatreId,userId,isFavorite];
}