import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/add_expense_to_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/fetch_expenses_from_database.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AddExpenseToDatabaseUsecase _addExpenseToDatabaseUsecase;
  final FetchExpensesFromDatabaseUsecase _fetchExpensesFromDatabaseUsecase;
  HomeBloc({
    required AddExpenseToDatabaseUsecase addExpenseToDatabaseUsecase,
    required FetchExpensesFromDatabaseUsecase fetchExpensesFromDatabaseUsecase,
  })  : _addExpenseToDatabaseUsecase = addExpenseToDatabaseUsecase,
        _fetchExpensesFromDatabaseUsecase = fetchExpensesFromDatabaseUsecase,
        super(HomeInitial()) {
    on<HomeEvent>((event, emit) => emit(HomeLoadingState()));
    on<HomeAddExpenseToDatabaseProcessEvent>(addExpenseToDatabase);
    on<HomeFetchExpensesFromDatabaseProcessEvent>(fetchExpensesFromDatabase);
  }

  Future<void> addExpenseToDatabase(HomeAddExpenseToDatabaseProcessEvent event,
      Emitter<HomeState> emit) async {
    try {
      await _addExpenseToDatabaseUsecase(
          AddExpenseToDatabaseParams(expense: event.expense));

      emit(HomeExpenseAddedSuccessState());
    } catch (e) {
      emit(HomeFailedState());
    }
  }

  Future<void> fetchExpensesFromDatabase(
      HomeFetchExpensesFromDatabaseProcessEvent event,
      Emitter<HomeState> emit) async {
    try {
      final expenses = await _fetchExpensesFromDatabaseUsecase(
        FetchExpensesFromDatabaseParams(userId: event.userId),
      );

      emit(HomeExpensesFetchSuccess(expenses: expenses));
    } catch (e) {
      emit(HomeFailedState());
    }
  }
}
