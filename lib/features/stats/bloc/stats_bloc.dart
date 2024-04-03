import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/fetch_filtered_expenses.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/get_saved_currency.dart';
import 'package:flutter/material.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final FetchFilteredExpensesUsecase _fetchFilteredExpensesUsecase;
  final GetSavedCurrencyUsecase _getSavedCurrencyUsecase;
  StatsBloc({
    required FetchFilteredExpensesUsecase filteredExpenseUsercase,
    required GetSavedCurrencyUsecase getSavedCurrencyUsecase,
  })  : _fetchFilteredExpensesUsecase = filteredExpenseUsercase,
        _getSavedCurrencyUsecase = getSavedCurrencyUsecase,
        super(StatsInitial()) {
    on<StatsEvent>((event, emit) => emit(StatsLoadingState()));
    on<StatsInitialFetch>(statsInitialFetch);
  }

  FutureOr<void> statsInitialFetch(
      StatsInitialFetch event, Emitter<StatsState> emit) async {
    try {
      final expenses =
          await _fetchFilteredExpensesUsecase(FetchFilteredExpensesParams(
        fromDate: event.fromDate,
        toDate: event.toDate,
      ));

      final currency = await _getSavedCurrencyUsecase({});

      emit(
        StatsInitializedState(
          currency: convertStringToEnum(Currency.values, currency),
          expenses: expenses,
          fromDate: event.fromDate,
          toDate: event.toDate,
          income: 8,
        ),
      );
    } catch (e) {
      emit(StatsErrorState());
    }
  }
}
