import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/movie/movie_details/movie_details.dart';
import 'package:userside/presentation/screens/search/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/search/bloc/bloc_state.dart';

Widget searchedMovies({
  required BuildContext context,
}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return BlocBuilder<SearchMovieBloc, SearchMovieStates>(
    builder: (context, state) {
      if (state is SearchMoviesloadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SearchMovieSuccessState) {
        final movies = state.movies;
        if (movies.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetailsScreen(
                        movieId: movies[index].movieName,
                        movieName: movies[index].movieName))),
                child: Container(
                  padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.05,
                    top: height * 0.02,
                    bottom: height * 0.02,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.18,
                        width: width * 0.24,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(movies[index].posterImage),
                          ),
                          color: const Color.fromARGB(
                            255,
                            248,
                            244,
                            244,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: Offset(2, 3),
                              color: Color.fromARGB(
                                255,
                                170,
                                170,
                                171,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            movies[index].movieName,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 67, 67, 67),
                            ),
                          ),
                          Text(
                            movies[index].genres.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: width * 0.5,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const Icon(
                                  color: Color.fromARGB(
                                    255,
                                    246,
                                    193,
                                    34,
                                  ),
                                  Icons.star_outlined,
                                  size: 15,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                            width: width * 0.55,
                            child: Text(
                              maxLines: 3,
                              movies[index].description,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0,
                thickness: 0.5,
              );
            },
          );
        } else {
          return const Center(
            child: Text('No movie found'),
          );
        }
      } else if (state is SearchMovieFailuresState) {
        return Center(
          child: Text('Error: ${state.error}'),
        );
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}
