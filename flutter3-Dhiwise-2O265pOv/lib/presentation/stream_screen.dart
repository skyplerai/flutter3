import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Services/websocket_connection.dart';
import '../widgets/video_player/video_player.dart'; // WebSocketVideoPlayer widget
import '../services/api_service.dart'; // Import the separated WebSocket connection widget

class CameraStreamScreen extends StatelessWidget {
  final String webSocketUrl;
  final String authToken;
  final ApiService apiService = ApiService();

  CameraStreamScreen({required this.webSocketUrl, required this.authToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera Stream')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: WebSocketVideoPlayer(
              webSocketUrl: webSocketUrl,
              authToken: authToken,
            ),
          ),
          Expanded(
            flex: 2,
            child: GetBuilder<WebSocketConnection>( // Changed to WebSocketConnection
              tag: webSocketUrl,
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.detectedFaces.length,
                  itemBuilder: (context, index) {
                    final face = controller.detectedFaces[index];
                    return ListTile(
                      title: Text(face['name'] ?? 'Unknown'),
                      subtitle: Text(face['time'] ?? ''),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _renameFace(face, controller),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _renameFace(Map<String, dynamic> face, WebSocketConnection controller) async { // Updated to WebSocketConnection
    final newName = await Get.dialog<String>(
      AlertDialog(
        title: Text('Rename Face'),
        content: TextField(
          decoration: InputDecoration(hintText: "Enter new name"),
          controller: TextEditingController(text: face['name']),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Rename'),
            onPressed: () => Get.back(result: Get.find<TextEditingController>().text),
          ),
        ],
      ),
    );

    if (newName != null && newName.isNotEmpty) {
      try {
        await apiService.renameFace(oldFaceId: face['face_id'], newFaceId: newName);
        // Update the face name in the controller
        final index = controller.detectedFaces.indexWhere((f) => f['id'] == face['id']);
        if (index != -1) {
          controller.detectedFaces[index]['name'] = newName;
          controller.detectedFaces.refresh();
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to rename face: $e');
      }
    }
  }
}
