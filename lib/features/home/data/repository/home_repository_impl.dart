import 'package:expense_tracker_app/core/repository/shared_preferences_reposity.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/core/wrappers/firestore_database_wrapper.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final FirestoreDatabaseWrapper _firestoreDatabaseWrapper;
  final SharedPreferencesRepository _sharedPreferencesRepository;

  HomeRepositoryImpl(
    this._firestoreDatabaseWrapper,
    this._sharedPreferencesRepository,
  );

  List<ExpenseEntity> _cachedExpenses = [];
  List<IncomeEntity> _cachedIncomes = [];

  @override
  Future<String?> checkSelectedCurrency() async {
    return await _sharedPreferencesRepository.getCurrency();
  }

  @override
  Future<void> saveSelectedCurrency(
      Currency selectedCurrency, String uid) async {
    try {
      await _firestoreDatabaseWrapper.saveSelectedCurrency(
          enumValueToString(selectedCurrency), uid);
      await _sharedPreferencesRepository
          .saveCurrency(enumValueToString(selectedCurrency));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addExpenseToDatabase({
    required ExpenseEntity expense,
  }) async {
    try {
      await _firestoreDatabaseWrapper.addExpenseToDatabase(
          data: expense.toJSON(), id: expense.expenseId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ExpenseEntity>> fetchExpensesFromDatabase({
    required String uid,
    required bool isHardRefresh,
  }) async {
    try {
      if (_cachedExpenses.isEmpty || isHardRefresh) {
        final List<ExpenseEntity> expenses = [];
        final rawExpenses = await _firestoreDatabaseWrapper
            .fetchExpenseFromDatabase(userId: uid);

        if (rawExpenses.isNotEmpty) {
          for (var rawData in rawExpenses) {
            expenses.add(ExpenseEntity.toEntity(rawData));
          }

          _cachedExpenses = expenses;
        }
      }

      return _cachedExpenses;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addIncomeToDatabase({required IncomeEntity income}) async {
    try {
      await _firestoreDatabaseWrapper.addIncomeToDatabase(
          data: income.toJSON(), incomeId: income.incomeId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<IncomeEntity>> fetchIncomesFromDatabase({
    required String uid,
    required bool isHardRefresh,
  }) async {
    try {
      if (_cachedIncomes.isEmpty || isHardRefresh) {
        final List<IncomeEntity> userIncomes = [];
        final incomes = await _firestoreDatabaseWrapper.fetchIncomeFromDatabase(
            userId: uid);

        if (incomes.isNotEmpty) {
          for (var income in incomes) {
            userIncomes.add(
              IncomeEntity(
                userId: income['userId'],
                incomeId: income['incomeId'],
                amount: double.parse(income['amount']),
                date: DateTime.parse(income['date']),
              ),
            );
          }
        }

        _cachedIncomes = userIncomes;
      }
      return _cachedIncomes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<ExpenseEntity> fetchFilteredExpenses(
      {required DateTime fromDate, required DateTime toDate}) {
    if (_cachedExpenses.isEmpty) {
      return [];
    }

    List<ExpenseEntity> expenses = [];
    for (var expense in _cachedExpenses) {
      if (_isDateInRange(expense.expenseDate, fromDate, toDate)) {
        expenses.add(expense);
      }
    }

    expenses.sort((a, b) => a.expenseDate.compareTo(b.expenseDate));
    return expenses;
  }

  @override
  Future<void> clearCacheAndPrefs() async {
    _cachedExpenses = [];
    _cachedIncomes = [];
    await _sharedPreferencesRepository.clearSharedPrefs();
  }

  @override
  Future<void> deleteExpense({required String expenseId}) async {
    try {
      await _firestoreDatabaseWrapper.deleteExpense(expenseId);
      _cachedExpenses.removeWhere((expense) => expense.expenseId == expenseId);
    } catch (e) {
      rethrow;
    }
  }

  bool _isDateInRange(DateTime date, DateTime startDate, DateTime endDate) {
    return date.isAtSameMomentAs(startDate) ||
        date.isAtSameMomentAs(endDate) ||
        (date.isAfter(startDate.subtract(const Duration(days: 1))) &&
            date.isBefore(endDate));
  }
}
