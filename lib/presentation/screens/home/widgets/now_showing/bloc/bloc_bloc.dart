import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/data/model/movie/movie_review_model.dart';
import 'package:userside/data/services/movies_repository.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/bloc/bloc_state.dart';

class NowShowingMovieBloc
    extends Bloc<NowShowingMovieEvent, NowShowingMovieMovieState> {
  NowShowingMovieBloc() : super(const ComingMoviesInitial()) {
    on<FetchNowShowingMovieEvent>(fetchNowShowingMovies);
  }

  Future<void> fetchNowShowingMovies(FetchNowShowingMovieEvent event,
      Emitter<NowShowingMovieMovieState> emit) async {
    emit(const NowShowingMoviesLoading());
    try {
      final nowShowingMovies = await MoviesRepository().nowShowingMovies();
      final Map<String, MovieClass> uniqueMoviesMap = {};

      // Ensure uniqueness by movie name
      for (var show in nowShowingMovies) {
        final movie = show;
        log('movie id: ${movie.movieId}');
        uniqueMoviesMap[movie.movieName] =
            movie; // Ensure uniqueness by movie name
      }

      // Convert the map values to a list of unique movies
      final uniqueMovies = uniqueMoviesMap.values.toList();

      // Create a list with movies and their average ratings
      final moviesWithAverageRatings = uniqueMovies.map((movie) {
        final reviews =
            movie.review; // Assuming movie has a List<MovieReviewModel>
        final averageRating = calculateAverageRating(reviews);
        return {
          'movie': movie,
          'averageRating': averageRating,
        };
      }).toList();

      // Emit success state with all unique movies and their ratings
      emit(
        NowShowingMoviesSuccess(
          nowShowingMovies: moviesWithAverageRatings,
        ),
      );
    } catch (e) {
      emit(
        NowShowingMoviesError('Error fetching Now Showing movies: $e'),
      );
    }
  }
}

double calculateAverageRating(List<MovieReviewModel> reviews) {
  if (reviews.isEmpty) return 0.0;

  final totalRating = reviews.fold(0.0, (sum, review) => sum + review.rating);
  return totalRating / reviews.length;
}
