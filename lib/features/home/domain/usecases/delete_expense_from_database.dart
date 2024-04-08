import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class DeleteExpenseFromDatabase
    extends Usecase<void, DeleteExpenseFromDatabaseParams> {
  final HomeRepository _repository;

  DeleteExpenseFromDatabase(this._repository);
  @override
  Future<void> call(DeleteExpenseFromDatabaseParams params) async {
    await _repository.deleteExpense(expenseId: params.expenseId);
  }
}

class DeleteExpenseFromDatabaseParams {
  final String expenseId;

  DeleteExpenseFromDatabaseParams(this.expenseId);
}
