import 'package:expense_tracker_app/core/commons/cubit/app_user_cubit.dart';
import 'package:expense_tracker_app/core/wrappers/firebase_auth_wrapper.dart';
import 'package:expense_tracker_app/core/wrappers/firestore_database_wrapper.dart';
import 'package:expense_tracker_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/check_current_user_usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/sign_out.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signin_with_email_password%20.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signin_with_google.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signup_with_email_password.dart';
import 'package:expense_tracker_app/features/auth/views/bloc/auth_bloc.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initHome();

  // registering firebase wrapper
  serviceLocator.registerLazySingleton(() => FirebaseAuthWrapper());
  serviceLocator.registerLazySingleton(() => FirestoreDatabaseWrapper());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ));

  // Usecases
  serviceLocator.registerFactory(
      () => SignUpWithEmailAndPasswordUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => SignInWithEmailAndPasswordUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => SignInWithGoogleUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => SignOutUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => CheckCurrentUserUsecase(serviceLocator()));

  // Blocs
  serviceLocator.registerLazySingleton(() => AuthBloc(
      signInWithEmailAndPasswordUsecase: serviceLocator(),
      signUpWithEmailAndPasswordUsecase: serviceLocator(),
      signOutUsecase: serviceLocator(),
      signInWithGoogleUsecase: serviceLocator(),
      checkCurrentUserUsecase: serviceLocator(),
      authCubit: serviceLocator()));
}

void _initHome() {
  // Blocs
  serviceLocator.registerLazySingleton(() => HomeBloc());
}
