import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/movie_review_model.dart';

abstract class MovieRatingReviewEvent extends Equatable {
  const MovieRatingReviewEvent();

  @override
  List<Object?> get props => [];
}

class MovieRatingTapedEvent extends MovieRatingReviewEvent {
  final int rating;

  const MovieRatingTapedEvent(this.rating);

  @override
  List<Object?> get props => [rating];
}

class MovieReviewSubmitted extends MovieRatingReviewEvent {
  final MovieReviewModel review;
  const MovieReviewSubmitted({required this.review});
  @override
  List<Object?> get props => [review];
}

class ClearMovieRatingEvent extends MovieRatingReviewEvent {
  final int rating;
 const ClearMovieRatingEvent(this.rating);
  @override
  List<Object?> get props => [rating];
}
