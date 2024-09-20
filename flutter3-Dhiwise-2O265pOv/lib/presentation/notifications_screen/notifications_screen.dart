import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../model/notification_logs.dart'; // Assuming this model still exists

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationLog> _notifications = [];
  bool _hasNewNotification = false;
  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://your-websocket-server-url/ws/camera/<stream_id>/'),
    );

    _channel.stream.listen((message) {
      _handleRealTimeNotification(message);
    }, onError: (error) {
      print('WebSocket error: $error');
    }, onDone: () {
      print('WebSocket connection closed');
    });
  }

  void _handleRealTimeNotification(String message) {
    final data = jsonDecode(message);
    final newNotification = NotificationLog(
      faceId: data['face_id'],
      cameraName: data['camera_name'],
      detectedTime: data['detected_time'],
      imageData: data['image_data'],
    );

    setState(() {
      _notifications.insert(0, newNotification); // Add to the beginning of the list
      _hasNewNotification = true;
    });

    _showNewNotificationSnackbar(newNotification);
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void _showNewNotificationSnackbar(NotificationLog log) {
    final snackBar = SnackBar(
      content: Text(
        "New face detected: ${log.faceId} in ${log.cameraName}",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      action: SnackBarAction(
        label: 'View',
        textColor: Colors.orange,
        onPressed: () {
          // Navigate to database or details screen
        },
      ),
      backgroundColor: Colors.grey[800],
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Expanded(child: _buildNotificationList()),
            ],
          ),
        ),
        floatingActionButton: _hasNewNotification
            ? FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            _showNewNotificationSnackbar(_notifications.first);
          },
          child: Icon(Icons.notifications_active),
        )
            : null,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Notifications', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }



  Widget _buildNotificationList() {
    return _notifications.isEmpty
        ? Center(child: Text("No notifications yet"))
        : ListView.builder(
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        return _buildNotificationTile(_notifications[index]);
      },
    );
  }

  String formatDateAndIndianTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    dateTime = dateTime.add(Duration(hours: 5, minutes: 30)); // IST is UTC+5:30
    return DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
  }

  Widget _buildNotificationTile(NotificationLog notification) {
    final formattedTime = formatDateAndIndianTime(notification.detectedTime!);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: MemoryImage(base64Decode(notification.imageData ?? '')),
      ),
      title: Text(
        "Face detected: ${notification.faceId}",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      ),
      subtitle: Text(
        "Detected at ${notification.cameraName} on $formattedTime",
        style: TextStyle(color: Colors.grey[600]),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        // Navigate to a detail screen
      },
    );
  }
}