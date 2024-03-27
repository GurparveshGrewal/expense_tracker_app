import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';

class SignInWithEmailAndPasswordUsecase
    extends Usecase<MyUser, SignInWithEmailAndPasswordUsecaseParams> {
  final AuthRepository _authRepository;

  SignInWithEmailAndPasswordUsecase(this._authRepository);

  @override
  Future<MyUser> call(SignInWithEmailAndPasswordUsecaseParams params) async {
    final myUser = await _authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    return myUser;
  }
}

class SignInWithEmailAndPasswordUsecaseParams {
  final String email;
  final String password;

  SignInWithEmailAndPasswordUsecaseParams({
    required this.email,
    required this.password,
  });
}
