import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:get/get.dart';

class WebSocketConnection extends GetxController {
  WebSocketChannel? _channel;
  final currentFrame = Rx<Image?>(null);
  final detectedFaces = RxList<Map<String, dynamic>>([]);
  final isError = RxBool(false);
  final errorMessage = RxString('');
  String? _webSocketUrl;
  String? _authToken;
  Timer? _reconnectTimer;
  bool _isDisposed = false;

  Future<void> initialize(String webSocketUrl, String authToken) async {
    _webSocketUrl = webSocketUrl;
    _authToken = authToken;
    await _connectWebSocket();
  }

  Future<void> _connectWebSocket() async {
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
