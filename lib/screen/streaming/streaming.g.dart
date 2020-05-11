// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streaming.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StreamingStore on _StreamingStore, Store {
  final _$usersAtom = Atom(name: '_StreamingStore.users');

  @override
  ObservableList<dynamic> get users {
    _$usersAtom.context.enforceReadPolicy(_$usersAtom);
    _$usersAtom.reportObserved();
    return super.users;
  }

  @override
  set users(ObservableList<dynamic> value) {
    _$usersAtom.context.conditionallyRunInAction(() {
      super.users = value;
      _$usersAtom.reportChanged();
    }, _$usersAtom, name: '${_$usersAtom.name}_set');
  }

  final _$selfIdAtom = Atom(name: '_StreamingStore.selfId');

  @override
  String get selfId {
    _$selfIdAtom.context.enforceReadPolicy(_$selfIdAtom);
    _$selfIdAtom.reportObserved();
    return super.selfId;
  }

  @override
  set selfId(String value) {
    _$selfIdAtom.context.conditionallyRunInAction(() {
      super.selfId = value;
      _$selfIdAtom.reportChanged();
    }, _$selfIdAtom, name: '${_$selfIdAtom.name}_set');
  }

  final _$stateAtom = Atom(name: '_StreamingStore.state');

  @override
  SignalingState get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(SignalingState value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }

  final _$sessionIdAtom = Atom(name: '_StreamingStore.sessionId');

  @override
  String get sessionId {
    _$sessionIdAtom.context.enforceReadPolicy(_$sessionIdAtom);
    _$sessionIdAtom.reportObserved();
    return super.sessionId;
  }

  @override
  set sessionId(String value) {
    _$sessionIdAtom.context.conditionallyRunInAction(() {
      super.sessionId = value;
      _$sessionIdAtom.reportChanged();
    }, _$sessionIdAtom, name: '${_$sessionIdAtom.name}_set');
  }

  final _$localStreamAtom = Atom(name: '_StreamingStore.localStream');

  @override
  MediaStream get localStream {
    _$localStreamAtom.context.enforceReadPolicy(_$localStreamAtom);
    _$localStreamAtom.reportObserved();
    return super.localStream;
  }

  @override
  set localStream(MediaStream value) {
    _$localStreamAtom.context.conditionallyRunInAction(() {
      super.localStream = value;
      _$localStreamAtom.reportChanged();
    }, _$localStreamAtom, name: '${_$localStreamAtom.name}_set');
  }

  final _$remoteStreamAtom = Atom(name: '_StreamingStore.remoteStream');

  @override
  MediaStream get remoteStream {
    _$remoteStreamAtom.context.enforceReadPolicy(_$remoteStreamAtom);
    _$remoteStreamAtom.reportObserved();
    return super.remoteStream;
  }

  @override
  set remoteStream(MediaStream value) {
    _$remoteStreamAtom.context.conditionallyRunInAction(() {
      super.remoteStream = value;
      _$remoteStreamAtom.reportChanged();
    }, _$remoteStreamAtom, name: '${_$remoteStreamAtom.name}_set');
  }

  final _$currentPeerConnectionAtom =
      Atom(name: '_StreamingStore.currentPeerConnection');

  @override
  RTCPeerConnection get currentPeerConnection {
    _$currentPeerConnectionAtom.context
        .enforceReadPolicy(_$currentPeerConnectionAtom);
    _$currentPeerConnectionAtom.reportObserved();
    return super.currentPeerConnection;
  }

  @override
  set currentPeerConnection(RTCPeerConnection value) {
    _$currentPeerConnectionAtom.context.conditionallyRunInAction(() {
      super.currentPeerConnection = value;
      _$currentPeerConnectionAtom.reportChanged();
    }, _$currentPeerConnectionAtom,
        name: '${_$currentPeerConnectionAtom.name}_set');
  }

  final _$messageAtom = Atom(name: '_StreamingStore.message');

  @override
  String get message {
    _$messageAtom.context.enforceReadPolicy(_$messageAtom);
    _$messageAtom.reportObserved();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.context.conditionallyRunInAction(() {
      super.message = value;
      _$messageAtom.reportChanged();
    }, _$messageAtom, name: '${_$messageAtom.name}_set');
  }

  final _$_StreamingStoreActionController =
      ActionController(name: '_StreamingStore');

  @override
  dynamic setSelfId(String id) {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.setSelfId(id);
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeState(SignalingState state) {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.changeState(state);
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentPeerConnection(RTCPeerConnection peerConnection) {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.setCurrentPeerConnection(peerConnection);
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSessionId(String id) {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.setSessionId(id);
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeLocalStream(MediaStream stream) {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.changeLocalStream(stream);
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeRemoteStream(MediaStream stream) {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.changeRemoteStream(stream);
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addConnectedUser(dynamic user) {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.addConnectedUser(user);
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteUser(dynamic user) {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.deleteUser(user);
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cleanStreaming() {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.cleanStreaming();
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic lastMessage(RTCDataChannelMessage data) {
    final _$actionInfo = _$_StreamingStoreActionController.startAction();
    try {
      return super.lastMessage(data);
    } finally {
      _$_StreamingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'users: ${users.toString()},selfId: ${selfId.toString()},state: ${state.toString()},sessionId: ${sessionId.toString()},localStream: ${localStream.toString()},remoteStream: ${remoteStream.toString()},currentPeerConnection: ${currentPeerConnection.toString()},message: ${message.toString()}';
    return '{$string}';
  }
}
