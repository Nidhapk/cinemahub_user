import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

PreferredSizeWidget showingTheatresAppbar(
    {required String titleMovie,
    required void Function()? searchOnTap,
    required void Function()? filterOntap}) {
  return AppBar(
    backgroundColor: white,
    title: Text(
      titleMovie,
      style: const TextStyle(fontWeight: FontWeight.w500),
    ),
    actions: [
      GestureDetector(
        onTap: searchOnTap,
        child: Image.asset(
          'assets/search_icon.png',
          height: 20,
          width: 50,
        ),
      ),
      GestureDetector(
        onTap: filterOntap,
        child: Image.asset(
          'assets/adjust.png',
          //height: 60,
          width: 25,
        ),
      ),
      const SizedBox(
        width: 18,
      )
    ],
  );
}
