import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/movie_review_model.dart';

abstract class EditMovieRatingReviewEvent extends Equatable {
  const EditMovieRatingReviewEvent();

  @override
  List<Object?> get props => [];
}

class EditMovieRatingTapedEvent extends EditMovieRatingReviewEvent {
  final int rating;

  const EditMovieRatingTapedEvent(this.rating);

  @override
  List<Object?> get props => [rating];
}

class EditMovieReviewSubmitted extends EditMovieRatingReviewEvent {
  final MovieReviewModel review;
  const EditMovieReviewSubmitted({required this.review});
  @override
  List<Object?> get props => [review];
}

class EditClearMovieRatingEvent extends EditMovieRatingReviewEvent {
  final int rating;
 const EditClearMovieRatingEvent(this.rating);
  @override
  List<Object?> get props => [rating];
}
