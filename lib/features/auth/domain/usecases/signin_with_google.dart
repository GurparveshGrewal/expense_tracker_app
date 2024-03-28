import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';

class SignInWithGoogleUsecase extends Usecase<MyUser, void> {
  final AuthRepository _authRepository;

  SignInWithGoogleUsecase(this._authRepository);

  @override
  Future<MyUser> call(params) async {
    final myUser = await _authRepository.signInWithGoogle();

    return myUser;
  }
}
