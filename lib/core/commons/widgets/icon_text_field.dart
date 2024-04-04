import 'package:flutter/material.dart';

class IconTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType inputType;
  final bool passwordField;
  final bool allowAmountValueOnly;

  const IconTextFieldWidget(
      {required this.controller,
      required this.icon,
      this.hintText = '',
      this.inputType = TextInputType.text,
      this.passwordField = false,
      this.allowAmountValueOnly = false,
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
          if (inputType == TextInputType.emailAddress) {
            if (!value.contains('@') || !value.contains('.com')) {
              return "Invalid email address.";
            }
          }
          if (allowAmountValueOnly) {
            try {
              double.parse(value);
              return null;
            } catch (e) {
              return 'Please enter a valid number';
            }
          }
          return null;
        }
      },
    );
  }
}
