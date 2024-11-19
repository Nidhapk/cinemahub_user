import 'package:flutter/material.dart';


Widget customRatingBar(
    {
      required void Function()? onPressed, required int rating,}) {
  return SizedBox(
    height: 50,
    child: Center(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return IconButton(
            onPressed:onPressed,
            icon: Icon(
              rating > index ? Icons.star_sharp : Icons.star_border_outlined,
              color: rating > index
                  ? const Color.fromARGB(255, 240, 217, 15)
                  : const Color.fromARGB(255, 61, 61, 61),
            ),
          );
        },
      ),
    ),
  );
}
