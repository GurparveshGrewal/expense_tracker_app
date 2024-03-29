import 'package:expense_tracker_app/core/wrappers/firestore_database_wrapper.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final FirestoreDatabaseWrapper _firestoreDatabaseWrapper;

  HomeRepositoryImpl(this._firestoreDatabaseWrapper);

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
      final List<ExpenseEntity> expenses = [];
      final rawExpenses =
          await _firestoreDatabaseWrapper.fetchExpenseFromDatabase(userId: uid);

      if (rawExpenses.isNotEmpty) {
        for (var rawData in rawExpenses) {
          expenses.add(ExpenseEntity.toEntity(rawData));
        }
      }

      return expenses;
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
      final List<IncomeEntity> userIncomes = [];
      final incomes =
          await _firestoreDatabaseWrapper.fetchIncomeFromDatabase(userId: uid);

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

      return userIncomes;
    } catch (e) {
      rethrow;
    }
  }
}
