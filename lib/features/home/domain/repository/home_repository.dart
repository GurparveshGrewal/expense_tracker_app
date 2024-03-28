import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';

abstract class HomeRepository {
  Future<void> addExpenseToDatabase({
    required ExpenseEntity expense,
  });

  Future<List<ExpenseEntity>> fetchExpensesFromDatabase({required String uid});
}
