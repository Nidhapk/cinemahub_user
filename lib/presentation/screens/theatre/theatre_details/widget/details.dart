import 'package:flutter/material.dart';

Widget theatreDetailsInDetailPage(
    {required BuildContext context,
    required IconData icon,
    required Color color,
    required String text}) {
  final width = MediaQuery.of(context).size.width;
  return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(width * 0.01),
          child: Icon(
            icon,
            color: color,
            size: width * 0.05,
          ),
        ),
        SizedBox(
          width: width * 0.05,
        ),
        Expanded(
          child: Text(text),
        ),
      ]);
}
