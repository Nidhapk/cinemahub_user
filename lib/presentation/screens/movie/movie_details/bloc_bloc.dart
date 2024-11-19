import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/movies_repository.dart';
import 'package:userside/presentation/screens/movie/movie_details/bloc_event.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'bloc_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MoviesRepository movieRepository;

  MovieDetailsBloc({required this.movieRepository})
      : super(MovieDetailsLoading()) {
    on<FetchMovieDetailsinPageEvent>(_onFetchMovieDetails);
    on<ToggleDescriptionEvent>(onToggleDescription);
    on<PlayVideoEvent>(_mapPlayVideoToState);
  }

  Future<void> _onFetchMovieDetails(FetchMovieDetailsinPageEvent event,
      Emitter<MovieDetailsState> emit) async {
    try {
      emit(MovieDetailsLoading());
      final movie = await movieRepository.getMovieByName(event.movieId);
      bool moviedAdded = await MoviesRepository()
          .checkIfUserHasRated(movie: movie, movieId: movie.movieId ?? '');
      final ratings = movieRepository.calculateStarPercentages(movie.review);
      emit(MovieDetailsLoaded(movie, moviedAdded,ratings));
    } catch (error) {
      emit(MovieError('Failed to fetch movie details.:$error'));
    }
  }

  void onToggleDescription(
      ToggleDescriptionEvent event, Emitter<MovieDetailsState> emit) {
    if (state is MovieDetailsLoaded) {
      final currentState = state as MovieDetailsLoaded;
      // Emit a new state with toggled description
      emit(currentState.copyWith(
        isDescriptionExpanded: !currentState.isDescriptionExpanded,
      ));
    }
  }

  Future<void> _mapPlayVideoToState(
      PlayVideoEvent event, Emitter<MovieDetailsState> emit) async {
    emit(VideoLoadingState());

    try {
      final videoId = YoutubePlayer.convertUrlToId(event.videoUrl)!;
      final controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
      );

      controller.initialVideoId;

      emit(VideoPlayingState(controller, event.isFullScreen));
    } catch (e) {
      emit(const MovieError('Failed to load video'));
    }
  }

  void _onToggleFullScreen(
      ToggleFullScreenEvent event, Emitter<MovieDetailsState> emit) {
    if (state is VideoPlayingState) {
      final currentState = state as VideoPlayingState;
      emit(currentState.copyWith(isFullScreen: event.isFullScreen));
    }
  }
}
