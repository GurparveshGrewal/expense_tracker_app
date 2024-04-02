import 'package:expense_tracker_app/core/commons/widgets/loader.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/widgets/expense_card.dart';
import 'package:expense_tracker_app/features/stats/bloc/stats_bloc.dart';
import 'package:expense_tracker_app/features/stats/widgets/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
        title: const Text(
          "Analyze your Expenses (Weekly)",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 1.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const MyChart(
                      expenses: [],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Week - ?"),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat.yMMMd().format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "-\$500.00",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return ExpenseCard(
                            expense: ExpenseEntity.empty(),
                            icon: Icons.food_bank_outlined,
                            backgroundColor: index % 2 == 0
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                          );
                        }),
                  )
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

  // List<double> weekExpenses(
  //     DateTime fromDate, DateTime toDate, List<ExpenseEntity> expenses) {
  //   List<double> expensesAmounts = List.filled(7, 0.0);
  //   for (ExpenseEntity expense in expenses) {
  //     if (expense.expenseDate.isAfter(fromDate) &&
  //         expense.expenseDate.isBefore(toDate)) {}
  //   }
}
