import 'package:expense_tracker_app/core/wrappers/firestore_database_wrapper.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final FirestoreDatabaseWrapper _firestoreDatabaseWrapper;

  HomeRepositoryImpl(this._firestoreDatabaseWrapper);

  List<ExpenseEntity> _cachedExpenses = [];
  List<IncomeEntity> _cachedIncomes = [];

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
  Future<List<ExpenseEntity>> fetchExpensesFromDatabase(
      {required String uid}) async {
    try {
      if (_cachedExpenses.isEmpty) {
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
  Future<List<IncomeEntity>> fetchIncomesFromDatabase(
      {required String uid}) async {
    try {
      if (_cachedIncomes.isEmpty) {
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

  bool _isDateInRange(DateTime date, DateTime startDate, DateTime endDate) {
    return date.isAtSameMomentAs(startDate) ||
        date.isAtSameMomentAs(endDate) ||
        (date.isAfter(startDate) && date.isBefore(endDate));
  }
}
