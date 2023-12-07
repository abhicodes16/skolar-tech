import 'package:flutter/material.dart';
import '../style/theme_constants.dart';

class CustomEditText extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  const CustomEditText({this.controller, this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 2.0, color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 2.0, color: kAccentColor)),
          contentPadding: const EdgeInsets.all(15.0),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
