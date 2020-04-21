// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.screen.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStore, Store {
  final _$userIdsAtom = Atom(name: '_ChatStore.userIds');

  @override
  ObservableList<String> get userIds {
    _$userIdsAtom.context.enforceReadPolicy(_$userIdsAtom);
    _$userIdsAtom.reportObserved();
    return super.userIds;
  }

  @override
  set userIds(ObservableList<String> value) {
    _$userIdsAtom.context.conditionallyRunInAction(() {
      super.userIds = value;
      _$userIdsAtom.reportChanged();
    }, _$userIdsAtom, name: '${_$userIdsAtom.name}_set');
  }

  final _$messagesAtom = Atom(name: '_ChatStore.messages');

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.context.enforceReadPolicy(_$messagesAtom);
    _$messagesAtom.reportObserved();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.context.conditionallyRunInAction(() {
      super.messages = value;
      _$messagesAtom.reportChanged();
    }, _$messagesAtom, name: '${_$messagesAtom.name}_set');
  }

  final _$_ChatStoreActionController = ActionController(name: '_ChatStore');

  @override
  dynamic addMessage(String message) {
    final _$actionInfo = _$_ChatStoreActionController.startAction();
    try {
      return super.addMessage(message);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'userIds: ${userIds.toString()},messages: ${messages.toString()}';
    return '{$string}';
  }
}
