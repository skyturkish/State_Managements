import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

import 'package:flutter_bloc/flutter_bloc.dart';

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

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final NamesCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('hehe'),
        ),
        body: StreamBuilder<String?>(
          stream: cubit.stream,
          builder: (context, snapshot) {
            final button = TextButton(
              onPressed: () {
                cubit.pickRandomName();
              },
              child: const Text('Pick a random name'),
            );
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return button;
              case ConnectionState.waiting:
                return button;
              case ConnectionState.active:
                return Column(
                  children: [
                    Text(snapshot.data ?? ''),
                    button,
                  ],
                );
              case ConnectionState.done:
                return const SizedBox();
            }
          },
        ));
  }
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

// --------------------------  T yerine neyi tutacağımız, state'in ne olacağını yazıyoruz
class NamesCubit extends Cubit<String?> {
  // constructor kısmında state'in initial değerini vermek zorundayız
  NamesCubit() : super(null);

  // state'i sadece okuyabiliyorzu, eğer değiştirmek istersek onu emitin yardımı ile yapıyoruz
  void pickRandomName() => emit(ConstantStrings.instance.names.getRandomElement());
}

class ConstantStrings {
  static final ConstantStrings _instance = ConstantStrings._init();

  static ConstantStrings get instance => _instance;

  ConstantStrings._init();

  List<String> get names => ['ahmet', 'mehmet', 'hüseyin'];
}
