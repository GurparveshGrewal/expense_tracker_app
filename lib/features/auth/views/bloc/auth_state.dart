part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

class AuthUserLogInSuccessState extends AuthState {
  final MyUser currentUser;

  AuthUserLogInSuccessState({
    required this.currentUser,
  });
}

class AuthUserLogInFailedState extends AuthState {
  final String errorMessage;

  AuthUserLogInFailedState(this.errorMessage);
}

class AuthLoadingState extends AuthState {}
