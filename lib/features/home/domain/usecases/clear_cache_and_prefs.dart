import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';

class ClearCacheAndPrefsUsecase extends Usecase<void, void> {
  final HomeRepository _repository;

  ClearCacheAndPrefsUsecase(this._repository);
  @override
  Future<void> call(params) async {
    await _repository.clearCacheAndPrefs();
  }
}
