import 'package:flutter/material.dart';

SnackBar customSnackBar({
  required String text,
  required IconData icon,
  required Color iconColor,
  required Color borderColor,
  required Color backgroundColor,
}) {
  return SnackBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor)),
    content: Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        const SizedBox(
          width: 30,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
  );
}
