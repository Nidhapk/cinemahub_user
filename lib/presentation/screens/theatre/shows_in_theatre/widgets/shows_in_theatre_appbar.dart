import 'package:flutter/material.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/ui/theatre_details.dart';
import 'package:userside/presentation/themes/app_colors.dart';

PreferredSizeWidget showsInTheatreAppbar(
    {required TheatreModel theatre, required BuildContext context}) {
  return AppBar(
    backgroundColor: white,
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 13,
        )),
    title: Text(
      theatre.name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    actions: [
      TextButton.icon(
        label: const Text('Details'),
        icon: const Icon(
          Icons.info_outline,
          size: 18,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TheatreDetailsScreen(theatre: theatre),
            ),
          );
        },
      )
    ],
  );
}
