part of 'stats_bloc.dart';

@immutable
sealed class StatsState {}

final class StatsInitial extends StatsState {}

final class StatsInitializedState extends StatsState {
  final List<ExpenseEntity> expenses;
  final DateTime fromDate;
  final DateTime toDate;
  final double income;
  final Currency currency;

  StatsInitializedState({
    required this.expenses,
    required this.fromDate,
    required this.toDate,
    required this.income,
    required this.currency,
  });
}

final class StatsLoadingState extends StatsState {}

final class StatsErrorState extends StatsState {}
