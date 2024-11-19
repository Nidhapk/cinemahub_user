import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class AppTextstyles {
  static  TextStyle headlineLarge =
      TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: primaryColor);
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );
  static  TextStyle forgetPassStyle =
      TextStyle(color: primaryColor, decoration: TextDecoration.underline);
}
