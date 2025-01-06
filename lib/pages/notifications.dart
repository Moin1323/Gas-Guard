import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../models/notification.dart';
import '../services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static const route = '/notification-screen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationService _notificationService = NotificationService();
  List<NotificationModel> _notifications = [];

  @override
  void initState() {
    super.initState();

    // Listen for notifications from Firestore
    _notificationService.getNotifications().listen((notifications) {
      setState(() {
        _notifications = notifications ?? []; // Handle null notifications
      });
    });
  }

  /// Deletes all notifications (mark all as read)
  Future<void> _markAllAsRead() async {
    // Show a confirmation dialog before marking all as read
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mark All as Read'),
          content: const Text('Are you sure you want to mark all notifications as read?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel action
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm action
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    // If user confirmed, mark all as read
    if (confirm ?? false) {
      await _notificationService.deleteAllNotifications();
      setState(() {
        _notifications.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All notifications marked as read')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the message passed as an argument
    final RemoteMessage? message =
    ModalRoute.of(context)?.settings.arguments as RemoteMessage?;

    if (_notifications.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notification Screen'),
          actions: [
            IconButton(
              onPressed: null, // Disabled when no notifications exist
              icon: const Icon(Icons.done_all),
            ),
          ],
        ),
        body: const Center(
          child: Text('No notifications available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
        actions: [
          IconButton(
            onPressed: _notifications.isEmpty ? null : _markAllAsRead,
            icon: const Icon(Icons.done_all),
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: message == null
          ? _buildNotificationList()
          : _buildNotificationListWithNewMessage(message),
    );
  }

  /// Builds the notification list UI
  Widget _buildNotificationList() {
    return ListView.builder(
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  /// Builds the UI when a new message is received
  Widget _buildNotificationListWithNewMessage(RemoteMessage message) {
    final notification = NotificationModel(
      title: message.notification?.title ?? 'No Title',
      body: message.notification?.body ?? 'No Body',
      data: message.data,
      timestamp: DateTime.now(),
    );

    // Check if the notification is already saved
    final isNotificationAlreadySaved = _notifications.any(
          (existingNotification) =>
      existingNotification.title == notification.title &&
          existingNotification.body == notification.body,
    );

    // Save the notification if it's new
    if (!isNotificationAlreadySaved) {
      _notificationService.saveNotification(notification);
    }

    return _buildNotificationList();
  }

  /// Builds a single notification card
  Widget _buildNotificationCard(NotificationModel notification) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(
          Icons.notifications,
          color: Colors.blueAccent,
          size: 30,
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.body,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(notification.timestamp),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formats the timestamp to a readable format
  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
