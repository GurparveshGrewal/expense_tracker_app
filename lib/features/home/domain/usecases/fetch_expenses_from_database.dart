import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class FetchExpensesFromDatabaseUsecase
    extends Usecase<void, FetchExpensesFromDatabaseParams> {
  final HomeRepository _repository;
  FetchExpensesFromDatabaseUsecase(this._repository);

  @override
  Future<List<ExpenseEntity>> call(
      FetchExpensesFromDatabaseParams params) async {
    final expenses =
        await _repository.fetchExpensesFromDatabase(uid: params.userId);
    return expenses;
  }
}

class FetchExpensesFromDatabaseParams {
  final String userId;

  FetchExpensesFromDatabaseParams({
    required this.userId,
  });
}
