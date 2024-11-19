import 'package:flutter/material.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/widget/main_photo_containers.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/widget/ontap_photocontainers.dart';

Widget photoGallery(
    {required BuildContext context, required TheatreModel theatre}) {
  final height = MediaQuery.of(context).size.height;
  return SizedBox(
    height: height * 0.4,
    child: Stack(
      children: [
        mainPhotoContainer(context: context, theatre: theatre),
        Align(
          alignment: Alignment.bottomCenter,
          child: onTapPhotoContainers(context: context, theatre: theatre),
        )
      ],
    ),
  );
}
