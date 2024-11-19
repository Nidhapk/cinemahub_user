import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/movies/widget/coming_soon.dart';
import 'package:userside/presentation/screens/movies/widget/movie_appbar.dart';
import 'package:userside/presentation/screens/movies/widget/now_showing.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ComingSoonMovieBloc>().add(
          FetchcomingSoonMovieEvent(),
        );
    return Scaffold(
      backgroundColor: white,
      appBar: moviesScreenappBar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),
          allNowShowingMovies(),
          allComingSoonMovies()
        ],
      ),
    );
  }
}
