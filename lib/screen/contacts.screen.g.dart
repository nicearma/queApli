// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts.screen.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactsStore on _ContactsStore, Store {
  final _$contactPermissionGrantedAtom =
      Atom(name: '_ContactsStore.contactPermissionGranted');

  @override
  bool get contactPermissionGranted {
    _$contactPermissionGrantedAtom.context
        .enforceReadPolicy(_$contactPermissionGrantedAtom);
    _$contactPermissionGrantedAtom.reportObserved();
    return super.contactPermissionGranted;
  }

  @override
  set contactPermissionGranted(bool value) {
    _$contactPermissionGrantedAtom.context.conditionallyRunInAction(() {
      super.contactPermissionGranted = value;
      _$contactPermissionGrantedAtom.reportChanged();
    }, _$contactPermissionGrantedAtom,
        name: '${_$contactPermissionGrantedAtom.name}_set');
  }

  final _$contactsAtom = Atom(name: '_ContactsStore.contacts');

  @override
  ObservableList<Contact> get contacts {
    _$contactsAtom.context.enforceReadPolicy(_$contactsAtom);
    _$contactsAtom.reportObserved();
    return super.contacts;
  }

  @override
  set contacts(ObservableList<Contact> value) {
    _$contactsAtom.context.conditionallyRunInAction(() {
      super.contacts = value;
      _$contactsAtom.reportChanged();
    }, _$contactsAtom, name: '${_$contactsAtom.name}_set');
  }

  final _$loadContactsAsyncAction = AsyncAction('loadContacts');

  @override
  Future<void> loadContacts() {
    return _$loadContactsAsyncAction.run(() => super.loadContacts());
  }

  @override
  String toString() {
    final string =
        'contactPermissionGranted: ${contactPermissionGranted.toString()},contacts: ${contacts.toString()}';
    return '{$string}';
  }
}
