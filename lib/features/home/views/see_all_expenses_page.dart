import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class SeeAllExpensesPage extends StatelessWidget {
  final List<ExpenseEntity> expenses;
  final Currency currency;
  const SeeAllExpensesPage(
      {required this.currency, required this.expenses, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('All Transactions'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: Navigator.of(context).pop,
                color: Theme.of(context).colorScheme.error,
                icon: const Icon(
                  Icons.close,
                  size: 30,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              return ExpenseCard(
                  expense: expenses[index],
                  backgroundColor: index % 2 == 0
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                  icon: getIconForExpenseCategory(
                      expenses[index].expenseCategory),
                  currency: currency);
            }),
      ),
    );
  }
}
