import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget ratingBar(
    {required BuildContext context,
    required String star,
    required double value,
    required String percentage}) {
  final width = MediaQuery.of(context).size.width;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        star,
        style: TextStyle(
          fontSize: width * 0.02,
        ),
      ),
      Icon(Icons.star, size: width * 0.02, color: primaryColor),
      SizedBox(
        width: width * 0.01,
      ),
      SizedBox(
        width: width * 0.4,
        child: LinearProgressIndicator(
          value: value,
          minHeight: 5,
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation(primaryColor),
        ),
      ),
      SizedBox(
        width: width * 0.02,
      ),
      Text(
        percentage,
        style: TextStyle(fontSize: width * 0.02),
      ),
      SizedBox(
        width: width * 0.06,
      ),
    ],
  );
}
