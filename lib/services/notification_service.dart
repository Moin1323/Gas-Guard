import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notification.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save notification to Firestore
  Future<void> saveNotification(NotificationModel notification) async {
    try {
      await _firestore.collection('notifications').add(notification.toMap());
    } catch (e) {
      print('Error saving notification: $e');
    }
  }

  // Get notifications from Firestore
  Stream<List<NotificationModel>> getNotifications() {
    return _firestore
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // Convert Firestore data to NotificationModel
        return NotificationModel.fromMap(doc.data());
      }).toList();
    });
  }

  // Bulk delete all notifications from Firestore
  Future<void> deleteAllNotifications() async {
    try {
      final batch = _firestore.batch();
      final notifications = await _firestore.collection('notifications').get();

      for (var doc in notifications.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      print('Error deleting notifications: $e');
    }
  }
}
