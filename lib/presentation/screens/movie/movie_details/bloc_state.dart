import 'package:equatable/equatable.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieClass movie;
  final bool isDescriptionExpanded;
  final bool reviewAdded;
  final Map<int, double> ratings;

  const MovieDetailsLoaded(this.movie, this.reviewAdded,this.ratings,
      {this.isDescriptionExpanded = false});

  @override
  List<Object> get props => [movie,reviewAdded,ratings, isDescriptionExpanded];

  MovieDetailsLoaded copyWith({bool? isDescriptionExpanded}) {
    return MovieDetailsLoaded(
      movie,
      reviewAdded,ratings,
      isDescriptionExpanded:
          isDescriptionExpanded ?? this.isDescriptionExpanded,
    );
  }
}

class MovieError extends MovieDetailsState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class DescriptionCollapsed extends MovieDetailsState {}

// State when the description is expanded
class DescriptionExpanded extends MovieDetailsState {}

class VideoLoadingState extends MovieDetailsState {}

class VideoPlayingState extends MovieDetailsState {
  final YoutubePlayerController controller;
  final bool isFullScreen; // Add this field

  const VideoPlayingState(
      this.controller, this.isFullScreen); // Update constructor

  VideoPlayingState copyWith({
    YoutubePlayerController? controller,
    bool? isFullScreen,
  }) {
    return VideoPlayingState(
      controller ?? this.controller,
      isFullScreen ?? this.isFullScreen,
    );
  }
}
