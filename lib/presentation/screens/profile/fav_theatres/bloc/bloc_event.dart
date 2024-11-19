import 'package:equatable/equatable.dart';

abstract class FavTheatresInFavEvent extends Equatable {
  const FavTheatresInFavEvent();
  @override
  List<Object> get props => [];
}

class FetchFavTheatresInFavEvent extends FavTheatresInFavEvent {
  final String emailId;
  const FetchFavTheatresInFavEvent(this.emailId);
  @override
  List<Object> get props => [emailId];
}
