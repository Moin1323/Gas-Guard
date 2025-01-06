import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Lottie package for animations
import '../api/firebase_api.dart';

class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({super.key});

  @override
  _FetchDataScreenState createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {
  final DatabaseReference _dbRef =
  FirebaseDatabase.instance.ref(); // Reference to the root of the database

  String gasLevel = 'Loading...';
  bool isLeaking = false;

  final FirebaseApi _firebaseApi = FirebaseApi(); // Instance of FirebaseApi

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    // Fetch gas level
    _dbRef.child('sensor/gasLevel').onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        gasLevel = data.toString(); // Update the gas level
      });
    });

    // Fetch gas leakage status
    _dbRef.child('sensor/isLeaking').onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        isLeaking = data as bool; // Update the leakage status
      });

      // If gas is leaking, show notification with gas level
      if (isLeaking) {
        _firebaseApi.showNotification(
          title: 'Gas Leak Detected!',
          body: 'Gas Level: $gasLevel. Take precautions immediately!',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gas Detection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon tap
              _firebaseApi.showNotification(
                title: 'Notification',
                body: 'Tap for details',
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome Message
            const Text(
              'Welcome to the Gas Detection System',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Centered Lottie Animation based on leakage status
            isLeaking
                ? Lottie.asset('assets/lottie/gas_leak.json', width: 200)
                : Lottie.asset('assets/lottie/gas_safe.json', width: 200),

            const SizedBox(height: 30),

            // Display Gas Level
            Text(
              'Gas Sensor Level: $gasLevel',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            // Display Leakage Status with appropriate color
            Text(
              'Leakage Status: ${isLeaking ? "Leaking" : "Safe"}',
              style: TextStyle(
                fontSize: 18,
                color: isLeaking ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
