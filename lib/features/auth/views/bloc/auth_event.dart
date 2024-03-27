part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthCheckIfUserLoggendIn extends AuthEvent {}

class AuthSignUpProcessEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;

  AuthSignUpProcessEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });
}

class AuthSignInProcessEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInProcessEvent({
    required this.email,
    required this.password,
  });
}
