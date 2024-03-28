import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class AddExpenseToDatabaseUsecase
    extends Usecase<void, AddExpenseToDatabaseParams> {
  final HomeRepository _repository;
  AddExpenseToDatabaseUsecase(this._repository);

  @override
  Future<void> call(AddExpenseToDatabaseParams params) async {
    await _repository.addExpenseToDatabase(expense: params.expense);
  }
}

class AddExpenseToDatabaseParams {
  final ExpenseEntity expense;

  AddExpenseToDatabaseParams({
    required this.expense,
  });
}
