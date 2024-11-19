import 'package:equatable/equatable.dart';

abstract class ShowsInTheatreEvent extends Equatable {
  const ShowsInTheatreEvent();
  @override
  List<Object> get props => [];
}

class ShowingMoviesUnTheatreEvent extends ShowsInTheatreEvent {
  final String email;
  final DateTime date;
  const ShowingMoviesUnTheatreEvent(this.email,this.date);
  @override
  List<Object> get props => [email];
}
