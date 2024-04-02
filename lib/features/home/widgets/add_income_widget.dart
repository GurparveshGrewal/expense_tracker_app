import 'package:expense_tracker_app/core/commons/widgets/common_gradient_button.dart';
import 'package:expense_tracker_app/core/commons/widgets/icon_text_field.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

void addIncomeDialog(
  BuildContext context, {
  required String uid,
  required TextEditingController controller,
  required String negativeButtonTitle,
  required String positiveButtonTitle,
  required Function() negativeCallBack,
  required Function() positiveCallBack,
}) {
  final globalKey = GlobalKey<FormState>();
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
            content: Form(
                key: globalKey,
                child: IconTextFieldWidget(
                    allowAmountValueOnly: true,
                    controller: controller,
                    icon: Icons.money)),
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
                          onTap: () {
                            if (globalKey.currentState!.validate()) {
                              Navigator.of(context).pop();
                              context
                                  .read<HomeBloc>()
                                  .add(HomeAddIncomeToDatabaseEvent(
                                      income: IncomeEntity(
                                    userId: uid,
                                    incomeId: const Uuid().v4(),
                                    amount:
                                        double.parse(controller.text.trim()),
                                    date: DateTime.now(),
                                  )));
                            }
                          })),
                ],
              ),
            ],
          ),
        );
      });
}
