class MyUser {
  final String uid;
  final String fullName;
  final String email;

  MyUser({
    required this.uid,
    required this.fullName,
    required this.email,
  });

  static MyUser get empty {
    return MyUser(
      uid: '',
      fullName: '',
      email: '',
    );
  }
}
