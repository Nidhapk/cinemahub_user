import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/home/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/bloc/bloc_state.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget todayShowingMoviesContainer(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return BlocBuilder<MovieBloc, MovieState>(
    builder: (context, state) {
      if (state is MoviesLoading) {
        return SizedBox(
          height: height * 0.4,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is MoviesSuccess) {
        final movies = state.todaysMovies;
        log('today $movies');
        if (movies.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                '   Today in Theatres',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Container(
                height: height * 0.25,
                width: width,
                color: const Color.fromARGB(255, 48, 48, 50),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: height * 0.18,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2 / 3,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                      items: movies
                          .map(
                            (item) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: height * 0.2,
                                  width: width * 0.27,
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 58, 58, 58),
                                          blurRadius: 4,
                                          spreadRadius: 2)
                                    ],
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(item.posterImage)),
                                    color: white,
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  // child: Text(item),
                                ),
                                SizedBox(
                                  width: width * 0.1,
                                ),
                                SizedBox(
                                  width: width * 0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.movieName,
                                        style: const TextStyle(
                                          color: white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Flexible(
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            final totalRating =
                                                item.review.fold<double>(
                                              0.0,
                                              (sum, review) =>
                                                  sum +
                                                  review
                                                      .rating, // Sum up all ratings
                                            );

                                            final average = totalRating /
                                                item.review.length;
                                            return Icon(
                                              Icons.star,
                                              color: index <= average.toInt()
                                                  ? Colors.yellow
                                                  : Colors.grey,
                                              size: 15,
                                            );
                                          },
                                        ),
                                      ),
                                      Text(
                                        item.duration.split(':')[1] == '00'
                                            ? '${item.duration.split(':')[0]} hr.  ${item.genres.join(', ')}'
                                            : '${item.duration.split(':')[0]} hr ${item.duration.split(':')[1]} min. ${item.genres.join(', ')}',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        item.description,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    SizedBox(
                      height: 33,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          maximumSize: Size(
                            width * 0.9,
                            height * 0.05,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }
      } else if (state is MoviesError) {
        return Text(state.message);
      } else {
        return Text('Something went wrong');
      }
    },
  );
}
