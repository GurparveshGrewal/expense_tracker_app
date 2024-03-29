part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeInitializedState extends HomeState {
  final List<ExpenseEntity> expenses;
  final List<IncomeEntity> incomes;
  final bool showAddIncomeDialog;

  HomeInitializedState({
    required this.expenses,
    required this.incomes,
    required this.showAddIncomeDialog,
  });

  HomeInitializedState copyWith(
    HomeInitializedState prevState, {
    List<ExpenseEntity>? expenses,
    List<IncomeEntity>? incomes,
    bool? showIncomeDialog,
  }) {
    return HomeInitializedState(
      expenses: expenses ?? prevState.expenses,
      incomes: incomes ?? prevState.incomes,
      showAddIncomeDialog: showIncomeDialog ?? prevState.showAddIncomeDialog,
    );
  }
}

class HomeExpenseAddedSuccessState extends HomeState {}

class HomeIncomeAddedSuccessState extends HomeState {
  final IncomeEntity income;

  HomeIncomeAddedSuccessState({required this.income});
}

class HomeFailedState extends HomeState {}
