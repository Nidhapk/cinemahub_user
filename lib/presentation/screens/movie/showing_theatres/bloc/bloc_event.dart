import 'package:equatable/equatable.dart';

class NowShowingPageEvent extends Equatable {
  const NowShowingPageEvent();
  @override
  List<Object> get props => [];
}

class BookNowOnpressedEvent extends NowShowingPageEvent {
  final String movieId;
  final DateTime selectedDate;
  const BookNowOnpressedEvent(
      {required this.movieId, required this.selectedDate});
  @override
  List<Object> get props => [movieId];
}

class SearchButtonOnPressedEvent extends NowShowingPageEvent {
  final bool searchOnpressed;
  const SearchButtonOnPressedEvent({required this.searchOnpressed});

  @override
  List<Object> get props => [searchOnpressed];
}

class SearchShowsByTheatreNameEvent extends NowShowingPageEvent {
  final String movieId;
  final String query;
  const SearchShowsByTheatreNameEvent({required this.query,required this.movieId});
  @override
  List<Object> get props => [query];
}
