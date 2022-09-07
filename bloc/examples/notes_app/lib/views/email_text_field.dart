import 'package:flutter/material.dart';
import 'package:notes_app/core/constants/strings.dart';

class EmailTextFormField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextFormField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: StringConstants.enterYourEmailHere,
      ),
    );
  }
}
