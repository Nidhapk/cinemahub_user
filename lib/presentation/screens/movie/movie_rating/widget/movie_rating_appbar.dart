import 'package:flutter/material.dart';

PreferredSizeWidget movieRatingAppbar(
    {required void Function()? onPressed, required String title}) {
  return AppBar(
    leading: IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back_ios_rounded),
    ),
    title: Text(title),
  );
}
