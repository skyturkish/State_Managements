import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'dart:developer' as devtools show log;

// for more information about CompactMap => https://www.hackingwithswift.com/articles/205/whats-the-difference-between-map-flatmap-and-compactmap

extension Log on Object {
  void log() => devtools.log(toString());
}

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

const String url = 'https://i.pinimg.com/originals/aa/02/78/aa02780bbc7e6c5e2d52d9b0e919fbf6.jpg';

class HomeView extends HookWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = useStreamController<double>(onListen: () {
      controller.sink.add(0.0);
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home VView'),
        ),
        body: StreamBuilder<double>(
          stream: controller.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              final rotation = snapshot.data ?? 0.0;
              return GestureDetector(
                onTap: () {
                  controller.sink.add(rotation + 90.0);
                },
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(rotation / 360.0),
                  child: Center(
                    child: Image.network(url),
                  ),
                ),
              );
            }
          },
        ));
  }
}
