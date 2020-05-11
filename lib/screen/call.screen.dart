import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_webrtc/webrtc.dart';
import 'package:queappli/screen/streaming/singaling.service.dart';
import 'package:queappli/screen/streaming/streaming.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({
    Key key,
  }) : super(key: key);

  @override
  CallState createState() => CallState();
}

class CallState extends State<CallScreen> {
  SignalingService signalingService;

  Future _initializeControllerFuture;

  String _peerIdToCall;

  Completer _completer;

  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();

  @override
  void initState() {
    super.initState();

    signalingService = new SignalingService();

    _initializeControllerFuture = createFuture();
    initRenderers();
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> createFuture() {
    _completer = new Completer();

    return _completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Call to')),
        // Wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner
        // until the controller has finished initializing.
        body: Observer(builder: (_) {
          var toAdd = <Widget>[];
          if (streamingStore.remoteStream == null &&
              streamingStore.localStream == null) {
            toAdd.add(Text("MAKING CALL"));
          }

          if (streamingStore.remoteStream != null) {
            _remoteRenderer.srcObject = streamingStore.remoteStream;
            toAdd.add(Container(
              margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/5,
              child: new RTCVideoView(_remoteRenderer),
              decoration: new BoxDecoration(color: Colors.red),
            ));
          }
          if (streamingStore.localStream != null) {
            _localRenderer.srcObject = streamingStore.localStream;
            toAdd.add(Container(
              margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/5,
              child: new RTCVideoView(_localRenderer),
              decoration: new BoxDecoration(color: Colors.green),
            ));
          }

          return Column(
              children: <Widget>[
            TextFormField(
              onChanged: (value) {
                streamingStore.setSelfId(value);
              },
            ),
            RaisedButton(
              onPressed: () {
                signalingService
                    .makeEventSourceConnection(streamingStore.selfId);
                _completer.complete();
              },
              child: Text('Connect with user'),
            ),
            TextFormField(
              onChanged: (value) {
                _peerIdToCall = value;
              },
            ),
            RaisedButton(
              onPressed: () {
                signalingService.invite(_peerIdToCall, 'video');
              },
              child: Text('Call the user'),
            ),
            GestureDetector(
              onTap: () {
                signalingService.close();
              },
              child: Text("Close call"),
            ),
          ]..addAll(toAdd));
        }));
  }
}
