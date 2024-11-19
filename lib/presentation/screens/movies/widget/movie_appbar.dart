import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

PreferredSizeWidget moviesScreenappBar() {
  return AppBar(
    backgroundColor: white,
    leading: const Icon(
      Icons.movie_filter,
      size: 24,
    ),
    titleSpacing: 0,
    title: const Text(
      'Movies',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
      ),
    ),
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Divider(
        height: 0,
      ),
    ),
  );
}
