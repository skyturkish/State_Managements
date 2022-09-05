import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'dart:developer' as devtools show log;

// for more information about CompactMap => https://www.hackingwithswift.com/articles/205/whats-the-difference-between-map-flatmap-and-compactmap
extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(
    const MyApp(),
  );
}

class CountDown extends ValueNotifier<int> {
  late StreamSubscription streamSubscription;

  CountDown({required int from}) : super(from) {
    streamSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (v) => from - v,
    ).takeWhile((value) => value >= 0).listen((value) {
      this.value = value;
    });
  }
  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
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

const String url = 'https://i.pinimg.com/originals/aa/02/78/aa02780bbc7e6c5e2d52d9b0e919fbf6.jpg';

class HomeView extends HookWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    'yenilendi'.log();
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home VView'),
      ),
      body: Center(child: Text(notifier.value.toString())),
    );
  }
}
