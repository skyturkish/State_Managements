import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: const HomeView(),
      routes: {
        '/new-contact': (context) => const NewContantView(),
      },
    );
  }
}

class Contact {
  final String id;
  final String name;
  Contact({
    required this.name,
  }) : id = const Uuid().v4();
}

// ---------------------We provide a type which we want to listen
class ContactBook extends ValueNotifier<List<Contact>> {
  // Singleton
  ContactBook._sharedInstance() : super([Contact(name: 'Hello')]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  int get length => value.length;

  void add({required Contact contact}) {
    // We're actually changing not the value itself but er're changing the internals of value
    // so this doesn't this code sends no seetter signal to our change notifier

    // value.add((contact));
    // notifyListeners(); That would work

    // Or

    final concats = value;
    concats.add(contact);
    //value = concats; will delete
    notifyListeners();
  }

  void remove({required Contact contact}) {
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
      //value = contacts;
      notifyListeners();
    }
  }

  Contact? contact({required int atIndex}) => value.length > atIndex ? value[atIndex] : null;
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView Bar'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (context, List<Contact> value, child) {
          final contacts = value;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Dismissible(
                onDismissed: (direction) {
                  //contacts.remove(contact);
                  // Or
                  ContactBook().remove(contact: contact);
                },
                key: ValueKey(contact.id),
                child: Material(
                  color: Colors.white,
                  elevation: 6.6,
                  child: ListTile(
                    title: Text(contact.name),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/new-contact');
        },
        child: const Icon(Icons.ad_units),
      ),
    );
  }
}

class NewContantView extends StatefulWidget {
  const NewContantView({Key? key}) : super(key: key);

  @override
  State<NewContantView> createState() => NewContantViewState();
}

class NewContantViewState extends State<NewContantView> {
  @override
  void didUpdateWidget(covariant NewContantView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NewContant',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter a new contact name here... '),
            ),
            TextButton(
              onPressed: () {
                final contact = Contact(name: _controller.text);
                ContactBook().add(contact: contact);
                Navigator.of(context).pop();
              },
              child: const Text('Add contact'),
            )
          ],
        ),
      ),
    );
  }
}
