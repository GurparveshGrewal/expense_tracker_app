import 'package:expense_tracker_app/core/commons/widgets/common_gradient_button.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCard extends StatefulWidget {
  final ExpenseEntity expense;
  final Color backgroundColor;
  final IconData icon;
  final Currency currency;

  const ExpenseCard(
      {required this.expense,
      required this.backgroundColor,
      required this.icon,
      required this.currency,
      super.key});

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Dismissible(
        key: Key(widget.expense.expenseId),
        confirmDismiss: (_) async {
          final confirmed = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Remove Expense',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                content: Text(
                  'Are you sure you want to remove expense - ${widget.expense.note}?',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            // Dismiss the dialog and return false
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey.shade800),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CommonGradientButton(
                          disabled: false,
                          buttonTitle: 'Remove',
                          onTap: () => Navigator.of(context).pop(true),
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
          );
          return confirmed;
        },
        onDismissed: (_) {
          context.read<HomeBloc>().add(
              HomeDeleteExpenseFromDatabaseEvent(widget.expense.expenseId));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Card(
            elevation: 5,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isExpanded ? 150 : 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: !_isExpanded
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: widget.backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      widget.icon,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.expense.note,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            FittedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${getTextForCurrency(widget.currency)}${widget.expense.expenseAmount.toString()}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    convertDateToReadable(
                                        widget.expense.expenseDate),
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: widget.backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      widget.icon,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.expense.note,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${getTextForCurrency(widget.currency)}${widget.expense.expenseAmount.toString()}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    convertDateToReadable(
                                        widget.expense.expenseDate),
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
          ),
        ),
      ),
    );
  }
}
