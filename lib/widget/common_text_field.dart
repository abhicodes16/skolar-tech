import 'package:flutter/material.dart';

import '../style/theme_constants.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String validatorText;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final bool isEnable;

  const CommonTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.validatorText = "",
    this.keyboardType,
    this.inputAction,
    this.isEnable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: inputAction ?? TextInputAction.next,
      enabled: isEnable,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => (value ?? "").isEmpty ? validatorText : null,
      style: const TextStyle(
        fontFamily: kThemeFont,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      decoration: _textFieldDecoration(label: label),
    );
  }

  InputDecoration _textFieldDecoration({String? label}) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 2.0, color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 2.0, color: kAccentColor)),
      contentPadding: const EdgeInsets.all(15.0),
      labelText: "$label",
      labelStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
