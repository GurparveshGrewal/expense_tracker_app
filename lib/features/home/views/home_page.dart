import 'package:expense_tracker_app/core/commons/widgets/loader.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/home/views/add_new_expense_page.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:expense_tracker_app/features/home/views/main_screen.dart';
import 'package:expense_tracker_app/features/home/widgets/select_currency_dialog.dart';
import 'package:expense_tracker_app/features/stats/views/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final MyUser myUser;
  const HomePage({required this.myUser, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activePage = 0;
  bool _showSelectCurrencyDialog = false;

  void changePage(int pageNumber) {
    setState(() {
      activePage = pageNumber;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeCheckSelectedCurrencyEvent());
  }

  @override
  Widget build(BuildContext context) {
    if (_showSelectCurrencyDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) => const SelectCurrencyDialog());
      });
    }

    return Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
              onTap: (pageNumber) {
                changePage(pageNumber);
              },
              currentIndex: activePage,
              elevation: 5,
              backgroundColor: Colors.white,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    label: '', icon: Icon(CupertinoIcons.home)),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(CupertinoIcons.graph_square_fill),
                ),
              ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const AddNewExpensePage()));
            },
            child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.tertiary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary,
                      ],
                      transform: const GradientRotation(3.14 / 4),
                    )),
                child: const Icon(CupertinoIcons.add))),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeSuccessfullyFetchedCurrencyState) {
              setState(() {
                _showSelectCurrencyDialog = false;
              });
              context
                  .read<HomeBloc>()
                  .add(HomeInitialFetchEvent(userId: widget.myUser.uid));
            } else if (state is HomeFirstSignInState) {
              setState(() {
                _showSelectCurrencyDialog = true;
              });
            } else if (state is HomeExpenseAddedSuccessState) {
              context.read<HomeBloc>().add(HomeInitialFetchEvent(
                    userId: widget.myUser.uid,
                    isHardRefresh: state.isHardRefreshRequired,
                  ));
            } else if (state is HomeIncomeAddedSuccessState) {
              context.read<HomeBloc>().add(HomeInitialFetchEvent(
                    userId: widget.myUser.uid,
                    isHardRefresh: state.isHardRefreshRequired,
                  ));
            }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) return const Loader();

            if (state is HomeInitializedState) {
              if (activePage == 0) {
                return MainScreen(
                  initializedState: state,
                  currentUser: widget.myUser,
                );
              } else {
                return StatsPage(
                  fromDate: DateTime.now().subtract(const Duration(days: 6)),
                  toDate: DateTime.now(),
                );
              }
            }

            return const Center(child: Text("Something went wrong"));
          },
        ));
  }
}
