import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/add_expense_to_database.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AddExpenseToDatabaseUsecase _addExpenseToDatabaseUsecase;
  HomeBloc({
    required AddExpenseToDatabaseUsecase addExpenseToDatabaseUsecase,
  })  : _addExpenseToDatabaseUsecase = addExpenseToDatabaseUsecase,
        super(HomeInitial()) {
    on<HomeEvent>((event, emit) => emit(HomeLoadingState()));
    on<HomeAddExpenseToDatabaseProcessEvent>(addExpenseToDatabase);
  }

  FutureOr<void> addExpenseToDatabase(
      HomeAddExpenseToDatabaseProcessEvent event,
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
