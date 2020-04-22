import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;

part 'contacts.screen.g.dart';



class ContactsStore = _ContactsStore with _$ContactsStore;

abstract class _ContactsStore with Store {
  @observable
  bool contactPermissionGranted = false;

  @observable
  ObservableList<Contact> contacts = ObservableList.of([]);

  @action
  Future<void> loadContacts() async {

    contacts.clear();

    if (await Permission.contacts.request().isGranted) {
      contactPermissionGranted = true;
      contacts.addAll(await ContactsService.getContacts());
      developer.log('contacts size ${contacts.length}', name: 'my.app.category');
    }

  }
}

// A screen that allows users to take a picture using a given camera.
class ContactsScreen extends StatefulWidget {
  const ContactsScreen({
    Key key,
  }) : super(key: key);

  @override
  ContactsState createState() => ContactsState();
}

class ContactsState extends State<ContactsScreen> {
  ContactsStore _contacts = ContactsStore();
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    _initializeControllerFuture = _contacts.loadContacts();
    await _initializeControllerFuture;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Contacts')),
        // Wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner
        // until the controller has finished initializing.
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Observer(
                  builder: (_) => ListView.builder(
                      itemCount: _contacts.contacts.length,
                      itemBuilder: (context, index) {

                        return Card(
                          child: ListTile(
                            leading: FlutterLogo(size: 56.0),
                            title: Text(_contacts.contacts[index].displayName),
                            subtitle: Text(_contacts.contacts[index].identifier),
                          ),
                        );

                      }));
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}


