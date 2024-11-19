import 'package:flutter/material.dart';
import 'package:userside/presentation/screens/profile/fav_theatres/ui/fav_theatres.dart';
import 'package:userside/presentation/screens/search/ui/search_movie_screen.dart';
import 'package:userside/presentation/themes/app_colors.dart';

PreferredSizeWidget homeAppbar(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return AppBar(
    backgroundColor: white,
    elevation: 0,
    surfaceTintColor: white,
    title: Image.asset(
      'assets/cinemhub_logo.png',
      height: height * 0.2,
      width: width * 0.45,
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FavTheatres(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8)),
          child: const Icon(
            color: Color.fromARGB(255, 149, 148, 148),
            Icons.favorite,
            size: 20,
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SearchMovieScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8)),
          child: const Icon(
            color: Color.fromARGB(255, 107, 106, 106),
            Icons.search_sharp,
            size: 20,
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
    ],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(0.1),
      child: Divider(
        height: 0,
        color: Colors.grey.withOpacity(0.5),
        thickness: 0.5,
      ),
    ),
  );
}
