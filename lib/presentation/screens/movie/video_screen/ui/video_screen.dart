import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/movie/movie_details/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/movie_details/bloc_event.dart';
import 'package:userside/presentation/screens/movie/movie_details/bloc_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatelessWidget {
  final String link;
  final moviedId;
  const VideoScreen({super.key, required this.link, required this.moviedId});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) {
        context
            .read<MovieDetailsBloc>()
            .add(FetchMovieDetailsinPageEvent(moviedId));
      },
      child: Scaffold(
        body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is VideoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is VideoPlayingState) {
              return YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: state.controller,
                  showVideoProgressIndicator: true,
                  aspectRatio: 16 / 9,
                ),
                builder: (context, player) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child:
                              player), // Ensure the player expands to available space
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
