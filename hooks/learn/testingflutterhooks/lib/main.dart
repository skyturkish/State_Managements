import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomeView(),
    );
  }
}

Stream<String> getTime() => Stream.periodic(const Duration(seconds: 1), (_) {
      return DateTime.now().toIso8601String();
    });

class HomeView extends HookWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateTime = useStream(getTime());
    print('burası güncelleniyor');
    return Scaffold(
      appBar: AppBar(
        title: Text(dateTime.data ?? 'Home page'),
      ),
    );
  }
}
