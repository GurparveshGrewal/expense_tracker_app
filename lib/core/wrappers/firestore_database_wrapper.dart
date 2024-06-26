import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app/core/commons/exceptions/failure_exceptions.dart';

class FirestoreDatabaseWrapper {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static const String _userCollectionName = "users";
  static const String _expensesCollectionName = "expenses";
  static const String _incomeCollectionName = "income";

  Future<void> addUserToDatabase({
    required String uid,
    required Map<String, String> data,
  }) async {
    try {
      final document =
          _firebaseFirestore.collection(_userCollectionName).doc(uid);
      await document.set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserData({required String uid}) async {
    try {
      final response = await _firebaseFirestore
          .collection(_userCollectionName)
          .doc(uid)
          .get();
      return response.data()!;
    } on FirebaseException catch (error) {
      throw FirestoreDatabaseFailure(error.code);
    } catch (e) {
      throw FirestoreDatabaseFailure('No user found for given credentials');
    }
  }

  Future<void> addExpenseToDatabase(
      {required Map<String, dynamic> data, required String id}) async {
    try {
      final document =
          _firebaseFirestore.collection(_expensesCollectionName).doc(id);
      await document.set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchExpenseFromDatabase(
      {required String userId}) async {
    try {
      final collection = await _firebaseFirestore
          .collection(_expensesCollectionName)
          .where("userId", isEqualTo: userId)
          .get();

      // Map each QueryDocumentSnapshot to a Map<String, dynamic>
      final List<Map<String, dynamic>> expenseList =
          collection.docs.map((doc) => doc.data()).toList();

      return expenseList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addIncomeToDatabase({
    required String incomeId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final document =
          _firebaseFirestore.collection(_incomeCollectionName).doc(incomeId);
      await document.set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchIncomeFromDatabase(
      {required String userId}) async {
    try {
      final collection = await _firebaseFirestore
          .collection(_incomeCollectionName)
          .where("userId", isEqualTo: userId)
          .get();

      // Map each QueryDocumentSnapshot to a Map<String, dynamic>
      final List<Map<String, dynamic>> incomeList =
          collection.docs.map((doc) => doc.data()).toList();

      return incomeList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveSelectedCurrency(String selectedCurrency, String uid) async {
    try {
      await _firebaseFirestore
          .collection(_userCollectionName)
          .doc(uid)
          .set({'currency': selectedCurrency}, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkIfUserExistsAlready({required String uid}) async {
    try {
      final documentReference = await _firebaseFirestore
          .collection(_userCollectionName)
          .doc(uid)
          .get();
      if (documentReference.exists) {
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteExpense(String expenseId) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection(_expensesCollectionName)
          .where('expenseId', isEqualTo: expenseId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;

        await documentReference.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
