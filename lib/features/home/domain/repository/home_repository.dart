abstract class HomeRepository {
  Future<void> addExpenseToDatabase({
    required String uid,
  });
}
