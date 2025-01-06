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
        _notifications = notifications ?? [];  // Handle null notifications
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the message passed as an argument
    final RemoteMessage? message = ModalRoute.of(context)?.settings.arguments as RemoteMessage?;

    // If there are no notifications
    if (_notifications.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notification Screen'),
        ),
        body: Center(
          child: Text('No notifications available'), // If no notifications exist
        ),
      );
    }

    // If no message is passed but notifications exist
    if (message == null && _notifications.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notification Screen'),
        ),
        body: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: Text(notification.timestamp.toString()),
            );
          },
        ),
      );
    }

    // If a new message is passed
    if (message != null && _notifications.isNotEmpty) {
      // Create a NotificationModel from the RemoteMessage
      final notification = NotificationModel(
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
        data: message.data,
        timestamp: DateTime.now(),
      );

      // Check if the notification has already been saved by matching unique data (e.g., title, body, or custom id)
      bool isNotificationAlreadySaved = _notifications.any(
            (existingNotification) =>
        existingNotification.title == notification.title &&
            existingNotification.body == notification.body,
      );

      // Save the notification to Firestore only if it hasn't been saved before
      if (!isNotificationAlreadySaved) {
        _notificationService.saveNotification(notification);
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Notification Screen'),
        ),
        body: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: Text(notification.timestamp.toString()),
            );
          },
        ),
      );
    }

    // Default return in case of any other unhandled condition (shouldn't normally reach here)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
      ),
      body: Center(
        child: Text('Unexpected state'),  // Handle any unexpected state
      ),
    );
  }
}
