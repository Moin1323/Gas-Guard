import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gas_guard/pages/fetch_data.dart';
import 'package:gas_guard/pages/home.dart';
import 'package:gas_guard/pages/notifications.dart';
import 'api/firebase_api.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseApi = FirebaseApi();
  await firebaseApi.initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FetchDataScreen(),
      navigatorKey: navigatorKey,
      routes: {
        NotificationScreen.route: (context) => const NotificationScreen(),
      },
    );
  }
}
