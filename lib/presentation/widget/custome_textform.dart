import 'package:flutter/material.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final String labelText;
  final Widget? suffixIcon;
  final bool obscureText;
  const CustomTextForm(
      {super.key,
      required this.controller,
      this.validator,
      required this.hintText,
      required this.labelText,
      this.suffixIcon,required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          child:
        TextFormField(
            enabled: true,
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              constraints: const BoxConstraints(maxHeight: 50),
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              hintText: hintText,
              labelStyle: TextStyle(color: primaryColor, fontSize: 14),
              labelText: labelText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(
                  color: primaryColor,
                  width: 2.0,
                ),
              ),
            ),
            validator: validator)
    );
  }
}
