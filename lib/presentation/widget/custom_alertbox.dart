import 'package:flutter/material.dart';

class CustomAlertBox extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  const CustomAlertBox({super.key, required this.title,required this.content,required this.confirmText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content), actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(confirmText),
   )    ] );
  }
}
