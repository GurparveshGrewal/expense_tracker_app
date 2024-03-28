part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeExpenseAddedSuccessState extends HomeState {}

class HomeFailedState extends HomeState {}
