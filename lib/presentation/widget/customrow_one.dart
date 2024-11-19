import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class RowOne extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String textTwo;
  const RowOne({super.key, required this.onPressed, required this.text,required this.textTwo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(textTwo),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style:  TextStyle(color: primaryColor),
          ),
        )
      ],
    );
  }
}
