import 'package:expense_tracker_app/core/commons/widgets/double_action_alert_dialog.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/auth/views/bloc/auth_bloc.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:expense_tracker_app/features/home/widgets/expense_card.dart';
import 'package:expense_tracker_app/features/home/widgets/stat_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  final MyUser currentUser;
  final HomeInitializedState initializedState;
  const MainScreen(
      {required this.currentUser, required this.initializedState, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.initializedState.showAddIncomeDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        doubleActionAlertDialog(context,
            title: "No Income",
            content: "You have 0 income right now!\ntry adding some.",
            negativeButtonTitle: 'Cancel',
            positiveButtonTitle: 'Add Income',
            negativeCallBack: Navigator.of(context).pop, positiveCallBack: () {
          Navigator.of(context).pop();
        });
      });
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade700,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    CupertinoIcons.person_fill,
                    size: 30,
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome!",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.currentUser.fullName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      doubleActionAlertDialog(
                        context,
                        title: 'Signing Out!',
                        content: "Are you sure you want to sign out?",
                        negativeButtonTitle: 'Cancel',
                        positiveButtonTitle: 'Sign Out',
                        negativeCallBack: () {
                          Navigator.of(context).pop();
                        },
                        positiveCallBack: () {
                          Navigator.of(context).pop();
                          context.read<AuthBloc>().add(AuthSignOutEvent());
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.logout_sharp,
                      size: 30,
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            StatsCard(
              income: _getTotalIncome(widget.initializedState.incomes),
              expensesAmount:
                  _getTotalExpenses(widget.initializedState.expenses),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.initializedState.expenses.length,
                  itemBuilder: (context, index) {
                    return ExpenseCard(
                      expense: widget.initializedState.expenses[index],
                      icon: _getIcon(widget
                          .initializedState.expenses[index].expenseCategory),
                      backgroundColor: index % 2 == 0
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.primary,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  IconData _getIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.education:
        return FontAwesomeIcons.bookAtlas;
      case ExpenseCategory.entertainment:
        return FontAwesomeIcons.video;
      case ExpenseCategory.food:
        return FontAwesomeIcons.burger;
      case ExpenseCategory.grocery:
        return FontAwesomeIcons.kitchenSet;
      case ExpenseCategory.travel:
        return FontAwesomeIcons.car;
      case ExpenseCategory.misc:
        return Icons.extension_sharp;

      default:
        return Icons.abc;
    }
  }

  double _getTotalExpenses(List<ExpenseEntity> transactions) {
    double expenseAmount = 0;
    for (var transaction in transactions) {
      expenseAmount += transaction.expenseAmount;
    }

    return expenseAmount;
  }

  double _getTotalIncome(List<IncomeEntity> incomes) {
    double totalIncome = 0;
    for (var income in incomes) {
      totalIncome += income.amount;
    }

    return totalIncome;
  }
}
