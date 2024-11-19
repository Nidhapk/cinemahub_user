import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/data/services/shows_repository.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/widgets/calender_in_theatre.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/widgets/shows_container.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/widgets/shows_in_theatre_appbar.dart';

class ShowsInTheatresScreen extends StatelessWidget {
  final String email;
  final TheatreModel theatre;
  const ShowsInTheatresScreen(
      {super.key, required this.email, required this.theatre});

  @override
  Widget build(BuildContext context) {
    context.read<ShowsInTheatreBloc>().add(
          ShowingMoviesUnTheatreEvent(
            email,
            DateTime.now(),
          ),
        );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 236),
      appBar: showsInTheatreAppbar(theatre: theatre, context: context),
      body: Column(
        children: [
          customCalendarInTheatreScreen(email),
          BlocBuilder<ShowsInTheatreBloc, ShowsInTheatreStates>(
            builder: (context, state) {
              if (state is ShowsInTheatreInitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ShowInTheatreloadedState) {
                final movies = state.shows;
                log('moooooos $movies');
                if (movies.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(
                      top: 200,
                      bottom: 100,
                    ),
                    child: Center(
                      child: Text(
                        'No shows available on this day',
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movieEntry = movies.entries.toList()[index];
                        String movieName = movieEntry.key;
                        List<ShowContainer> shows = movieEntry.value;
                        return showsContainer(
                          context: context,
                          movieName: movieName,
                          shows: shows,
                        );
                      },
                    ),
                  );
                }
              } else if (state is ShowInTheatreloadedErrorState) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
