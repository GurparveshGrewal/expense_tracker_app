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

class AuthUserLogInFailedState extends AuthState {}

class AuthLoadingState extends AuthState {}
