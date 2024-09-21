import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Services/api_service.dart';
import '../../model/notification_logs.dart'; // Notification log model

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Future<NotificationLogResponse?> _notificationsFuture;
  List<NotificationLog>? _notifications = [];
  bool _hasNewNotification = false;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = _fetchNotifications();
  }

  Future<NotificationLogResponse?> _fetchNotifications() async {
    // Fetch notifications from API
    final response = await ApiService().fetchNotificationLogs();
    if (response != null && response.results!.isNotEmpty) {
      setState(() {
        _notifications = response.results;
        _hasNewNotification = true; // Mark new notification as received
      });
    }
    return response;
  }

  void _showNewNotificationSnackbar(NotificationLog log) {
    final snackBar = SnackBar(
      content: Text(
        "New face detected: ${log.faceId} at ${log.cameraName}",
        style: const TextStyle(fontSize: 16, color: Colors.white),

      ),
      action: SnackBarAction(
        label: 'View',
        textColor: Colors.orange,
        onPressed: () {
          // Handle action on viewing detailed notification
          print(log.image);
        },
      ),
      backgroundColor: Colors.grey[800],
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 15),
              Expanded(child: _buildNotificationList()),
            ],
          ),
        ),
        floatingActionButton: _hasNewNotification
            ? FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            _showNewNotificationSnackbar(_notifications!.last);
          },
          child: const Icon(Icons.notifications_active),
        )
            : null,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Notifications'),
      backgroundColor: Colors.orange,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 12.0),
      child: Text(
        "Notifications",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    return FutureBuilder<NotificationLogResponse?>(
      future: _notificationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading notifications"));
        }
        if (_notifications == null || _notifications!.isEmpty) {
          return const Center(child: Text("No notifications found"));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: _notifications!.length,
          itemBuilder: (context, index) {
            final notification = _notifications![index];
            return _buildNotificationTile(notification);
          },
        );
      },
    );
  }

  // Format detected timestamp
  String _formatDateAndTime(String timestamp) {
    // Define input and output formats
    DateFormat inputFormat = DateFormat('hh:mm a, yyyy-MM-dd');
    DateFormat outputFormat = DateFormat('yyyy-MM-dd hh:mm:ss a');

    try {
      DateTime dateTime = inputFormat.parse(timestamp); // Parse input
      return outputFormat.format(dateTime); // Return formatted date
    } catch (e) {
      print('Error parsing date: $e');
      return 'Invalid date';
    }
  }

  Widget _buildNotificationTile(NotificationLog notification) {
    final formattedTime = _formatDateAndTime(notification.detectedTime!);

    Uint8List? imageData;
    if (notification.image != null && notification.image!.isNotEmpty) {
      try {
        // Trim any whitespace and remove any potential line breaks
        String cleanedBase64 = notification.image!.trim().replaceAll(RegExp(r'\s+'), '');
        imageData = base64Decode(cleanedBase64);
      } catch (e) {
        print('Error decoding base64 image: $e');
        imageData = null;
      }
    }

    return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        leading: CircleAvatar(
          radius: 35,
          backgroundColor: Colors.transparent,
          backgroundImage: imageData != null
              ? MemoryImage(imageData)
              : const AssetImage('assets/images/logo.png') as ImageProvider,
        ),
        title: Text(
          "Face detected: ${notification.faceId}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        subtitle: Text(
          "Detected at ${notification.cameraName} on $formattedTime",
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Handle on tap
          },
        );
   }
}