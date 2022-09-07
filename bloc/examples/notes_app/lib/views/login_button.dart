import 'package:flutter/material.dart';
import 'package:notes_app/core/strings.dart';
import 'package:notes_app/dialogs/generic_dialog.dart';

typedef OnLoginTapped = void Function(
  String email,
  String password,
);

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLoginTapped onLoginTapped;

  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final emailText = emailController.text;
        final passwordText = passwordController.text;
        if (emailText.isEmpty || passwordText.isEmpty) {
          showGenericDialog(
            context: context,
            title: StringConstants.emailOrPasswordEmptyDialogTitle,
            content: StringConstants.emailOrPasswordEmptyDescription,
            optionsBuilder: () => {StringConstants.ok: true},
          );
        } else {
          onLoginTapped(emailText, passwordText);
        }
      },
      child: const Text(StringConstants.login),
    );
  }
}
