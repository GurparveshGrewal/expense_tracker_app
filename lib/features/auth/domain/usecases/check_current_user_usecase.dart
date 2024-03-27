import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';

class CheckCurrentUserUsecase extends Usecase<MyUser, void> {
  final AuthRepository _authRepository;

  CheckCurrentUserUsecase(this._authRepository);

  @override
  Future<MyUser> call(params) async {
    final myUser = await _authRepository.getCurrentUser();

    return myUser;
  }
}
