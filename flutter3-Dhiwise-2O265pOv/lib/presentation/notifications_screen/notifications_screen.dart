import 'dart:convert';

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
    final response = await ApiService().fetchNotificationLogs();
    if (response != null && response.results!.isNotEmpty) {
      setState(() {
        _notifications = response.results;
        _hasNewNotification = true; // New notification logic
      });
    }
    return response;
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
              _buildHeader(),
              SizedBox(height: 15),
              SizedBox(height: 10),
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
          child: Icon(Icons.notifications_active),
        )
            : null,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Notifications'),
      backgroundColor: Colors.orange,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Text(
        "Notifications",
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.bold,
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
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error loading notifications"));
        }

        if (_notifications == null || _notifications!.isEmpty) {
          return Center(child: Text("No notifications found"));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: _notifications!.length,
          itemBuilder: (context, index) {
            final notification = _notifications![index];
            return _buildNotificationTile(notification);
          },
        );
      },
    );
  }

  String formatDateAndIndianTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);

    // Add 5 hours to the time
    dateTime = dateTime.add(Duration(hours: 5));

    // Format date and Indian time
    String formattedOutput = DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);

    return formattedOutput;
  }


  Widget _buildNotificationTile(NotificationLog notification) {
    // Format the detected time
    final formattedTime = formatDateAndIndianTime(notification.detectedTime!);
    ;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: MemoryImage(base64Decode(notification.imageData ?? '')), // Default image if null or empty
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
        "Detected at ${notification.cameraName} on ${formattedTime}",
        style: TextStyle(color: Colors.grey[600]),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        // Navigate to a detail screen
      },
    );
  }
}
