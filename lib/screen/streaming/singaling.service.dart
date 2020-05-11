import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_webrtc/media_stream.dart';
import 'package:flutter_webrtc/webrtc.dart';

import 'package:queappli/screen/streaming/streaming.dart';
import 'package:w3c_event_source/event_source.dart';
import 'dart:developer' as developer;

const BACKEND_URL = "http://192.168.1.16:8080";

class SignalingService {
  EventSource backendEvents;

  var _remoteCandidates = [];

  Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
      /*
       * turn server configuration example.
      {
        'url': 'turn:123.45.67.89:3478',
        'username': 'change_to_real_user',
        'credential': 'change_to_real_secret'
      },
       */
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ],
  };

  final Map<String, dynamic> _constraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': [],
  };

  final Map<String, dynamic> _dc_constraints = {
    'mandatory': {
      'OfferToReceiveAudio': false,
      'OfferToReceiveVideo': false,
    },
    'optional': [],
  };

  Future<MediaStream> createVideoStreamFromCamera() async {
    developer.log("Create video stream from camera", name: 'singaling');
    MediaStream stream = await navigator.getUserMedia(_getMediaContraints());
    return stream;
  }

  Future<MediaStream> createVideoStreamFromDevice() async {
    developer.log("Create miror stream from device", name: 'singaling');
    MediaStream stream = await navigator.getDisplayMedia(_getMediaContraints());
    return stream;
  }

  _getMediaContraints() {
    return {
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth':
              '640', // Provide your own width, height and frame rate here
          'minHeight': '480',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };
  }

  // TODO: change name
  _createPeerConnection(peerId, media) async {
    // create connection
    RTCPeerConnection pc = await createPeerConnection(_iceServers, _config);

    // if not data, so CAMERA, get camera stream and add to connection
    if (media != 'data') {
      var localStream = await createVideoStreamFromCamera();
      streamingStore.changeLocalStream(localStream);
      pc.addStream(localStream);
    }

    // when ice candidate found, then to backend the info, this will use to stablish the p2p connection
    pc.onIceCandidate = (candidate) {
      developer.log("Sending ice candidate", name: 'singaling');

      var dio = new Dio();
      dio.post("$BACKEND_URL/signaling/candidate", data: {
        'to': peerId,
        'from': streamingStore.selfId,
        'candidate': {
          'sdpMLineIndex': candidate.sdpMlineIndex,
          'sdpMid': candidate.sdpMid,
          'candidate': candidate.candidate,
        },
        'session_id': streamingStore.sessionId,
      });
    };

    pc.onIceConnectionState = (state) {};

    pc.onAddStream = (remoteStream) {
      developer.log("Remote streaming recived", name: 'singaling');
      streamingStore.changeRemoteStream(remoteStream);
    };

    pc.onRemoveStream = (stream) {
      developer.log("Remote streaming quit out", name: 'singaling');
      streamingStore.changeRemoteStream(null);
    };

    pc.onDataChannel = (channel) {
      developer.log("Remote data chanel recived", name: 'singaling');
      _addDataChannel(peerId, channel);
    };

    return pc;
  }

  _addDataChannel(peerId, RTCDataChannel channel) {
    channel.onDataChannelState = (e) {};

    channel.onMessage = (RTCDataChannelMessage data) {
      developer.log("Message recived from peer", name: 'singaling');
      streamingStore.lastMessage(data);
    };
  }

  void invite(String peerId, String media) {
    developer.log("invite peer $peerId with media $media", name: 'singaling');

    var _sessionId = streamingStore.selfId + '-' + peerId;
    streamingStore.setSessionId(_sessionId);
    streamingStore.changeState(SignalingState.CallStateNew);

    _createPeerConnection(peerId, media).then((pc) {
      if (media == 'data') {
        // TODO:
        //_createDataChannel(peerId, pc);
      }
      _createAndSendConnectionOffer(peerId, pc, media);
    });
  }

  _createAndSendConnectionOffer(
      String peerId, RTCPeerConnection pc, String media) async {
    try {
      RTCSessionDescription s = await pc
          .createOffer(media == 'data' ? _dc_constraints : _constraints);
      pc.setLocalDescription(s);
      var dio = new Dio();
      dio.post("$BACKEND_URL/signaling/connection-offer", data: {
        'to': peerId,
        'from': streamingStore.selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': streamingStore.sessionId,
        'media': media,
      });
      developer.log("Offer p2p send to $peerId with media $media",
          name: 'singaling');
    } catch (e) {
      print(e.toString());
    }
  }

  _createAndSendAnswerConnectionOffer(
      String peerId, RTCPeerConnection pc, media) async {
    try {
      RTCSessionDescription s = await pc
          .createAnswer(media == 'data' ? _dc_constraints : _constraints);
      pc.setLocalDescription(s);
      var dio = new Dio();
      dio.post("$BACKEND_URL/signaling/answer-connection-offer", data: {
        'to': peerId,
        'from': streamingStore.selfId,
        'description': {'sdp': s.sdp, 'type': s.type},
        'session_id': streamingStore.sessionId,
      });

      developer.log("Answare of offer send to $peerId with media $media",
          name: 'singaling');
    } catch (e) {
      print(e.toString());
    }
  }

  makeEventSourceConnection(String selfId) async {
    backendEvents =
        EventSource(Uri.parse("$BACKEND_URL/signaling/events?user=$selfId"));

    backendEvents.events.listen((MessageEvent message) {
      if(message.name == "message") {
        Map<String, dynamic> json = jsonDecode(message.data);
        _onMessage(json['type'], json);
      }

    });

    backendEvents.open();

    developer.log("Connected to server eventSent", name: 'singaling');
  }

  close() {
    backendEvents.close();
    streamingStore.cleanStreaming();
  }

  void _onMessage(String type, data) async {
    developer.log("Message recived $type", name: 'singaling');

    switch (type) {
      case 'peopleConnected':
        {
          streamingStore.addConnectedUser(data);
        }
        break;
      case 'connectionOffer':
        {
          var id = data['from'];
          var description = data['description'];
          var media = data['media'];

          streamingStore.setSessionId(data['session_id']);
          streamingStore.changeState(SignalingState.CallStateNew);

          var pc = await _createPeerConnection(id, media);

          await pc.setRemoteDescription(new RTCSessionDescription(
              description['sdp'], description['type']));

          await _createAndSendAnswerConnectionOffer(id, pc, media);

          if (this._remoteCandidates.length > 0) {
            _remoteCandidates.forEach((candidate) async {
              await pc.addCandidate(candidate);
            });
            _remoteCandidates.clear();
          }


        }
        break;
      case 'answerConnectionOffer':
        {
          var description = data['description'];

          // TODO: verify if is the same
          // var id = data['from'];

          var pc = streamingStore.currentPeerConnection;
          if (pc != null) {
            await pc.setRemoteDescription(new RTCSessionDescription(
                description['sdp'], description['type']));
          }
        }
        break;
      case 'candidate':
        {
          // TODO: verify if is the same
          var id = data['from'];

          var candidateMap = data['candidate'];

          var pc = streamingStore.currentPeerConnection;

          RTCIceCandidate candidate = new RTCIceCandidate(
              candidateMap['candidate'],
              candidateMap['sdpMid'],
              int.parse(candidateMap['sdpMLineIndex']));

          if (pc != null) {
            await pc.addCandidate(candidate);
          } else {
            _remoteCandidates.add(candidate);
          }

        }
        break;
      case 'leave':
        {
          streamingStore.changeState(SignalingState.CallStateBye);
          streamingStore.cleanStreaming();
        }
        break;
      case 'bye':
        {
          streamingStore.changeState(SignalingState.CallStateBye);
          streamingStore.cleanStreaming();
        }
        break;
      case 'keepalive':
        {
          print('keepalive response!');
        }
        break;
      default:
        break;
    }
  }
}
