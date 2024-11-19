import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movies/widget/custom_movie_builder.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget allNowShowingMovies() {
  return BlocBuilder<NowShowingMovieBloc, NowShowingMovieMovieState>(
      builder: (context, state) {
    if (state is NowShowingMoviesLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is NowShowingMoviesSuccess) {
      final movies = state.nowShowingMovies;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
            child: Text(
              '    Now Showing',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            //  crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 19,
              ),
              Icon(
                Icons.circle,
                size: 5,
                color: primaryColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                movies.length == 1
                    ? '1 movie is showing'
                    : '${movies.length} movies are showing',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: primaryColor),
              )
            ],
          ),
          customMovieBuilder(
              context: context,
              title: 'Now Showing',
              moviesCount: movies.length,
              movies: movies),
        ],
      ); // Cast to MovieClass
    } else if (state is NowShowingMoviesError) {
      return Center(
        child: Text(state.message),
      );
    } else {
      return const Text('Something went wrong');
    }
  });
}
