import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/presentation/screens/movie/movie_details/movie_details.dart';
import 'package:userside/presentation/screens/movies/widget/custom_votes.dart';

Widget customMovieBuilder(
    {required BuildContext context,
    required String title,
    required int moviesCount,
    required List<Map<String, Object>> movies}) {
  final height = MediaQuery.of(context).size.height;
  return GridView.builder(
    shrinkWrap: true,
    padding: const EdgeInsets.all(16),
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.55,
    ),
    itemCount: movies.length,
    itemBuilder: (context, index) {
      log('${movies.length}');
      final movie =
          movies[index]['movie'] as MovieClass; // Access MovieClass instance
      final averageRating = movies[index]['averageRating'] as double;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(
                    movieId: movie.movieName,
                    movieName: movie.movieName,
                  ),
                ),
              );
            },
            child: Container(
              height: 150,
              width: 108,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                color: Colors.grey.withOpacity(
                  0.2,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    movie.posterImage,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Flexible(
            child: customVotes(
              context: context,
              averageRating: averageRating,
              movie: movie,
            ),
          ),
          SizedBox(
            height: height * 0.006,
          ),
          Flexible(
            child: SizedBox(
              width: 100,
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                movie.movieName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}
