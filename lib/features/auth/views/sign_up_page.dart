import 'package:expense_tracker_app/core/commons/widgets/common_gradient_button.dart';
import 'package:expense_tracker_app/core/commons/widgets/icon_text_field.dart';
import 'package:expense_tracker_app/core/commons/widgets/loader.dart';
import 'package:expense_tracker_app/core/utils/show_snackbar.dart';
import 'package:expense_tracker_app/features/auth/views/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController fullNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUserLogInSuccessState) {
            showSnackBar(context, "Auth Success");
          } else if (state is AuthUserLogInFailedState) {
            showSnackBar(context, "Auth Failed");
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Loader();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconTextFieldWidget(
                    controller: fullNameTextController,
                    icon: Icons.person,
                    hintText: 'Full Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconTextFieldWidget(
                    inputType: TextInputType.emailAddress,
                    controller: emailTextController,
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
                      buttonTitle: "SIGN UP",
                      onTap: () {
                        context.read<AuthBloc>().add(AuthSignUpProcessEvent(
                            email: emailTextController.text.trim(),
                            password: passwordTextController.text.trim(),
                            fullName: fullNameTextController.text.trim()));
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
