import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      backgroundColor: primaryColor,
      elevation: 0,
      pinned: true,
      floating: true,
      snap: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'WELCOME GUEST',
              style: TextStyle(
                  color: white, fontWeight: FontWeight.w600, fontSize: 25),
            ),
            const Text(
              'Kannur',
              style: TextStyle(color: white, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
