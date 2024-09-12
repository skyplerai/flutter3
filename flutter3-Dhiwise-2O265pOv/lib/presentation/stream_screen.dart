// lib/presentation/stream_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../widgets/video_player/video_player.dart';
import '../services/api_service.dart';

class CameraStreamScreen extends StatefulWidget {
  final String webSocketUrl;
  final String authToken; // Add auth token parameter

  CameraStreamScreen({required this.webSocketUrl, required this.authToken});

  @override
  _CameraStreamScreenState createState() => _CameraStreamScreenState();
}

class _CameraStreamScreenState extends State<CameraStreamScreen> {
  late WebSocketChannel channel;
  List<DetectedFace> detectedFaces = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    final wsUrl = '${widget.webSocketUrl}?token=${widget.authToken}'; // Include token in the URL
    try {
      print('Attempting to connect to WebSocket URL: $wsUrl');
      channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      channel.stream.listen(
            (message) {
          final data = jsonDecode(message);
          setState(() {
            detectedFaces = (data['detected_faces'] as List)
                .map((faceData) => DetectedFace.fromJson(faceData))
                .toList();
          });
        },
        onError: (error) {
          print('WebSocket error: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error connecting to camera stream')),
          );
        },
        onDone: () {
          print('WebSocket connection closed.');
        },
      );
    } catch (e) {
      print('Failed to connect to WebSocket: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to camera stream')),
      );
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera Stream')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: WebSocketVideoPlayer(
              webSocketUrl: widget.webSocketUrl,
              authToken: widget.authToken, // Pass the token
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: detectedFaces.length,
              itemBuilder: (context, index) {
                final face = detectedFaces[index];
                return ListTile(
                  title: Text(face.name),
                  subtitle: Text(face.time),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _renameFace(face),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _renameFace(DetectedFace face) async {
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => _RenameDialog(initialName: face.name),
    );
    if (newName != null && newName.isNotEmpty) {
      try {
        await apiService.renameFace(oldFaceId:face.faceId, newFaceId: newName,);
        setState(() {
          final index = detectedFaces.indexWhere((f) => f.id == face.id);
          if (index != -1) {
            detectedFaces[index] = DetectedFace(
              id: face.id,
              name: newName,
              faceId: face.faceId,
              time: face.time,
            );
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to rename face: $e')),
        );
      }
    }
  }
}

class DetectedFace {
  final int id;
  final String name;
  final String? faceId;
  final String time;

  DetectedFace({required this.id, required this.name, this.faceId, required this.time});

  factory DetectedFace.fromJson(Map<String, dynamic> json) {
    return DetectedFace(
      id: json['id'],
      name: json['name'],
      faceId: json['face_id'],
      time: json['time'],
    );
  }
}

class _RenameDialog extends StatefulWidget {
  final String initialName;

  _RenameDialog({required this.initialName});

  @override
  __RenameDialogState createState() => __RenameDialogState();
}

class __RenameDialogState extends State<_RenameDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rename Face'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: "Enter new name"),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Rename'),
          onPressed: () => Navigator.of(context).pop(_controller.text),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}