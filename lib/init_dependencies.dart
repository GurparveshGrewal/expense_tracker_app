import 'package:expense_tracker_app/core/commons/cubit/app_user_cubit.dart';
import 'package:expense_tracker_app/core/repository/shared_preferences_reposity.dart';
import 'package:expense_tracker_app/core/wrappers/firebase_auth_wrapper.dart';
import 'package:expense_tracker_app/core/wrappers/firestore_database_wrapper.dart';
import 'package:expense_tracker_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker_app/features/auth/domain/repository/auth_repository.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/check_current_user_usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/clear_shared_prefs_usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/sign_out.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signin_with_email_password%20.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signin_with_google.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signup_with_email_password.dart';
import 'package:expense_tracker_app/features/auth/views/bloc/auth_bloc.dart';
import 'package:expense_tracker_app/features/home/data/repository/home_repository_impl.dart';
import 'package:expense_tracker_app/features/home/domain/repository/home_repository.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/add_expense_to_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/add_income_to_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/fetch_expenses_from_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/fetch_filtered_expenses.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/fetch_incomes_from_database.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/get_saved_currency.dart';
import 'package:expense_tracker_app/features/home/domain/usecases/save_selected_currency.dart';
import 'package:expense_tracker_app/features/home/views/bloc/home_bloc.dart';
import 'package:expense_tracker_app/features/stats/bloc/stats_bloc.dart';
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
  serviceLocator.registerLazySingleton<SharedPreferencesRepository>(
      () => SharedPreferencesRepositoryImpl());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(),
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
  serviceLocator.registerFactory(() => ClearSharedPrefsUsecase(
        serviceLocator(),
      ));

  // Blocs
  serviceLocator.registerLazySingleton(() => AuthBloc(
      clearSharedPrefsUsecase: serviceLocator(),
      signInWithEmailAndPasswordUsecase: serviceLocator(),
      signUpWithEmailAndPasswordUsecase: serviceLocator(),
      signOutUsecase: serviceLocator(),
      signInWithGoogleUsecase: serviceLocator(),
      checkCurrentUserUsecase: serviceLocator(),
      authCubit: serviceLocator()));
}

void _initHome() {
  serviceLocator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ));

  // Usecases
  serviceLocator
      .registerFactory(() => AddExpenseToDatabaseUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => FetchExpensesFromDatabaseUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => AddIncomeToDatabaseUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => FetchIncomesFromDatabaseUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => FetchFilteredExpensesUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => GetSavedCurrencyUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => SaveSelectedCurrencyUsecase(serviceLocator()));

  // Blocs
  serviceLocator.registerLazySingleton(() => HomeBloc(
        sharedPreferencesRepository: serviceLocator(),
        getSavedCurrencyUsecase: serviceLocator(),
        saveSelectedCurrencyUsecase: serviceLocator(),
        addExpenseToDatabaseUsecase: serviceLocator(),
        fetchExpensesFromDatabaseUsecase: serviceLocator(),
        fetchIncomes: serviceLocator(),
        addIncomeToDatabaseUsecase: serviceLocator(),
      ));
  serviceLocator.registerLazySingleton(() => StatsBloc(
        filteredExpenseUsercase: serviceLocator(),
      ));
}
