import 'package:bloc/bloc.dart';
import 'package:counter_app/app.dart';
import 'package:counter_app/counter_observer.dart';
import 'package:flutter/widgets.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(const CounterApp());
}
