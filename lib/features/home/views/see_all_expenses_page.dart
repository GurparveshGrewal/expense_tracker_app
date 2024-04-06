import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class SeeAllExpensesPage extends StatefulWidget {
  final List<ExpenseEntity> expenses;
  final Currency currency;
  const SeeAllExpensesPage(
      {required this.currency, required this.expenses, super.key});

  @override
  State<SeeAllExpensesPage> createState() => _SeeAllExpensesPageState();
}

class _SeeAllExpensesPageState extends State<SeeAllExpensesPage> {
  ExpenseCategory? _selectedExpense;

  List<ExpenseEntity> _getExpenses() {
    if (_selectedExpense == null) {
      return widget.expenses;
    }

    return widget.expenses
        .where((expense) => expense.expenseCategory == _selectedExpense)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<ExpenseEntity> expenses = _getExpenses();
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.list,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: const FittedBox(
                              child: Text("Filter based on category")),
                          value: _selectedExpense,
                          items: [
                            if (_selectedExpense != null)
                              const DropdownMenuItem<ExpenseCategory>(
                                  value: null,
                                  child: Text(
                                    'Clear',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )),
                            ...ExpenseCategory.values.map((value) =>
                                DropdownMenuItem<ExpenseCategory>(
                                    value: value,
                                    child: Text(enumValueToString(value)))),
                          ],
                          onChanged: (selectedValue) {
                            setState(() {
                              if (selectedValue == _selectedExpense) {
                                _selectedExpense = null;
                              } else {
                                _selectedExpense = selectedValue;
                              }
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            expenses.isNotEmpty
                ? Expanded(
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
                              currency: widget.currency);
                        }),
                  )
                : Center(
                    child: FittedBox(
                      child: Text(
                        'No Expenses to show yet!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
