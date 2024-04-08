import 'package:flutter/material.dart';

class IconTextFieldWidget extends StatefulWidget {
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
  State<IconTextFieldWidget> createState() => _IconTextFieldWidgetState();
}

class _IconTextFieldWidgetState extends State<IconTextFieldWidget> {
  bool _obsecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText: _obsecurePassword,
      decoration: InputDecoration(
        suffixIcon: widget.passwordField
            ? Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: _getIcon(),
              )
            : null,
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.icon,
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
          if (widget.inputType == TextInputType.emailAddress) {
            if (!value.contains('@') || !value.contains('.com')) {
              return "Invalid email address.";
            }
          }
          if (widget.allowAmountValueOnly) {
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

  Widget _getIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _obsecurePassword = !_obsecurePassword;
        });
      },
      child: Icon(
        _obsecurePassword ? Icons.visibility_off : Icons.visibility,
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}
