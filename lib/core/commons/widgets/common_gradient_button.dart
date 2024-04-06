import 'dart:math';

import 'package:flutter/material.dart';

class CommonGradientButton extends StatelessWidget {
  final bool disabled;
  final String buttonTitle;
  final void Function() onTap;
  const CommonGradientButton({
    super.key,
    required this.disabled,
    required this.buttonTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: disabled ? Colors.grey : null,
          gradient: disabled
              ? null
              : LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.tertiary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                  transform: const GradientRotation(pi / 3.4),
                ),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              buttonTitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
