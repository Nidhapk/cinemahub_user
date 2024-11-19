import 'package:flutter/material.dart';

import 'package:userside/presentation/themes/app_colors.dart';

Widget movieRating({
  required BuildContext context,
  required String title,
  required String averagerating,
  required void Function()? rateMovieonPressed,
}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Column(
    children: [
      SizedBox(
        height: height * 0.05,
      ),
      Container(
        height: height * 0.075,
        color: const Color.fromARGB(255, 232, 226, 243).withOpacity(0.5),
        width: width,
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ratings & Reviews',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              SizedBox(
                height: height * 0.04,
                width: width * 0.35,
                child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.zero,
                        foregroundColor: primaryColor,
                        backgroundColor: primaryColor.withOpacity(0.1),
                        side: BorderSide(color: primaryColor)),
                    onPressed: rateMovieonPressed,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 13),
                    )),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: height * 0.05,
      ),
    ],
  );
}
