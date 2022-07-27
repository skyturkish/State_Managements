import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (context) => ThemeNotifier(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ThemeNotifier>().currentTheme,
      title: 'Material App',
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView Bar'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.read<ThemeNotifier>().changeTheme();
            },
            child: const Text('Change Theme')),
      ),
    );
  }
}

enum AppThemes { LIGHT, DARK }

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  AppThemes _currentThemeEnum = AppThemes.LIGHT;

  /// Applicaton theme enum.
  /// Deafult value is [AppThemes.LIGHT]
  AppThemes get currenThemeEnum => _currentThemeEnum;
  ThemeData get currentTheme => _currentTheme;

  /// Change your app theme with [currenThemeEnum] value.
  void changeTheme() {
    if (_currentThemeEnum == AppThemes.LIGHT) {
      _currentTheme = ThemeData.dark();
      _currentThemeEnum = AppThemes.DARK;
    } else {
      _currentTheme = ThemeData.light();
      _currentThemeEnum = AppThemes.LIGHT;
    }
    notifyListeners();
  }
}
