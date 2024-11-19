import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

PreferredSizeWidget bookinAppbar(
    {required BuildContext context,
    required String movieName,
    required String theatreName}) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back_ios_rounded,
        size: 17,
      ),
    ),
    backgroundColor: Colors.transparent,
    foregroundColor: white,
    title: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$movieName\n',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: theatreName,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          )
        ],
      ),
    ),
  );
}
