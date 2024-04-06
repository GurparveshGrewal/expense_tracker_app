import 'package:expense_tracker_app/core/repository/shared_preferences_reposity.dart';
import 'package:expense_tracker_app/core/utils/enums.dart';
import 'package:expense_tracker_app/core/utils/functions.dart';
import 'package:expense_tracker_app/core/wrappers/firebase_auth_wrapper.dart';
import 'package:expense_tracker_app/core/wrappers/firestore_database_wrapper.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthWrapper _firebaseAuthWrapper;
  final FirestoreDatabaseWrapper _firestoreDatabaseWrapper;
  final SharedPreferencesRepository _sharedPreferencesRepository;
  AuthRepositoryImpl(
    this._firebaseAuthWrapper,
    this._firestoreDatabaseWrapper,
    this._sharedPreferencesRepository,
  );

  @override
  Future<MyUser> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String fullName}) async {
    try {
      final user = await _firebaseAuthWrapper.signUpWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        await _firestoreDatabaseWrapper.addUserToDatabase(uid: user.uid, data: {
          "fullName": fullName,
          "email": email,
          "createdAt": DateTime.now().toIso8601String(),
        });
        return MyUser(uid: user.uid, fullName: fullName, email: email);
      }

      return MyUser.empty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MyUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _firebaseAuthWrapper.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        final rawData =
            await _firestoreDatabaseWrapper.getUserData(uid: user.uid);

        if (rawData['currency'] != null) {
          await _saveCurrencyInPrefs(rawData['currency']);
        }

        return MyUser(
            uid: user.uid, fullName: rawData['fullName'], email: email);
      }

      return MyUser.empty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MyUser> getCurrentUser() async {
    try {
      final currentUser = _firebaseAuthWrapper.currentUser;

      if (currentUser != null) {
        final userData =
            await _firestoreDatabaseWrapper.getUserData(uid: currentUser.uid);

        if (userData['currency'] != null) {
          await _saveCurrencyInPrefs(userData['currency']);
        }

        var firstName = 'noName';

        if (userData['fullName'] != null) {
          final String fullName = userData['fullName'];
          firstName = fullName;
        }

        return MyUser(
          uid: currentUser.uid,
          fullName: firstName,
          email: currentUser.email!,
          currency: convertStringToEnum(Currency.values, userData['currency']),
        );
      }

      return MyUser.empty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    try {
      final user = await _firebaseAuthWrapper.signInWithGoogle();
      if (user != null) {
        await _firestoreDatabaseWrapper.addUserToDatabase(uid: user.uid, data: {
          "fullName": user.displayName ?? "empty",
          "email": user.email!,
          "createdAt": DateTime.now().toIso8601String(),
        });
        return MyUser(
            uid: user.uid,
            fullName: user.displayName ?? "User",
            email: user.email!);
      }
      return MyUser.empty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuthWrapper.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveCurrencyInPrefs(String currency) async {
    await _sharedPreferencesRepository.saveCurrency(currency);
  }
}
