import 'dart:async';
import 'dart:math';

import 'package:expense_tracker_app/app_view.dart';
import 'package:expense_tracker_app/core/commons/cubit/app_user_cubit.dart';
import 'package:expense_tracker_app/features/auth/views/bloc/auth_bloc.dart';
import 'package:expense_tracker_app/features/home/views/home_page.dart';
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
    Timer(const Duration(seconds: 1), () {
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
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AppUserLoggedIn) {
            return HomePage(
              myUser: state.currentUser,
            );
          }

          if (state is AppUserNoLoggedInUser) {
            return const MyAppView();
          }

          return Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.tertiary,
                ], transform: const GradientRotation(pi / 5))),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'EXPENDS',
                      style: TextStyle(
                          letterSpacing: 4,
                          fontSize: 48,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
