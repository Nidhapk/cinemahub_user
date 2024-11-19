import 'package:flutter/material.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/presentation/screens/movie/movie_details/movie_details.dart';

Widget customComingSoon({required List<MovieClass> movies}) {
  return GridView.builder(
    shrinkWrap: true,
    padding: const EdgeInsets.all(16),
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.5,
    ),
    itemCount: movies.length,
    itemBuilder: (context, index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
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
            child: Container(
              height: 150,
              width: 108,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.2),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(movies[index].posterImage),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movies[index].movieName,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 110,
            child: Text(
              movies[index].genres.join(', '),
              style: const TextStyle(
                fontSize: 10,
                color: Color.fromARGB(255, 140, 140, 141),
              ),
            ),
          )
        ],
      );
    },
  );
}
