import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';

abstract class HomeRepository {
  Future<void> addExpenseToDatabase({
    required ExpenseEntity expense,
  });

  Future<List<ExpenseEntity>> fetchExpensesFromDatabase({
    required String uid,
    required bool isHardRefresh,
  });

  Future<void> addIncomeToDatabase({
    required IncomeEntity income,
  });

  Future<List<IncomeEntity>> fetchIncomesFromDatabase({
    required String uid,
    required bool isHardRefresh,
  });

  List<ExpenseEntity> fetchFilteredExpenses({
    required DateTime fromDate,
    required DateTime toDate,
  });
}
