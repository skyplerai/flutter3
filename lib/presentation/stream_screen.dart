import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class CameraStreamScreen extends StatefulWidget {
  final String cameraUrl;

  CameraStreamScreen({required this.cameraUrl});

  @override
  _CameraStreamScreenState createState() => _CameraStreamScreenState();
}

class _CameraStreamScreenState extends State<CameraStreamScreen> {
  late WebSocketChannel channel;
  String? frameBase64;
  List<DetectedFace> detectedFaces = [];

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(
        Uri.parse('ws://yourserver.com/ws/camera/${widget.cameraUrl}/'));

    channel.stream.listen((message) {
      final data = jsonDecode(message);
      setState(() {
        frameBase64 = data['frame'];
        detectedFaces = (data['detected_faces'] as List)
            .map((faceData) => DetectedFace.fromJson(faceData))
            .toList();
      });

      // Send detected faces to backend
      sendDetectedFacesToBackend(detectedFaces);
    });
  }

  Future<void> sendDetectedFacesToBackend(List<DetectedFace> faces) async {
    for (var face in faces) {
      try {
        final response = await http.post(
          Uri.parse('http://52.202.36.66/camera/face/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'name': face.name,
            'embedding': face.embedding,
            // 'image': face.image,
          }),
        );

        if (response.statusCode == 201) {
          print('Face saved successfully');
        } else {
          print('Failed to save face: ${response.body}');
        }
      } catch (e) {
        print('Error sending face data: $e');
      }
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
      appBar: AppBar(
        title: Text('Camera Stream'),
      ),
      body: frameBase64 == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Image.memory(base64Decode(frameBase64!)),
                Expanded(
                  child: ListView.builder(
                    itemCount: detectedFaces.length,
                    itemBuilder: (context, index) {
                      final face = detectedFaces[index];
                      return ListTile(
                        leading: face.image != null
                            ? Image.memory(base64Decode(face.image!))
                            : null,
                        title: Text(face.name),
                      );
                    },
                  ),
                ),
              ],
            ),
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
