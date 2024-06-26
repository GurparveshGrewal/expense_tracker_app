import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class SaveSelectedCurrencyUsecase
    extends Usecase<void, SaveSelectedCurrencyParams> {
  final HomeRepository _repository;

  SaveSelectedCurrencyUsecase(this._repository);

  @override
  Future<void> call(SaveSelectedCurrencyParams params) async {
    await _repository.saveSelectedCurrency(
      params.selectedCurrency,
      params.uid,
    );
  }
}

class SaveSelectedCurrencyParams {
  final Currency selectedCurrency;
  final String uid;

  SaveSelectedCurrencyParams({
    required this.uid,
    required this.selectedCurrency,
  });
}
