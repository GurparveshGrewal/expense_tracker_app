import 'package:expense_tracker_app/core/commons/widgets/loader.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/show_snackbar.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/auth/views/bloc/auth_bloc.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:expense_tracker_app/features/home/widgets/expense_card.dart';
import 'package:expense_tracker_app/features/home/widgets/stat_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  final MyUser currentUser;
  const MainScreen({required this.currentUser, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeFetchExpensesFromDatabaseProcessEvent(
        userId: widget.currentUser.uid));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeFailedState) {
              showSnackBar(context, "something went wrong.");
            } else if (state is HomeExpenseAddedSuccessState) {
              context.read<HomeBloc>().add(
                  HomeFetchExpensesFromDatabaseProcessEvent(
                      userId: widget.currentUser.uid));
            }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) return const Loader();

            if (state is HomeExpensesFetchSuccess) {
              return Column(
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
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withOpacity(0.5),
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
                            context.read<AuthBloc>().add(AuthSignOutEvent());
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
                    income: 5000,
                    expensesAmount: _getTotalExpenses(state.expenses),
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
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.grey),
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
                        itemCount: state.expenses.length,
                        itemBuilder: (context, index) {
                          return ExpenseCard(
                            expense: state.expenses[index],
                            icon:
                                _getIcon(state.expenses[index].expenseCategory),
                            backgroundColor: index % 2 == 0
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                          );
                        }),
                  )
                ],
              );
            }

            return const Center(
              child: Text("Something went wrong :("),
            );
          },
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
}
