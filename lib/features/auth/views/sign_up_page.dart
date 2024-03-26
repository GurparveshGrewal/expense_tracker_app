import 'package:expense_tracker_app/core/commons/common_gradient_button.dart';
import 'package:expense_tracker_app/core/commons/icon_text_field.dart';
import 'package:flutter/material.dart';
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
      child: Padding(
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
              CommonGradientButton(buttonTitle: "SIGN UP", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
