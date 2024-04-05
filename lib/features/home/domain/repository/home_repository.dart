import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';

abstract class HomeRepository {
  Future<String?> checkSelectedCurrency();

  Future<void> saveSelectedCurrency(
    Currency selectedCurrency,
    String uid,
  );

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

  Future<void> clearCacheAndPrefs();
}
