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

  const StatsCard(
      {required this.uid,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Total Balance",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            income > 0 ? '\$${(income - expensesAmount).toString()}' : "\$0.0",
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  income > 0
                      ? Container(
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
                        )
                      : Container(
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: () {
                              addIncomeDialog(context,
                                  controller: incomeTextController,
                                  negativeButtonTitle: 'Cancel',
                                  positiveButtonTitle: 'Add Income',
                                  negativeCallBack: Navigator.of(context).pop,
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
                              });
                            },
                            icon: const Icon(
                              size: 30,
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        income > 0 ? "Income" : "Add Income",
                        style: const TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        '\$${income.toString()}',
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
              Row(
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
                        '\$${expensesAmount.toString()}',
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
            ],
          ),
        ],
      ),
    );
  }
}
