import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  NotificationModel({
    required this.title,
    required this.body,
    required this.data,
    required this.timestamp,
  });

  // Convert NotificationModel to Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'data': data,
      'timestamp': timestamp,
    };
  }

  // Convert Map to NotificationModel
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      data: map['data'] ?? {},
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
