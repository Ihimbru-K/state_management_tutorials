import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Contact {
  final String name;

  Contact({required this.name});
}

// A singleton. Class which can be initialized only once
class ContactBook {
  ContactBook._sharedInstance();

  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  final List<Contact> _contacts = [];

  int get length => _contacts.length;

  void addContact({required Contact contact}) => _contacts.add(contact);
  void removeContact({required Contact contact}) => _contacts.remove(contact);

  Contact? contact({required int atIndex}) =>
      _contacts.length > atIndex ? _contacts[atIndex] : null;
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
      body: ListView.builder(
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
      ),
      floatingActionButton:  FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add),),
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
            decoration: const InputDecoration(
              hintText: "Input contact name"
            ),

          ),
          
          TextButton(onPressed: (){
            final contact = Contact(name: _controller.text);
            ContactBook().addContact(contact: contact);

            
            
            
            
          }, child: const Text("Add contact"),)



        ],
      ),






    );
  }
}

