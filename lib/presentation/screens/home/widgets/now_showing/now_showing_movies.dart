import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movie/movie_details/movie_details.dart';
import 'package:userside/presentation/screens/movies/ui/movies_screen.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class NowShowingMovies extends StatelessWidget {
  final String title;
  const NowShowingMovies({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        BlocBuilder<NowShowingMovieBloc, NowShowingMovieMovieState>(
          builder: (context, state) {
            if (state is NowShowingMoviesLoading) {
              return SizedBox(
                height: height * 0.4,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is NowShowingMoviesSuccess) {
              final allMovies = state.nowShowingMovies;
              final movies =
                  allMovies.length > 3 ? allMovies.sublist(0, 3) : allMovies;
              if (allMovies.isEmpty) {
                return const SizedBox.shrink();
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, top: 12, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          movies.isEmpty
                              ? const SizedBox.shrink()
                              : Text(
                                  title,
                                  style: const TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const MovieScreen(),
                                  ),
                                );
                              },
                              child: allMovies.length > 3
                                  ? Text(
                                      'View All',
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 11),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.263,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        itemCount: movies.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final movie = movies[index]['movie']
                              as MovieClass; // Access MovieClass instance
                          final averageRating =
                              movies[index]['averageRating'] as double;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                log('Now ; ${movies[index]['movie']}');
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                      movieId: movie.movieName,
                                      movieName: movie.movieName,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(movie.posterImage),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: 108,
                                    height: 140,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.star_outlined,
                                        shadows: [
                                          Shadow(
                                              color: Color.fromARGB(
                                                  255, 199, 198, 198),
                                              blurRadius: 2)
                                        ],
                                        color: Color.fromARGB(255, 250, 201, 6),
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Text(
                                        averageRating.toInt().toString(),
                                        style: TextStyle(
                                            fontSize: width * 0.03,
                                            color: const Color.fromARGB(
                                                255, 79, 78, 78),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: width * 0.09,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: width * 0.01,
                                            right: width * 0.01),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color:
                                                primaryColor.withOpacity(0.1)),
                                        child: Row(
                                          children: [
                                            Text(
                                              movie.review.length.toString(),
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: width * 0.028),
                                            ),
                                            SizedBox(
                                              width: width * 0.01,
                                            ),
                                            Text(
                                              'Votes',
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: width * 0.028),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  //   child: ListView.builder(
                                  //     padding: EdgeInsets.zero,
                                  //     shrinkWrap: true,
                                  //     physics:
                                  //         const NeverScrollableScrollPhysics(),
                                  //     scrollDirection: Axis.horizontal,
                                  //     itemCount: averageRating.toInt(),
                                  //     itemBuilder: (context, index) {
                                  //       return const Icon(
                                  //         shadows: [
                                  //           Shadow(
                                  //               color: Color.fromARGB(
                                  //                   255, 199, 198, 198),
                                  //               blurRadius: 2)
                                  //         ],
                                  //         Icons.star,
                                  //         color:
                                  //             Color.fromARGB(255, 250, 201, 6),
                                  //         size: 15,
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      movie.movieName,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            } else if (state is NowShowingMoviesError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('something went wrong'),
              );
            }
          },
        )
      ],
    );
  }
}
