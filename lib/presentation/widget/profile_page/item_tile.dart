import 'package:flutter/material.dart';

Widget itemTile(
    {required String title,
    required void Function()? onTap,
    required IconData icon}) {
  return ListTile(
    leading: Icon(
      icon,
      color: const Color.fromARGB(255, 84, 84, 84),
    ),
    onTap: onTap,
    title: Text(
      title,
      style: const TextStyle(fontSize: 13),
    ),
  );
}
