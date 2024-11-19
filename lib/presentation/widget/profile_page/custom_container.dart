import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget customContainer(
    {required int itemCount,
    required Widget? Function(BuildContext, int) itemBuilder}) {
  return Container(
    decoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 0,
          thickness: 0.5,
          color: Color.fromARGB(255, 236, 236, 238),
        );
      },
    ),
  );
}
