import 'package:expense_tracker_app/core/commons/common_gradient_button.dart';
import 'package:expense_tracker_app/core/commons/icon_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        child: Form(
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
              CommonGradientButton(buttonTitle: "SIGN IN", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
