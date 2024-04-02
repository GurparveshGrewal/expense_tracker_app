part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final MyUser currentUser;
  AppUserLoggedIn(this.currentUser);
}

final class AppUserNoLoggedInUser extends AppUserState {}

final class AppUserLoggedOut extends AppUserState {
  AppUserLoggedOut();
}
