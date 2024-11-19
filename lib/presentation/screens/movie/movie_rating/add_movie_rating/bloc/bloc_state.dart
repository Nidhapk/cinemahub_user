import 'package:equatable/equatable.dart';

abstract class MovieRatingReviewState extends Equatable {
  const MovieRatingReviewState();
  @override
  List<Object> get props => [];
}

class MovieRatingReviewStateInitialState extends MovieRatingReviewState {}

class MovieRatingState extends MovieRatingReviewState {
  final int rating;
  const MovieRatingState({required this.rating});
  @override
  List<Object> get props => [rating];
}

class MovieRatingReviewSubmittingState extends MovieRatingReviewState {
  final int rating;
  const MovieRatingReviewSubmittingState(this.rating);
  @override
  List<Object> get props => [rating];
}

class MovieRatingReviewSubmitSuccessState extends MovieRatingReviewState {
  final String message;
  const MovieRatingReviewSubmitSuccessState(
      {this.message = 'Your Review has been successfully added'});
  @override
  List<Object> get props => [message];
}

class MovieRatingReviewSubmitErrorState extends MovieRatingReviewState {
  final String error;
  const MovieRatingReviewSubmitErrorState(this.error);
  @override
  List<Object> get props => [error];
}
