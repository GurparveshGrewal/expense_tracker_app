import 'package:expense_tracker_app/core/commons/widgets/common_gradient_button.dart';
import 'package:expense_tracker_app/core/commons/widgets/icon_text_field.dart';
import 'package:expense_tracker_app/core/commons/widgets/loader.dart';
import 'package:expense_tracker_app/core/utils/show_snackbar.dart';
import 'package:expense_tracker_app/features/auth/views/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUserLogInSuccessState) {
              showSnackBar(context, "Auth Success");
            } else if (state is AuthUserLogInFailedState) {
              showSnackBar(context, "Auth Failed");
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) return const Loader();

            return Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconTextFieldWidget(
                    controller: emailTextController,
                    inputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconTextFieldWidget(
                    controller: passwordTextController,
                    icon: FontAwesomeIcons.lock,
                    hintText: 'Password',
                    passwordField: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonGradientButton(
                      disabled: false,
                      buttonTitle: "SIGN IN",
                      onTap: () {
                        context.read<AuthBloc>().add(AuthSignInProcessEvent(
                            email: emailTextController.text.trim(),
                            password: passwordTextController.text.trim()));
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  SignInButton(
                    Buttons.google,
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthProcessSignInWithGoogle());
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
