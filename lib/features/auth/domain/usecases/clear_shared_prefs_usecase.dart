import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';

class ClearSharedPrefsUsecase extends Usecase<void, void> {
  final AuthRepository _repository;

  ClearSharedPrefsUsecase(this._repository);

  @override
  Future<void> call(params) async {
    await _repository.clearSharedPrefs();
  }
}
