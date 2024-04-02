import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/home/domain/entity/expense_entity.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class FetchFilteredExpensesUsecase
    extends Usecase<void, FetchFilteredExpensesParams> {
  final HomeRepository _repository;
  FetchFilteredExpensesUsecase(this._repository);

  @override
  Future<List<ExpenseEntity>> call(FetchFilteredExpensesParams params) async {
    final expenses = _repository.fetchFilteredExpenses(
        fromDate: params.fromDate, toDate: params.toDate);
    return expenses;
  }
}

class FetchFilteredExpensesParams {
  final DateTime fromDate;
  final DateTime toDate;

  FetchFilteredExpensesParams({
    required this.fromDate,
    required this.toDate,
  });
}
