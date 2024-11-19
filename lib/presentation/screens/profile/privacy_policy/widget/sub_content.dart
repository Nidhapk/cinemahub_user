import 'package:flutter/material.dart';

Widget subContent({required String title, required String subtitle}) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(text: title, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: '$subtitle\n')
      ],
    ),
  );
}
