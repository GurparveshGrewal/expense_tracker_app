import 'package:expense_tracker_app/core/commons/cubit/app_user_cubit.dart';
import 'package:expense_tracker_app/core/wrappers/firebase_auth_wrapper.dart';
import 'package:expense_tracker_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/check_current_user_usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signup_with_email_password.dart';
import 'package:expense_tracker_app/features/auth/views/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  // registering firebase wrapper
  serviceLocator.registerLazySingleton(() => FirebaseAuthWrapper());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(),
      ));

  // Usecases
  serviceLocator.registerFactory(
      () => SignUpWithEmailAndPasswordUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => CheckCurrentUserUsecase(serviceLocator()));

  // Blocs
  serviceLocator.registerLazySingleton(() => AuthBloc(
      signUpWithEmailAndPasswordUsecase: serviceLocator(),
      checkCurrentUserUsecase: serviceLocator(),
      authCubit: serviceLocator()));
}
