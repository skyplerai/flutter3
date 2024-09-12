import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:get/get.dart';

class WebSocketController extends GetxController {
  WebSocketChannel? _channel;
  final currentFrame = Rx<Image?>(null);
  final detectedFaces = RxList<Map<String, dynamic>>([]);
  final isError = RxBool(false);
  final errorMessage = RxString('');
  String? _webSocketUrl;
  String? _authToken;
  Timer? _reconnectTimer;
  bool _isDisposed = false;

  void initialize(String webSocketUrl, String authToken) {
    _webSocketUrl = webSocketUrl;
    _authToken = authToken;
    _connectWebSocket();
  }

  void _connectWebSocket() {
    if (_isDisposed) return;
    final wsUrl = '$_webSocketUrl?token=$_authToken';
    print('Connecting WebSocket with URL: $wsUrl');
    try {
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      _channel!.stream.listen(
        _handleWebSocketMessage,
        onError: _handleWebSocketError,
        onDone: _handleWebSocketDone,
      );
      isError.value = false;
      errorMessage.value = '';
    } catch (e) {
      _handleWebSocketError(e);
    }
  }

  void _handleWebSocketMessage(dynamic message) {
    if (_isDisposed) return;
    try {
      final data = jsonDecode(message);
      if (data['frame'] != null) {
        currentFrame.value = Image.memory(
          base64Decode(data['frame']),
          gaplessPlayback: true,
        );
      }
      if (data['detected_faces'] != null) {
        detectedFaces.value = List<Map<String, dynamic>>.from(data['detected_faces']);
      }
      print('Received frame. Detected faces: ${detectedFaces.length}');
    } catch (e) {
      print('Error processing WebSocket message: $e');
    }
  }

  void _handleWebSocketError(dynamic error) {
    if (_isDisposed) return;
    print('WebSocket error: $error');
    isError.value = true;
    errorMessage.value = error.toString();
    _scheduleReconnect();
  }

  void _handleWebSocketDone() {
    if (_isDisposed) return;
    print('WebSocket connection closed.');
    isError.value = true;
    errorMessage.value = 'WebSocket connection closed.';
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_isDisposed) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(seconds: 5), _connectWebSocket);
  }

  void reconnect() {
    if (_isDisposed) return;
    _reconnectTimer?.cancel();
    _connectWebSocket();
  }

  @override
  void onClose() {
    _isDisposed = true;
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    super.onClose();
  }
}

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
  WebSocketController? _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = Get.put(WebSocketController(), tag: widget.webSocketUrl);
    _controller!.initialize(widget.webSocketUrl, widget.authToken);
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Obx(() => Container(
      width: double.infinity,
      height: 240,
      child: Center(
        child: _controller!.isError.value
            ? _buildErrorWidget()
            : _controller!.currentFrame.value != null
            ? _buildVideoWidget()
            : CircularProgressIndicator(),
      ),
    ));
  }

  Widget _buildErrorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Error: ${_controller!.errorMessage.value}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _controller!.reconnect,
          child: Text('Retry'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildVideoWidget() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _controller!.currentFrame.value!,
        ),
        ..._controller!.detectedFaces.map(_buildFaceDetectionBox).toList(),
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

  @override
  void dispose() {
    final controller = Get.find<WebSocketController>(tag: widget.webSocketUrl);
    controller.onClose();
    Get.delete<WebSocketController>(tag: widget.webSocketUrl);
    super.dispose();
  }
}