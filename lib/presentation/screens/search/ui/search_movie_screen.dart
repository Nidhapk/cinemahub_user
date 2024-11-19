import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/search/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/search/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/search/widgets/searched_movies.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({super.key});

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: const Color.fromARGB(255, 137, 136, 136),
        backgroundColor: white,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2.0),
          child: Divider(
            height: 1.5,
            thickness: 0.5,
            color: Color.fromARGB(255, 173, 172, 172),
          ),
        ),
        title: TextField(
          controller: searchController,
          autofocus: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(
              top: 10,
            ),
            suffixIcon: Icon(
              Icons.close,
              size: 18,
              color: Color.fromARGB(255, 137, 136, 136),
            ),
            hintText: 'Search for movies',
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 137, 136, 136),
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
          ),
          style: const TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
          onChanged: (value) {
            context.read<SearchMovieBloc>().add(
                  MovieSearchingByNameEvent(
                    value,
                  ),
                );
          },
        ),
      ),
      body: searchedMovies(
        context: context,
      ),
    );
  }
}
