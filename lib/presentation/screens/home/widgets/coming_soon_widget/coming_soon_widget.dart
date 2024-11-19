import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/movie/movie_details/movie_details.dart';
import 'package:userside/presentation/screens/movies/ui/movies_screen.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class ComingSoonMoviesShows extends StatelessWidget {
  final String title;
  const ComingSoonMoviesShows({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // context.read<MovieBloc>().add(FetchcomingSoonMoviesEvent());
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      child: BlocBuilder<ComingSoonMovieBloc, ComingsoonMovieState>(
        builder: (context, state) {
          if (state is ComingSoonMoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ComingSoonMoviesSuccess) {
            final allMovies = state.comingSoonMovies;
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
                        movies.isNotEmpty
                            ? Text(
                                title,
                                style: const TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              )
                            : const SizedBox.shrink(),
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
                    height: height * 0.26,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailsScreen(
                                    movieId: movies[index].movieName,
                                    movieName: movies[index].movieName,
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
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          movies[index].posterImage),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 108,
                                  height: 140,
                                ),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                // SizedBox(
                                //   height: 10,
                                //   child: ListView.builder(
                                //     padding: EdgeInsets.zero,
                                //     shrinkWrap: true,
                                //     physics: const NeverScrollableScrollPhysics(),
                                //     scrollDirection: Axis.horizontal,
                                //     itemCount: 5,
                                //     itemBuilder: (context, index) {
                                //       return const Icon(
                                //         Icons.star,
                                //         color: Colors.yellow,
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
                                    movies[index].movieName,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                    movies[index].genres.join(', '),
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color:
                                            Color.fromARGB(255, 140, 140, 141)),
                                  ),
                                )
                                // Flexible(
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                //     children: [
                                //       SizedBox(
                                //         width: 90,
                                //         child: Text(
                                //           textAlign: TextAlign.left,
                                //           movies[index].movieName,
                                //           style: const TextStyle(
                                //               fontSize: 12,
                                //               fontWeight: FontWeight.w500),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // )
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
          } else if (state is ComingMoviesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('something went wrong'),
            );
          }
        },
      ),
    );
  }
}
