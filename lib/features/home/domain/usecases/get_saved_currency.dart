import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class GetSavedCurrencyUsecase extends Usecase<String?, void> {
  final HomeRepository _repository;

  GetSavedCurrencyUsecase(this._repository);

  @override
  Future<String?> call(void params) async {
    return await _repository.checkSelectedCurrency();
  }
}
