import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class PlayButton extends StatelessWidget {
  final void Function()? onTap;
  const PlayButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 57, 57, 57).withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3),
            )
          ],
          shape: BoxShape.circle,
          color: white,
        ),
        child: const Icon(
          Icons.play_arrow,
          size: 44,
        ),
      ),
    );
  }
}
