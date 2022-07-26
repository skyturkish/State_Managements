import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as devtools show log;

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => ShoppingCardProvider(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge(
              badgeContent: Text(context.watch<ShoppingCardProvider>().length.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Text('add Product'),
          Counter(),
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<ShoppingCardProvider>().addProduct();
      },
      child: const Text('add Product'),
    );
  }
}

class ShoppingCardProvider extends ChangeNotifier {
  static ShoppingCardProvider? _instance;
  static ShoppingCardProvider get instance {
    _instance ??= ShoppingCardProvider._init();
    return _instance!;
  }

  ShoppingCardProvider._init();

  late int _length;

  int get length => _length;

  ShoppingCardProvider() : _length = 0;

  void addProduct() {
    _length++;
    devtools.log(_length.toString());
    notifyListeners();
  }

  void deleteProduct() {
    if (_length != 0) {
      _length--;
      notifyListeners();
    }
  }
}
