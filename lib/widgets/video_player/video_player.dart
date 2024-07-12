import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:sriram_s_application3/Services/api_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RTSPVideoPlayer extends StatefulWidget {
  String rtspUrl;

  RTSPVideoPlayer({required this.rtspUrl});

  @override
  _RTSPVideoPlayerState createState() => _RTSPVideoPlayerState();
}

class _RTSPVideoPlayerState extends State<RTSPVideoPlayer> {
  late VlcPlayerController _vlcPlayerController;
  WebSocketChannel? channel;
  Image? currentImage;
  Timer? _timer;
  ApiService apiService = ApiService();

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // final String streamUrl =
  //     ModalRoute.of(context)!.settings.arguments as String;

  // }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }

  void _onFrameCaptured() async {
    final snapshot = await _vlcPlayerController.takeSnapshot();
    if (snapshot != null) {
      String base64Snapshot = base64Encode(snapshot);
      await apiService.sendFaces(
        name: 'ImageName',
        embedding: base64Snapshot,
      );
    }
  }

  //
  void _startFrameCapture() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (_vlcPlayerController.value.isInitialized) {
        _onFrameCaptured();
      }
    });
  }

  String? frameBase64;
  List<DetectedFace> detectedFaces = [];

  @override
  void initState() {
    _vlcPlayerController = VlcPlayerController.network(
      widget.rtspUrl,
      autoPlay: true,
    );
    _vlcPlayerController.addListener(_onFrameCaptured);
    _startFrameCapture();
    // channel = WebSocketChannel.connect(Uri.parse(widget.rtspUrl)
    //     // "rtsp://admin:skypler@sriram@210.18.176.33:554/Streaming/Channels/101")
    //     );
    //
    // channel!.stream.listen((message) {
    //   final data = jsonDecode(message);
    //   setState(() {
    //     frameBase64 = data['frame'];
    //     detectedFaces = (data['detected_faces'] as List)
    //         .map((faceData) => DetectedFace.fromJson(faceData))
    //         .toList();
    //   });
    //
    //   // Send detected faces to backend
    //   apiService.sendDetectedFacesToBackend(detectedFaces);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: VlcPlayer(
        controller: _vlcPlayerController,
        aspectRatio: 4 / 3,
        placeholder: Center(child: CircularProgressIndicator()),
      )),
    );
  }
}

class DetectedFace {
  final String name;
  final String embedding;
  final String? image;

  DetectedFace({required this.name, required this.embedding, this.image});

  factory DetectedFace.fromJson(Map<String, dynamic> json) {
    return DetectedFace(
      name: json['name'],
      embedding: json['embedding'],
      image: json.containsKey('image') ? json['image'] : null,
    );
  }
}
