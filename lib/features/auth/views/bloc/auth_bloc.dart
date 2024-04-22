import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/core/commons/cubit/app_user_cubit.dart';
import 'package:expense_tracker_app/core/commons/exceptions/failure_exceptions.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/check_current_user_usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/sign_out.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signin_with_email_password.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signin_with_google.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signup_with_email_password.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailAndPasswordUsecase _signInWithEmailAndPasswordUsecase;
  final SignUpWithEmailAndPasswordUsecase _signUpWithEmailAndPasswordUsecase;
  final CheckCurrentUserUsecase _checkCurrentUserUsecase;
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
  final SignOutUsecase _signOutUsecase;
  final AppUserCubit _authCubit;

  AuthBloc({
    required SignInWithEmailAndPasswordUsecase
        signInWithEmailAndPasswordUsecase,
    required SignUpWithEmailAndPasswordUsecase
        signUpWithEmailAndPasswordUsecase,
    required SignInWithGoogleUsecase signInWithGoogleUsecase,
    required CheckCurrentUserUsecase checkCurrentUserUsecase,
    required SignOutUsecase signOutUsecase,
    required AppUserCubit authCubit,
  })  : _signInWithEmailAndPasswordUsecase = signInWithEmailAndPasswordUsecase,
        _signUpWithEmailAndPasswordUsecase = signUpWithEmailAndPasswordUsecase,
        _checkCurrentUserUsecase = checkCurrentUserUsecase,
        _signInWithGoogleUsecase = signInWithGoogleUsecase,
        _signOutUsecase = signOutUsecase,
        _authCubit = authCubit,
        super(AuthInitialState()) {
    on<AuthEvent>((event, emit) {
      if (event is AuthSignOutEvent || event is AuthCheckIfUserLoggendIn) {
      } else {
        emit(AuthLoadingState());
      }
    });
    on<AuthCheckIfUserLoggendIn>(authCheckIfUserLoggendIn);
    on<AuthSignUpProcessEvent>(authSignUpProcessEvent);
    on<AuthSignInProcessEvent>(authSignInProcessEvent);
    on<AuthSignOutEvent>(authSignOutEvent);
    on<AuthProcessSignInWithGoogle>(authProcessSignInWithGoogle);
  }

  FutureOr<void> authCheckIfUserLoggendIn(
      AuthCheckIfUserLoggendIn event, Emitter<AuthState> emit) async {
    try {
      final currentUser = await _checkCurrentUserUsecase({});

      if (currentUser.uid != '') {
        _emitAuthSuccess(currentUser, emit);
      } else {
        _authCubit.updateUser(currentUser, null);
      }
    } on FirestoreDatabaseFailure catch (failure) {
      _authCubit.updateUser(null, failure.message);
    }
  }

  FutureOr<void> authSignInProcessEvent(
      AuthSignInProcessEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await _signInWithEmailAndPasswordUsecase(
          SignInWithEmailAndPasswordUsecaseParams(
        email: event.email,
        password: event.password,
      ));

      _emitAuthSuccess(user, emit);
    } on AuthFailure catch (failure) {
      _emitAuthFailure(
          _getAuthFailureStateMessageFromCode(failure.message), emit);
    }
  }

  FutureOr<void> authSignUpProcessEvent(
      AuthSignUpProcessEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await _signUpWithEmailAndPasswordUsecase(
          SignupWithEmailAndPasswordUsecaseParams(
        name: event.fullName,
        email: event.email,
        password: event.password,
      ));

      _emitAuthSuccess(user, emit);
    } on AuthFailure catch (failure) {
      _emitAuthFailure(
          _getAuthFailureStateMessageFromCode(failure.message), emit);
    } on FirestoreDatabaseFailure catch (failure) {
      _emitAuthFailure(
          _getAuthFailureStateMessageFromFirestoreExceptionCode(
              failure.message),
          emit);
    }
  }

  FutureOr<void> authProcessSignInWithGoogle(
      AuthProcessSignInWithGoogle event, Emitter<AuthState> emit) async {
    try {
      final user = await _signInWithGoogleUsecase({});
      if (user.uid != '') {
        _emitAuthSuccess(user, emit);
      } else {
        emit(AuthUserLogInFailedState(''));
      }
    } on AuthFailure catch (failure) {
      _emitAuthFailure(
          _getAuthFailureStateMessageFromCode(failure.message), emit);
    } on FirestoreDatabaseFailure catch (failure) {
      _emitAuthFailure(
          _getAuthFailureStateMessageFromFirestoreExceptionCode(
              failure.message),
          emit);
    }
  }

  FutureOr<void> authSignOutEvent(
      AuthSignOutEvent event, Emitter<AuthState> emit) async {
    await _signOutUsecase({});
    _authCubit.updateUser(null, null);
  }

  String _getAuthFailureStateMessageFromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Email already registerd, signin directly.';
      case 'invalid-credential':
        return 'Invalid email or passrord!';
      case 'too-many-requests':
        return 'You are making too many requests.\ntry again after some time.';
      default:
        return 'something went wrong.';
    }
  }

  String _getAuthFailureStateMessageFromFirestoreExceptionCode(String code) {
    switch (code) {
      case 'unavailable':
        return 'No internet connection :(';
      default:
        return 'something went wrong.';
    }
  }

  void _emitAuthFailure(String message, Emitter<AuthState> emit) {
    emit(AuthUserLogInFailedState(message));
  }

  void _emitAuthSuccess(MyUser currentUser, Emitter<AuthState> emit) {
    _authCubit.updateUser(currentUser, null);
    emit(AuthUserLogInSuccessState(
      currentUser: currentUser,
    ));
  }
}
