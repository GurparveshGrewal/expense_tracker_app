import 'package:expense_tracker_app/core/commons/widgets/common_gradient_button.dart';
import 'package:flutter/material.dart';

void doubleActionAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String negativeButtonTitle,
  required String positiveButtonTitle,
  required Function() negativeCallBack,
  required Function() positiveCallBack,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: negativeCallBack,
                        child: Text(
                          negativeButtonTitle,
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade800),
                        ))),
                Expanded(
                    child: CommonGradientButton(
                        disabled: false,
                        buttonTitle: positiveButtonTitle,
                        onTap: positiveCallBack)),
              ],
            ),
          ],
        );
      });
}
