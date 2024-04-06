import 'package:expense_tracker_app/core/commons/widgets/loader.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/widgets/expense_card.dart';
import 'package:expense_tracker_app/features/stats/bloc/stats_bloc.dart';
import 'package:expense_tracker_app/features/stats/views/widgets/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsPage extends StatefulWidget {
  final DateTime fromDate;
  final DateTime toDate;

  const StatsPage({
    required this.fromDate,
    required this.toDate,
    super.key,
  });

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  void initState() {
    super.initState();
    context.read<StatsBloc>().add(StatsInitialFetch(
          income: 700,
          fromDate: widget.fromDate,
          toDate: widget.toDate,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Center(
          child: FittedBox(
            child: Text(
              "Analyze your Expenses (Weekly)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: BlocConsumer<StatsBloc, StatsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is StatsLoadingState) return const Loader();

          if (state is StatsInitializedState) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width / 1.5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: MyChart(
                            fromDate: widget.fromDate,
                            toDate: widget.toDate,
                            expenses: _getExpenses(
                                widget.fromDate, widget.toDate, state.expenses),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Text(
                            "${convertDateToReadable(widget.fromDate)} - ${convertDateToReadable(widget.toDate)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Transactions",
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '${getTextForCurrency(state.currency)}${_getTotalAmountForTheWeek(state.expenses).toString()}/-',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: state.expenses.isNotEmpty
                              ? ListView.builder(
                                  itemCount: state.expenses.length,
                                  itemBuilder: (context, index) {
                                    return ExpenseCard(
                                      currency: state.currency,
                                      expense: state.expenses[index],
                                      icon: Icons.food_bank_outlined,
                                      backgroundColor: index % 2 == 0
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                    );
                                  })
                              : Center(
                                  child: FittedBox(
                                    child: Text(
                                      'No Transactions for the week\nTry making some.',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  if (state.expenses.isEmpty)
                    Positioned(
                        top: MediaQuery.of(context).size.width / 5.5,
                        right: MediaQuery.of(context).size.width / 5.5,
                        left: MediaQuery.of(context).size.width / 5.5,
                        child: FittedBox(
                          child: Text(
                            'No Data for Analytics',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.outline),
                          ),
                        )),
                ],
              ),
            );
          }

          return const Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    );
  }

  List<double> _getExpenses(
      DateTime fromDate, DateTime toDate, List<ExpenseEntity> expenses) {
    List<double> expensesAmounts = List.filled(7, 0.0);

    for (int i = 0; i < 7; i++) {
      DateTime currentDate = fromDate.add(Duration(days: i));

      double totalAmount = expenses
          .where((expense) =>
              expense.expenseDate.year == currentDate.year &&
              expense.expenseDate.month == currentDate.month &&
              expense.expenseDate.day == currentDate.day)
          .fold(0.0, (sum, expense) => sum + expense.expenseAmount);

      expensesAmounts[i] = totalAmount;
    }

    return expensesAmounts;
  }

  double _getTotalAmountForTheWeek(List<ExpenseEntity> expenses) {
    return expenses.fold(
        0.0, (value, expense) => value + expense.expenseAmount);
  }
}
