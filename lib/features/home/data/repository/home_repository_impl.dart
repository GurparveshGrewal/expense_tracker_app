import 'package:expense_tracker_app/core/wrappers/firestore_database_wrapper.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final FirestoreDatabaseWrapper _firestoreDatabaseWrapper;

  HomeRepositoryImpl(this._firestoreDatabaseWrapper);

  @override
  Future<void> addExpenseToDatabase({required ExpenseEntity expense}) async {
    try {
      await _firestoreDatabaseWrapper.addExpenseToDatabase(
          data: expense.toJSON(), id: expense.userId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ExpenseEntity>> fetchExpenses({required String uid}) async {
    try {
      final List<ExpenseEntity> expenses = [];
      final rawExpenses =
          await _firestoreDatabaseWrapper.fetchExpenseFromDatabase(userId: uid);

      for (var rawData in rawExpenses) {
        expenses.add(ExpenseEntity.toEntity(rawData));
      }

      return expenses;
    } catch (e) {
      rethrow;
    }
  }
}
