import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/websocket_connection.dart'; // Import the new WebSocketConnection widget

class WebSocketVideoPlayer extends StatefulWidget {
  final String webSocketUrl;
  final String authToken;

  const WebSocketVideoPlayer({
    Key? key,
    required this.webSocketUrl,
    required this.authToken,
  }) : super(key: key);

  @override
  _WebSocketVideoPlayerState createState() => _WebSocketVideoPlayerState();
}

class _WebSocketVideoPlayerState extends State<WebSocketVideoPlayer> {
  WebSocketConnection? _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = Get.put(
      WebSocketConnection(),
      tag: widget.webSocketUrl,
      permanent: true,
    );
    _controller?.initialize(widget.webSocketUrl, widget.authToken);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = _controller;
      if (controller == null) {
        return Center(child: CircularProgressIndicator());
      }
      return Container(
        width: double.infinity,
        height: 240,
        child: Center(
          child: controller.isError.value
              ? _buildErrorWidget(controller)
              : controller.currentFrame.value != null
              ? _buildVideoWidget(controller)
              : CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget _buildErrorWidget(WebSocketConnection controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Error: ${controller.errorMessage.value}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: controller.reconnect,
          child: Text('Retry'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildVideoWidget(WebSocketConnection controller) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: controller.currentFrame.value!,
        ),
        ...controller.detectedFaces.map(_buildFaceDetectionBox).toList(),
      ],
    );
  }

  Widget _buildFaceDetectionBox(Map<String, dynamic> face) {
    return Positioned(
      left: face['coordinates']?['left']?.toDouble() ?? 0,
      top: face['coordinates']?['top']?.toDouble() ?? 0,
      child: Container(
        width: ((face['coordinates']?['right'] ?? 0) - (face['coordinates']?['left'] ?? 0)).toDouble(),
        height: ((face['coordinates']?['bottom'] ?? 0) - (face['coordinates']?['top'] ?? 0)).toDouble(),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Text(face['name'] ?? '', style: TextStyle(color: Colors.red)),
      ),
    );
  }
}
