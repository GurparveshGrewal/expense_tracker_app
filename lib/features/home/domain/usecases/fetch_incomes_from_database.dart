import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class FetchIncomesFromDatabaseUsecase
    extends Usecase<void, FetchIncomesFromDatabaseParams> {
  final HomeRepository _repository;
  FetchIncomesFromDatabaseUsecase(this._repository);

  @override
  Future<List<IncomeEntity>> call(FetchIncomesFromDatabaseParams params) async {
    final incomes =
        await _repository.fetchIncomesFromDatabase(uid: params.userId);
    return incomes;
  }
}

class FetchIncomesFromDatabaseParams {
  final String userId;

  FetchIncomesFromDatabaseParams({
    required this.userId,
  });
}
