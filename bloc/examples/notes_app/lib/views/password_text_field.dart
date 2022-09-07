import 'package:flutter/material.dart';
import 'package:notes_app/core/constants/strings.dart';

class PasswordTextFormField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextFormField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      obscuringCharacter: '*',
      decoration: const InputDecoration(
        hintText: StringConstants.enterYourPasswordHere,
      ),
    );
  }
}
