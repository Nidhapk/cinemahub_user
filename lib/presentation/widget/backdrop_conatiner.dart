import 'package:flutter/material.dart';

class BackDropContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String imgUrl;
  const BackDropContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 2)
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imgUrl),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width! / 2),
          bottomRight: Radius.circular(width! / 2),
        ),
      ),
    );
  }
}
