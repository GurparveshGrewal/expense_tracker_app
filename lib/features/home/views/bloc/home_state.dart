part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeSuccessfullyFetchedCurrencyState extends HomeState {
  final Currency selectedCurrency;

  HomeSuccessfullyFetchedCurrencyState({
    required this.selectedCurrency,
  });
}

class HomeFirstSignInState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeInitializedState extends HomeState {
  final List<ExpenseEntity> expenses;
  final List<IncomeEntity> incomes;
  final bool showAddIncomeDialog;
  final Currency currency;

  HomeInitializedState({
    required this.currency,
    required this.expenses,
    required this.incomes,
    required this.showAddIncomeDialog,
  });

  static HomeInitializedState copyWith(
    HomeInitializedState prevState, {
    List<ExpenseEntity>? expenses,
    List<IncomeEntity>? incomes,
    bool? showIncomeDialog,
  }) {
    return HomeInitializedState(
      currency: prevState.currency,
      expenses: expenses ?? prevState.expenses,
      incomes: incomes ?? prevState.incomes,
      showAddIncomeDialog: showIncomeDialog ?? prevState.showAddIncomeDialog,
    );
  }
}

class HomeExpenseAddedSuccessState extends HomeState {
  final bool isHardRefreshRequired;

  HomeExpenseAddedSuccessState({
    required this.isHardRefreshRequired,
  });
}

class HomeIncomeAddedSuccessState extends HomeState {
  final IncomeEntity income;
  final bool isHardRefreshRequired;

  HomeIncomeAddedSuccessState({
    required this.income,
    required this.isHardRefreshRequired,
  });
}

class HomeRemoveExpenseSuccessState extends HomeState {}

class HomeDbCRUDFailedState extends HomeState {}

class HomeFailedState extends HomeState {}
