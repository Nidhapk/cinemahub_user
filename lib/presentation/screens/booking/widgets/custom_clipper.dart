import 'package:flutter/material.dart';

class CustomClipper140Degrees extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top-left
    path.moveTo(0, size.height * 0.6);

    // Draw the top-left angled corner
    path.lineTo(size.width * 0.1, 0);

    // Draw the top-right angled corner
    path.lineTo(size.width * 0.9, 0);
    path.lineTo(size.width, size.height * 0.6);

    // Draw the bottom-right straight line
    path.lineTo(size.width, size.height);

    // Draw the bottom-left straight line
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
