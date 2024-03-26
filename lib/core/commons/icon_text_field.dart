import 'package:flutter/material.dart';

class IconTextFieldWidget extends StatelessWidget {
  final IconData icon;

  const IconTextFieldWidget({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
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
    );
  }
}
