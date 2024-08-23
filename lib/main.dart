import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class Contact {
  final String name;
  final String id;

  Contact({required this.name}): id = Uuid().v4( ); //using uuid genera unique idenifier
}

// A singleton. Class which can be initialized only once
class ContactBook extends ValueNotifier<List<Contact>>{   // value notifier holds a value.
  ContactBook._sharedInstance() : super([]);

  static final ContactBook _shared = ContactBook._sharedInstance();

  factory ContactBook() => _shared;

  final List<Contact> _contacts = [];

  int get length => value.length;

  void addContact({required Contact contact}){
    final ValueNotifier notifier;

    final contacts = value;

    contacts.add(contact);
    //value = contacts;

    notifyListeners();


   // value.add(contact);

  }

  void removeContact({required Contact contact}){
    //_contacts.remove(contact);

    final contacts = value;
    if(contacts.contains(contact)){
      contacts.remove(contact);
      notifyListeners();
    }
    notifyListeners();
    

  }

  Contact? contact({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),

      routes: {
        '/new_contact' : (context) => const NewContactView(),

      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final contactBook = ContactBook();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: ValueListenableBuilder(valueListenable: ContactBook(), builder: (contact, value, child) {
        return
        ListView.builder(
          itemCount: contactBook.length,
          itemBuilder: (context, index) {
            final contact = contactBook.contact(atIndex: index);
            if (contact != null) {
              return ListTile(
                title: Text(contact.name),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
      ;  );


      },

        
      ),
      
      
      

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => NewContactView()));

         await Navigator.pushNamed(context, '/new_contact');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewContactView extends StatefulWidget {
  const NewContactView({super.key});

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _controller;

  @override
  void setState(VoidCallback fn) {
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Input contact name"),
          ),
          TextButton(
            onPressed: () {
              final contact = Contact(name: _controller.text);
              ContactBook().addContact(contact: contact);

              Navigator.of(context).pop();
            },
            child: const Text("Add contact"),
          )
        ],
      ),
    );
  }
}
