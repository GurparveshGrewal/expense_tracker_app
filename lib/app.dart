import 'dart:async';

import 'package:expense_tracker_app/app_view.dart';
import 'package:expense_tracker_app/core/commons/cubit/app_user_cubit.dart';
import 'package:expense_tracker_app/core/utils/show_snackbar.dart';
import 'package:expense_tracker_app/features/auth/views/bloc/auth_bloc.dart';
import 'package:expense_tracker_app/features/home/views/home_page.dart';
import 'package:expense_tracker_app/features/splash/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.read<AuthBloc>().add(AuthCheckIfUserLoggendIn());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              background: Colors.grey.shade100,
              onBackground: Colors.black,
              primary: const Color(0xFF00B2E7),
              secondary: const Color(0xFFE064F7),
              tertiary: const Color(0xFFFF8D6C),
              outline: Colors.grey)),
      home: BlocConsumer<AppUserCubit, AppUserState>(
        listener: (context, state) {
          if (state is AppUserNoLoggedInUser) {
            if (state.errorMessage != null) {
              showSnackBar(context, state.errorMessage!);
            }
          }
        },
        builder: (context, state) {
          if (state is AppUserLoggedIn) {
            return HomePage(
              myUser: state.currentUser,
            );
          }

          if (state is AppUserNoLoggedInUser) {
            return const MyAppView();
          }

          return const SplashScreen();
        },
      ),
    );
  }
}
