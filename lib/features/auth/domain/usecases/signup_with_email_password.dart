import 'package:expense_tracker_app/core/usecase/usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';

class SignUpWithEmailAndPasswordUsecase
    extends Usecase<MyUser, SignupWithEmailAndPasswordUsecaseParams> {
  final AuthRepository _authRepository;

  SignUpWithEmailAndPasswordUsecase(this._authRepository);

  @override
  Future<MyUser> call(SignupWithEmailAndPasswordUsecaseParams params) async {
    final myUser = await _authRepository.signUpWithEmailAndPassword(
      fullName: params.name,
      email: params.email,
      password: params.password,
    );

    return myUser;
  }
}

class SignupWithEmailAndPasswordUsecaseParams {
  final String name;
  final String email;
  final String password;

  SignupWithEmailAndPasswordUsecaseParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
