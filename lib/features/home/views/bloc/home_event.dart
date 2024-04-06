part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeCheckSelectedCurrencyEvent extends HomeEvent {}

class HomeSaveSelectedCurrencyEvent extends HomeEvent {
  final String uid;
  final Currency selectedCurrency;

  HomeSaveSelectedCurrencyEvent({
    required this.uid,
    required this.selectedCurrency,
  });
}

class HomeAddExpenseToDatabaseProcessEvent extends HomeEvent {
  final ExpenseEntity expense;

  HomeAddExpenseToDatabaseProcessEvent({
    required this.expense,
  });
}

class HomeInitialFetchEvent extends HomeEvent {
  final String userId;
  final bool isHardRefresh;

  HomeInitialFetchEvent({
    required this.userId,
    this.isHardRefresh = false,
  });
}

class HomeAddIncomeToDatabaseEvent extends HomeEvent {
  final IncomeEntity income;

  HomeAddIncomeToDatabaseEvent({required this.income});
}

class HomeClearCacheAndPrefsEvent extends HomeEvent {}
