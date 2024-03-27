import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';

class SignOutUsecase extends Usecase<void, void> {
  final AuthRepository _authRepository;

  SignOutUsecase(this._authRepository);

  @override
  Future<void> call(params) async {
    await _authRepository.signOut();
  }
}
