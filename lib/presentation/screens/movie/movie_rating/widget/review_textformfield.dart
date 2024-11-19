import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget reviewTextFormField({required TextEditingController reviewController }) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
    child: TextFormField(
      maxLines: null,
      minLines: 1,
      controller: reviewController,
      decoration: InputDecoration(
        labelText: 'Write your review (optional)',
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        focusColor: primaryColor,
      ),
    ),
  );
}
