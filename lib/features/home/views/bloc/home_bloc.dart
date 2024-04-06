import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/core/repository/shared_preferences_reposity.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/add_expense_to_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/add_income_to_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/clear_cache_and_prefs.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/fetch_expenses_from_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/fetch_incomes_from_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/get_saved_currency.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/save_selected_currency.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetSavedCurrencyUsecase _getSavedCurrencyUsecase;
  final SaveSelectedCurrencyUsecase _saveSelectedCurrencyUsecase;
  final AddExpenseToDatabaseUsecase _addExpenseToDatabaseUsecase;
  final FetchExpensesFromDatabaseUsecase _fetchExpensesFromDatabaseUsecase;
  final FetchIncomesFromDatabaseUsecase _fetchIncomesFromDatabaseUsecase;
  final AddIncomeToDatabaseUsecase _addIncomeToDatabaseUsecase;
  final SharedPreferencesRepository _sharedPreferencesRepository;
  final ClearCacheAndPrefsUsecase _cacheAndPrefsUsecase;
  HomeBloc({
    required SharedPreferencesRepository sharedPreferencesRepository,
    required GetSavedCurrencyUsecase getSavedCurrencyUsecase,
    required SaveSelectedCurrencyUsecase saveSelectedCurrencyUsecase,
    required AddExpenseToDatabaseUsecase addExpenseToDatabaseUsecase,
    required FetchExpensesFromDatabaseUsecase fetchExpensesFromDatabaseUsecase,
    required FetchIncomesFromDatabaseUsecase fetchIncomes,
    required AddIncomeToDatabaseUsecase addIncomeToDatabaseUsecase,
    required ClearCacheAndPrefsUsecase clearCacheAndPrefsUsecase,
  })  : _sharedPreferencesRepository = sharedPreferencesRepository,
        _getSavedCurrencyUsecase = getSavedCurrencyUsecase,
        _saveSelectedCurrencyUsecase = saveSelectedCurrencyUsecase,
        _addExpenseToDatabaseUsecase = addExpenseToDatabaseUsecase,
        _fetchExpensesFromDatabaseUsecase = fetchExpensesFromDatabaseUsecase,
        _fetchIncomesFromDatabaseUsecase = fetchIncomes,
        _addIncomeToDatabaseUsecase = addIncomeToDatabaseUsecase,
        _cacheAndPrefsUsecase = clearCacheAndPrefsUsecase,
        super(HomeInitial()) {
    on<HomeEvent>((event, emit) => emit(HomeLoadingState()));
    on<HomeAddExpenseToDatabaseProcessEvent>(addExpenseToDatabase);
    on<HomeInitialFetchEvent>(initialHomeDataFetch);
    on<HomeAddIncomeToDatabaseEvent>(addIncomeToDatabase);
    on<HomeCheckSelectedCurrencyEvent>(checkSavedCurrency);
    on<HomeSaveSelectedCurrencyEvent>(saveSelectedCurrency);
    on<HomeClearCacheAndPrefsEvent>(clearCacheAndPrefs);
  }

  Future<void> checkSavedCurrency(
      HomeCheckSelectedCurrencyEvent event, Emitter<HomeState> emit) async {
    final currency = await _getSavedCurrencyUsecase({});

    if (currency != null) {
      emit(HomeSuccessfullyFetchedCurrencyState(
          selectedCurrency: convertStringToEnum(Currency.values, currency)));
    } else {
      emit(HomeFirstSignInState());
    }
  }

  Future<void> saveSelectedCurrency(
      HomeSaveSelectedCurrencyEvent event, Emitter<HomeState> emit) async {
    await _saveSelectedCurrencyUsecase(SaveSelectedCurrencyParams(
      selectedCurrency: event.selectedCurrency,
      uid: event.uid,
    ));

    emit(HomeSuccessfullyFetchedCurrencyState(
        selectedCurrency: event.selectedCurrency));
  }

  Future<void> initialHomeDataFetch(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    try {
      final expenses = await _fetchExpensesFromDatabaseUsecase(
        FetchExpensesFromDatabaseParams(
          userId: event.userId,
          isHardRefresh: event.isHardRefresh,
        ),
      );

      final incomes =
          await _fetchIncomesFromDatabaseUsecase(FetchIncomesFromDatabaseParams(
        userId: event.userId,
        isHardRefresh: event.isHardRefresh,
      ));

      final currency = await _sharedPreferencesRepository.getCurrency();

      emit(HomeInitializedState(
        currency: convertStringToEnum(Currency.values, currency),
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

      emit(HomeExpenseAddedSuccessState(
        isHardRefreshRequired: true,
      ));
    } catch (e) {
      emit(HomeFailedState());
    }
  }

  Future<void> addIncomeToDatabase(
      HomeAddIncomeToDatabaseEvent event, Emitter<HomeState> emit) async {
    try {
      await _addIncomeToDatabaseUsecase(
          AddIncomeToDatabaseParams(income: event.income));

      emit(HomeIncomeAddedSuccessState(
        income: event.income,
        isHardRefreshRequired: true,
      ));
    } catch (e) {
      emit(HomeFailedState());
    }
  }

  Future<void> clearCacheAndPrefs(
      HomeClearCacheAndPrefsEvent event, Emitter<HomeState> emit) async {
    try {
      await _cacheAndPrefsUsecase({});
    } catch (e) {
      rethrow;
    }
  }
}
