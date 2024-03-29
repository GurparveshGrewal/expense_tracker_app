part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeAddExpenseToDatabaseProcessEvent extends HomeEvent {
  final ExpenseEntity expense;

  HomeAddExpenseToDatabaseProcessEvent({
    required this.expense,
  });
}

class HomeInitialFetchEvent extends HomeEvent {
  final String userId;

  HomeInitialFetchEvent({
    required this.userId,
  });
}

class HomeAddIncomeToDatabaseEvent extends HomeEvent {
  final IncomeEntity income;

  HomeAddIncomeToDatabaseEvent({required this.income});
}
