import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // we provide from top, from here
      create: (_) => BreadCrumbProvider(),
      child: MaterialApp(
        title: 'Material App',
        home: const HomeView(),
        routes: {'/new': (context) => const NewBreadCrumbWidget()},
      ),
    );
  }
}

class BreadCrumb {
  final String uuid;
  bool isActive;
  final String name;
  BreadCrumb({
    required this.isActive,
    required this.name,
  }) : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BreadCrumb && uuid == other.uuid;
  }

  @override
  int get hashCode => uuid.hashCode;

  String get title => name + (isActive ? ' > ' : '');
}

// UnmodifiableListView is a wrapper (a "view") around the original List,
// and the original cannot be mutated through the UnmodifiableListView. Mutations to the original
// List can still be observed in the UnmodifiableListView.
class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items); // UnmoidiableListView

  void add(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.activate();
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}

class BreadCrumbsWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> breadCrumbs;
  const BreadCrumbsWidget({Key? key, required this.breadCrumbs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumbs.map(
        (breadCrumb) {
          return Text(
            breadCrumb.title,
            style: TextStyle(color: breadCrumb.isActive ? Colors.blue : Colors.black),
          );
        },
      ).toList(),
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
        body: Column(
          children: [
            Consumer<BreadCrumbProvider>( // we rebuild with consumer
              builder: (context, value, child) {
                // child will not rebuild
                return BreadCrumbsWidget(breadCrumbs: value.items);
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/new',
                );
              },
              child: const Text('add new bread crumb'),
            ),
            TextButton(
              onPressed: () {
                context.read<BreadCrumbProvider>().reset();
              },
              child: const Text('Reset'),
            )
          ],
        ));
  }
}

class NewBreadCrumbWidget extends StatefulWidget {
  const NewBreadCrumbWidget({Key? key}) : super(key: key);

  @override
  State<NewBreadCrumbWidget> createState() => _NewBreadCrumbWidgetState();
}

class _NewBreadCrumbWidgetState extends State<NewBreadCrumbWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new bread crumb',
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter a new bread crumb here...',
              ),
            ),
            TextButton(
              onPressed: () {
                final text = _controller.text;
                if (text.isNotEmpty) {
                  context.read<BreadCrumbProvider>().add(
                        BreadCrumb(isActive: false, name: text),
                      );
                }
                Navigator.of(context).pop();
              },
              child: const Text(
                'Add',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
