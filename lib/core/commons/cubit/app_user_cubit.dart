import 'package:bloc/bloc.dart';
import 'package:expense_tracker_app/features/auth/domain/entities/my_user_entity.dart';
import 'package:flutter/material.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(MyUser? currentUser) {
    if (currentUser == null || currentUser.uid == '') {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(currentUser));
    }
  }
}
