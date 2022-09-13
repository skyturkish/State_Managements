import 'package:firebase_auth_firebase_storage_app/bloc/app_bloc.dart';
import 'package:firebase_auth_firebase_storage_app/bloc/app_event.dart';
import 'package:firebase_auth_firebase_storage_app/extensions/if_debugging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'gokturk.acr2002@gmail.com'.ifDebugging);
    _passwordController = TextEditingController(text: 'abc123'.ifDebugging);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Log in',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here...',
                ),
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here...',
                ),
                keyboardAppearance: Brightness.dark,
                obscureText: true,
                obscuringCharacter: '◉', // 😎
              ),
              TextButton(
                onPressed: () {
                  final emailText = _emailController.text;
                  final passwordText = _passwordController.text;
                  context.read<AppBloc>().add(
                        AppEventLogIn(
                          email: emailText,
                          password: passwordText,
                        ),
                      );
                },
                child: const Text(
                  'Log in',
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<AppBloc>().add(
                        const AppEventGoToRegistration(),
                      );
                },
                child: const Text(
                  'Not registered yet? Register here!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
