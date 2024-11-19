import 'package:flutter/material.dart';
import 'package:userside/data/model/movie/movie_model.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget customVotes(
    {required BuildContext context,
    required double averageRating,
    required MovieClass movie}) {
  final width = MediaQuery.of(context).size.width;
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Icon(
        Icons.star_outlined,
        shadows: [
          Shadow(
            color: Color.fromARGB(
              255,
              199,
              198,
              198,
            ),
            blurRadius: 2,
          )
        ],
        color: Color.fromARGB(
          255,
          250,
          201,
          6,
        ),
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
            255,
            79,
            78,
            78,
          ),
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        width: width * 0.09,
      ),
      Container(
        padding: EdgeInsets.only(
          left: width * 0.01,
          right: width * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5,
          ),
          color: primaryColor.withOpacity(
            0.1,
          ),
        ),
        child: Row(
          children: [
            Text(
              movie.review.length.toString(),
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: width * 0.028,
              ),
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Text(
              'Votes',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: width * 0.028,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
