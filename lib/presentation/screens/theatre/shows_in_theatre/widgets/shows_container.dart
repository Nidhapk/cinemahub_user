import 'package:flutter/material.dart';
import 'package:userside/data/services/shows_repository.dart';
import 'package:userside/presentation/screens/movie/movie_details/movie_details.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget showsContainer({
  required BuildContext context,
  required List<ShowContainer> shows,
  required String movieName,
}) {
  final width = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: width * 0.53,
                child: Text(
                  movieName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(
                          movieId: movieName, movieName: movieName),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'View Movie Details',
                    style: TextStyle(color: primaryColor, fontSize: 11),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 14),
            height: 40,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: shows.length,
              itemBuilder: (context, index) {
                // final show = filteredShows[index];
                return Container(
                  width: 99,
                  height: 20,
                  margin: const EdgeInsets.only(
                    right: 11,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.7,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          shows[index].showTime,
                          style: const TextStyle(
                            color: green,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          shows[index].screen,
                          style: const TextStyle(
                            color: green,
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ),
  );
}
