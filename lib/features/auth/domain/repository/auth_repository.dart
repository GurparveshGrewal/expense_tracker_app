import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';

abstract class AuthRepository {
  Future<MyUser> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String fullName});

  Future<MyUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<MyUser> getCurrentUser();
}
