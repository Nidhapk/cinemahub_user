import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: white,
                  ),
                ),
              );
  }
}