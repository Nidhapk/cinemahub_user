import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget locationBar({required BuildContext context,required Widget icon}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  
  return Container(
    padding: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
        top: height * 0.02,
        bottom: height * 0.02),
    decoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       const Text('Location'),
      icon
      ],
    ),
  );
}
