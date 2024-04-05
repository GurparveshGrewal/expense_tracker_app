import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:expense_tracker_app/features/home/widgets/add_income_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class StatsCard extends StatelessWidget {
  final double expensesAmount;
  final double income;
  final String uid;
  final Currency currency;

  const StatsCard(
      {required this.currency,
      required this.uid,
      required this.expensesAmount,
      required this.income,
      super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController incomeTextController = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.tertiary,
          ],
          transform: const GradientRotation(3.14 / 4),
        ),
      ),
      height: MediaQuery.of(context).size.width / 1.8,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: FittedBox(
              child: Column(
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    income > 0
                        ? '${getTextForCurrency(currency)}${(income - expensesAmount).toString()}'
                        : "${getTextForCurrency(currency)}0.0",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FittedBox(
                    child: GestureDetector(
                      onTap: () {
                        addIncomeDialog(
                          context,
                          uid: uid,
                          controller: incomeTextController,
                          negativeButtonTitle: "Cancel",
                          positiveButtonTitle: "Add Income",
                          negativeCallBack: () {
                            Navigator.of(context).pop();
                          },
                          positiveCallBack: () {
                            Navigator.of(context).pop();
                            context
                                .read<HomeBloc>()
                                .add(HomeAddIncomeToDatabaseEvent(
                                    income: IncomeEntity(
                                  userId: uid,
                                  incomeId: const Uuid().v4(),
                                  amount: double.parse(
                                      incomeTextController.text.trim()),
                                  date: DateTime.now(),
                                )));
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              CupertinoIcons.arrow_down,
                              size: 20,
                              color: Colors.greenAccent,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Income",
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              Text(
                                '${getTextForCurrency(currency)}${income.toString()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            CupertinoIcons.arrow_up,
                            size: 20,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Expenses",
                              style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '${getTextForCurrency(currency)}${expensesAmount.toString()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
