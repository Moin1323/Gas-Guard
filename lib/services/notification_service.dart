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
      return snapshot.docs
          .map((doc) => NotificationModel.fromMap(doc.data()))
          .toList();
    });
  }
}
