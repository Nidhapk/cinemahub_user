import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/movie_review_model.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetailsinPageEvent extends MovieDetailsEvent {
  final String movieId;

  const FetchMovieDetailsinPageEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class ToggleDescriptionEvent extends MovieDetailsEvent {}

class PlayVideoEvent extends MovieDetailsEvent {
  final String videoUrl;
  final bool isFullScreen;

  const PlayVideoEvent(this.videoUrl, {this.isFullScreen = false});

  @override
  List<Object> get props => [videoUrl, isFullScreen];
}

class ToggleFullScreenEvent extends MovieDetailsEvent {
  final bool isFullScreen;

  const ToggleFullScreenEvent(this.isFullScreen);
}

class ShowAddReviewButton extends MovieDetailsEvent {}

class ShowRatingBarsEvent extends MovieDetailsEvent {
  final List<MovieReviewModel> reviews;
  const ShowRatingBarsEvent(this.reviews);
}
