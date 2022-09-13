import 'package:firebase_auth_firebase_storage_app/firebase_options.dart';
import 'package:firebase_auth_firebase_storage_app/views/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await _init();

  runApp(
    const AppView(),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
