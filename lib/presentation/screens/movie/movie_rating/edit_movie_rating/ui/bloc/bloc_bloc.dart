import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/movies_repository.dart';
import 'package:userside/presentation/screens/movie/movie_rating/add_movie_rating/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movie/movie_rating/edit_movie_rating/ui/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movie/movie_rating/edit_movie_rating/ui/bloc/bloc_state.dart';

class EditMovieRatingReviewBloc
    extends Bloc<EditMovieRatingReviewEvent, EditMovieRatingReviewState> {
  EditMovieRatingReviewBloc()
      : super(EditMovieRatingReviewStateInitialState()) {
     on<EditMovieRatingTapedEvent>(addRating);
    on<EditMovieReviewSubmitted>(submitMovieRatingReview);
     on<EditClearMovieRatingEvent>(clearRating);
  }

  Future<void> addRating(
      EditMovieRatingTapedEvent event, Emitter<EditMovieRatingReviewState> emit) async {
    emit(
      EditMovieRatingState(rating: event.rating),
    );
  }

  Future<void> submitMovieRatingReview(EditMovieReviewSubmitted event,
      Emitter<EditMovieRatingReviewState> emit) async {
    // emit(MovieRatingState(rating: event.review.rating));
    log('${MovieRatingState(rating: event.review.rating)}');
    emit(
      EditMovieRatingReviewSubmittingState(event.review.rating),
    );
    try {
      await MoviesRepository().editUserReview(
          movieId: event.review.movieId,
          newComment: event.review.comment,
          newRating: event.review.rating);
      emit(
        const EditMovieRatingReviewSubmitSuccessState(),
      );
    } catch (e) {
      emit(
        EditMovieRatingReviewSubmitErrorState('Error: $e'),
      );
    }
  }

  Future<void> clearRating(
      EditClearMovieRatingEvent event, Emitter<EditMovieRatingReviewState> emit) async {
    emit(EditMovieRatingState(rating: event.rating));
  }
}
