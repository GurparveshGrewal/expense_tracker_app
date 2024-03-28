part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeExpensesFetchSuccess extends HomeState {
  final List<ExpenseEntity> expenses;

  HomeExpensesFetchSuccess({
    required this.expenses,
  });
}

class HomeExpenseAddedSuccessState extends HomeState {}

class HomeFailedState extends HomeState {}
