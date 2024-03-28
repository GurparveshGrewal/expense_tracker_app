import 'package:flutter/material.dart';

class IconTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType inputType;
  final bool passwordField;
  const IconTextFieldWidget(
      {required this.controller,
      required this.icon,
      this.hintText = '',
      this.inputType = TextInputType.text,
      this.passwordField = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: passwordField,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.outline,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field can't be empty";
        } else {
          return null;
        }
      },
    );
  }
}
