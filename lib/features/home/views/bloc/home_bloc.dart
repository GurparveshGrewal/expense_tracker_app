import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/add_expense_to_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/fetch_expenses_from_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/fetch_incomes_from_database.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AddExpenseToDatabaseUsecase _addExpenseToDatabaseUsecase;
  final FetchExpensesFromDatabaseUsecase _fetchExpensesFromDatabaseUsecase;
  final FetchIncomesFromDatabaseUsecase _fetchIncomesFromDatabaseUsecase;
  HomeBloc({
    required AddExpenseToDatabaseUsecase addExpenseToDatabaseUsecase,
    required FetchExpensesFromDatabaseUsecase fetchExpensesFromDatabaseUsecase,
    required FetchIncomesFromDatabaseUsecase fetchIncomes,
  })  : _addExpenseToDatabaseUsecase = addExpenseToDatabaseUsecase,
        _fetchExpensesFromDatabaseUsecase = fetchExpensesFromDatabaseUsecase,
        _fetchIncomesFromDatabaseUsecase = fetchIncomes,
        super(HomeInitial()) {
    on<HomeEvent>((event, emit) => emit(HomeLoadingState()));
    on<HomeAddExpenseToDatabaseProcessEvent>(addExpenseToDatabase);
    on<HomeInitialFetchEvent>(initialHomeDataFetch);
  }

  Future<void> initialHomeDataFetch(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    try {
      final expenses = await _fetchExpensesFromDatabaseUsecase(
        FetchExpensesFromDatabaseParams(userId: event.userId),
      );

      final incomes = await _fetchIncomesFromDatabaseUsecase(
          FetchIncomesFromDatabaseParams(userId: event.userId));

      emit(HomeInitializedState(
        showAddIncomeDialog: incomes.isEmpty,
        expenses: expenses,
        incomes: incomes,
      ));
    } catch (e) {
      emit(HomeFailedState());
    }
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
}
