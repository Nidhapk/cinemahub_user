import 'package:equatable/equatable.dart';

abstract class EditMovieRatingReviewState extends Equatable {
  const EditMovieRatingReviewState();
  @override
  List<Object> get props => [];
}

class EditMovieRatingReviewStateInitialState extends EditMovieRatingReviewState {}

class EditMovieRatingState extends EditMovieRatingReviewState {
  final int rating;
  const EditMovieRatingState({required this.rating});
  @override
  List<Object> get props => [rating];
}

class EditMovieRatingReviewSubmittingState extends EditMovieRatingReviewState {
  final int rating;
  const EditMovieRatingReviewSubmittingState(this.rating);
  @override
  List<Object> get props => [rating];
}

class EditMovieRatingReviewSubmitSuccessState extends EditMovieRatingReviewState {
  final String message;
  const EditMovieRatingReviewSubmitSuccessState(
      {this.message = 'Your Review has been successfully added'});
  @override
  List<Object> get props => [message];
}

class EditMovieRatingReviewSubmitErrorState extends EditMovieRatingReviewState {
  final String error;
  const EditMovieRatingReviewSubmitErrorState(this.error);
  @override
  List<Object> get props => [error];
}
