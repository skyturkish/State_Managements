import 'package:flutter/material.dart';

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
  final String name;
  Contact({
    required this.name,
  });
}

class ContactBook {
  // Singleton
  ContactBook._sharedInstance();
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  final List<Contact> _contacts = [Contact(name: 'Sky')];

  int get length => _contacts.length;

  void add({required Contact contact}) {
    _contacts.add((contact));
  }

  void remove({required Contact contact}) {
    _contacts.remove((contact));
  }

  Contact? contact({required int atIndex}) => _contacts.length > atIndex ? _contacts[atIndex] : null;
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final contackBook = ContactBook();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView Bar'),
      ),
      body: ListView.builder(
        itemCount: contackBook.length,
        itemBuilder: (context, index) {
          final contact = contackBook.contact(atIndex: index)!;
          return ListTile(
            title: Text(contact.name),
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
      body: Column(
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
    );
  }
}
