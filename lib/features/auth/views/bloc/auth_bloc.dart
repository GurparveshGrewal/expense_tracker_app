import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/core/commons/cubit/app_user_cubit.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/check_current_user_usecase.dart';
import 'package:expense_tracker_app/features/auth/domain/usecases/signup_with_email_password.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpWithEmailAndPasswordUsecase _signUpWithEmailAndPasswordUsecase;
  final CheckCurrentUserUsecase _checkCurrentUserUsecase;
  final AppUserCubit _authCubit;
  AuthBloc({
    required SignUpWithEmailAndPasswordUsecase
        signUpWithEmailAndPasswordUsecase,
    required CheckCurrentUserUsecase checkCurrentUserUsecase,
    required AppUserCubit authCubit,
  })  : _signUpWithEmailAndPasswordUsecase = signUpWithEmailAndPasswordUsecase,
        _checkCurrentUserUsecase = checkCurrentUserUsecase,
        _authCubit = authCubit,
        super(AuthInitialState()) {
    on<AuthEvent>((event, emit) => emit(AuthLoadingState()));
    on<AuthCheckIfUserLoggendIn>(authCheckIfUserLoggendIn);
    on<AuthSignUpProcessEvent>(authSignUpProcessEvent);
  }

  FutureOr<void> authCheckIfUserLoggendIn(
      AuthCheckIfUserLoggendIn event, Emitter<AuthState> emit) async {
    final currentUser = await _checkCurrentUserUsecase({});

    if (currentUser.uid != '') {
      _emitAuthSuccess(currentUser, emit);
    } else {
      emit(AuthUserLogInFailedState());
    }
  }

  FutureOr<void> authSignUpProcessEvent(
      AuthSignUpProcessEvent event, Emitter<AuthState> emit) async {
    final user = await _signUpWithEmailAndPasswordUsecase(
        SignupWithEmailAndPasswordUsecaseParams(
      name: event.fullName,
      email: event.email,
      password: event.password,
    ));

    if (user.uid == '') {
      emit(AuthUserLogInFailedState());
    } else {
      _emitAuthSuccess(user, emit);
    }
  }

  void _emitAuthSuccess(MyUser currentUser, Emitter<AuthState> emit) {
    _authCubit.updateUser(currentUser);
    emit(AuthUserLogInSuccessState());
  }
}
