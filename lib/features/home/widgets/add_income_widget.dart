import 'package:expense_tracker_app/core/commons/widgets/common_gradient_button.dart';
import 'package:expense_tracker_app/core/commons/widgets/icon_text_field.dart';
import 'package:flutter/material.dart';

void addIncomeDialog(
  BuildContext context, {
  required TextEditingController controller,
  required String negativeButtonTitle,
  required String positiveButtonTitle,
  required Function() negativeCallBack,
  required Function() positiveCallBack,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: const Text(
              "Add Income",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            content:
                IconTextFieldWidget(controller: controller, icon: Icons.money),
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
                          buttonTitle: positiveButtonTitle,
                          onTap: positiveCallBack)),
                ],
              ),
            ],
          ),
        );
      });
}
