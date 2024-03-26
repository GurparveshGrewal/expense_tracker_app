import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthWrapper {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthWrapper(this._firebaseAuth);

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return user.user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
