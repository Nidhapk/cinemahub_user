import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/home/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movies/widget/custom_coming_soon.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget allComingSoonMovies() {
  return BlocBuilder<ComingSoonMovieBloc, ComingsoonMovieState>(
    builder: (context, state) {
      if (state is MoviesLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ComingSoonMoviesSuccess) {
        final movies = state.comingSoonMovies;
        if (movies.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
                child: Text(
                  '   Coming Soon',
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
              customComingSoon(
                movies: movies.map((movies) => movies).toList(),
              ),
            ],
          );
        }
      } else if (state is ComingMoviesError) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return const Text('Something went wrong');
      }
    },
  );
}
