import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/movies_repository.dart';
import 'package:userside/presentation/screens/movie/movie_rating/add_movie_rating/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movie/movie_rating/add_movie_rating/bloc/bloc_state.dart';

class MovieRatingReviewBloc
    extends Bloc<MovieRatingReviewEvent, MovieRatingReviewState> {
  MovieRatingReviewBloc() : super(MovieRatingReviewStateInitialState()) {
    on<MovieRatingTapedEvent>(addRating);
    on<MovieReviewSubmitted>(submitMovieRatingReview);
    on<ClearMovieRatingEvent>(clearRating);
  }

  Future<void> addRating(
      MovieRatingTapedEvent event, Emitter<MovieRatingReviewState> emit) async {
    emit(
      MovieRatingState(rating: event.rating),
    );
  }

  Future<void> submitMovieRatingReview(
      MovieReviewSubmitted event, Emitter<MovieRatingReviewState> emit) async {
    // emit(MovieRatingState(rating: event.review.rating));
    log('${MovieRatingState(rating: event.review.rating)}');
    emit(
      MovieRatingReviewSubmittingState(event.review.rating),
    );
    try {
      await MoviesRepository()
          .addReviewToMovie(event.review.movieId, event.review);
      emit(
        const MovieRatingReviewSubmitSuccessState(),
      );
    } catch (e) {
      emit(
        MovieRatingReviewSubmitErrorState('Error: $e'),
      );
    }
  }

  Future<void> clearRating(
      ClearMovieRatingEvent event, Emitter<MovieRatingReviewState> emit) async {
    emit(MovieRatingState(rating: event.rating));
  }
}
