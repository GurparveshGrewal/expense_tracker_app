import 'package:expense_tracker_app/core/utils/enums.dart';

class MyUser {
  final String uid;
  final String fullName;
  final String email;
  final Currency? currency;

  MyUser({
    required this.uid,
    required this.fullName,
    required this.email,
    this.currency,
  });

  static MyUser get empty {
    return MyUser(
      uid: '',
      fullName: '',
      email: '',
      currency: null,
    );
  }
}
