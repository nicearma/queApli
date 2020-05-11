import 'dart:math';

import 'package:flutter_webrtc/webrtc.dart';
import 'package:mobx/mobx.dart';

part 'streaming.g.dart';

var streamingStore = new StreamingStore();

class StreamingStore = _StreamingStore with _$StreamingStore;

abstract class _StreamingStore with Store {

  @observable
  ObservableList<dynamic> users = ObservableList.of([]);

  @observable
  String selfId;

  @observable
  SignalingState state;

  @observable
  String sessionId;

  @observable
  MediaStream localStream;

  @observable
  MediaStream remoteStream;

  @observable
  RTCPeerConnection currentPeerConnection;

  @observable
  String message;

  @action
  setSelfId(String id) {
    selfId = id;
  }

  @action
  changeState(SignalingState state) {
    this.state = state;
  }

  @action
  setCurrentPeerConnection(RTCPeerConnection peerConnection) {
    currentPeerConnection = peerConnection;
  }

  @action
  setSessionId(String id) {
    sessionId = id;
  }

  @action
  changeLocalStream(MediaStream stream) {
    localStream = stream;
  }

  @action
  changeRemoteStream(MediaStream stream) {
    remoteStream = stream;
  }

  @action
  addConnectedUser(dynamic user) {
    users.add(user);
  }

  @action
  deleteUser(dynamic user) {
    users.remove(user);
  }

  @action
  cleanStreaming() {
    sessionId = null;

    if (localStream != null) {
      localStream.dispose();
    }
    localStream = null;

    if (remoteStream != null) {
      remoteStream.dispose();
    }
    remoteStream = null;

    if (currentPeerConnection != null) {
      currentPeerConnection.close();
      currentPeerConnection.dispose();
    }
    currentPeerConnection = null;
  }

  @action
  lastMessage(RTCDataChannelMessage data) {
    String message;
    if (data.isBinary) {
      message = 'Got binary [${data.binary.toString()}]';
    } else {
      message = data.text;
    }
    this.message = message;
  }
}

enum SignalingState {
  CallStateNew,
  CallStateRinging,
  CallStateInvite,
  CallStateConnected,
  CallStateBye,
  ConnectionOpen,
  ConnectionClosed,
  ConnectionError,
}
