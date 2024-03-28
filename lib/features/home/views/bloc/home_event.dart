part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeAddExpenseToDatabaseProcessEvent extends HomeEvent {
  final ExpenseEntity expense;

  HomeAddExpenseToDatabaseProcessEvent({
    required this.expense,
  });
}

class HomeFetchExpensesFromDatabaseProcessEvent extends HomeEvent {
  final String userId;

  HomeFetchExpensesFromDatabaseProcessEvent({
    required this.userId,
  });
}
