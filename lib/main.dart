import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}




class Contact{

  final String name;

  Contact({required this.name});

}




// A singleton. Class which can be initialized only once

class ContactBook{
  ContactBook._sharedInstance();

   static final ContactBook _shared = ContactBook._sharedInstance();
   factory ContactBook( )=> _shared;
   List<Contact> _contacts = [];

   int get length => _contacts.length;


   void addContact({required Contact contact}) => _contacts.add(contact);
   void removeContact({required Contact contact}) => _contacts.remove(contact);



   Contact? contact({required int atIndex}) => _contacts.length > atIndex ? _contacts[atIndex] : null;
}






class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final contactBook = ContactBook();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ListView.builder(itemBuilder: (context, index) {

        final contact = contactBook.contact(atIndex: index);
        ListTile(title : Text(contact!.name));


        



      }, itemCount: contactBook.length,)
    );
  }
}


