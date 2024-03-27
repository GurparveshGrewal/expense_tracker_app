import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseWrapper {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static const String _userCollectionName = "users";

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
    } catch (e) {
      rethrow;
    }
  }
}
