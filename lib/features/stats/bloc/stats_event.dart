part of 'stats_bloc.dart';

@immutable
sealed class StatsEvent {}

class StatsInitialFetch extends StatsEvent {
  final DateTime fromDate;
  final DateTime toDate;
  final double income;

  StatsInitialFetch({
    required this.income,
    required this.fromDate,
    required this.toDate,
  });
}
