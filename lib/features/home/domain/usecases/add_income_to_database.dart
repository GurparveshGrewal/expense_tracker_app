import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/home/domain/entity/income_entity.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class AddIncomeToDatabaseUsecase
    extends Usecase<void, AddIncomeToDatabaseParams> {
  final HomeRepository _repository;
  AddIncomeToDatabaseUsecase(this._repository);

  @override
  Future<void> call(AddIncomeToDatabaseParams params) async {
    await _repository.addIncomeToDatabase(
      income: params.income,
    );
  }
}

class AddIncomeToDatabaseParams {
  final IncomeEntity income;

  AddIncomeToDatabaseParams({
    required this.income,
  });
}
