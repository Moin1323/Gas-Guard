import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Lottie package for animations
import '../api/firebase_api.dart';
import 'notifications.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // Welcome Message
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 24,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        NotificationScreen.route,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Centered Lottie Animation based on leakage status
              isLeaking
                  ? Icon(Icons.warning, color: Colors.red, size: 300)
                  : Icon(Icons.gas_meter, color: Colors.green, size: 300),

              const SizedBox(height: 30),

              // Display Gas Level
             SizedBox(
               child: Column(
                 children: [
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
             )
            ],
          ),
        ),
      ),
    );
  }
}
