// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBG3b-cJRSscgEGxKQxH47bR1W0WuP8PZ4',
    appId: '1:968092830066:web:a7b138972d33ea8b6875eb',
    messagingSenderId: '968092830066',
    projectId: 'gas-detection-ebdf9',
    authDomain: 'gas-detection-ebdf9.firebaseapp.com',
    databaseURL: 'https://gas-detection-ebdf9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gas-detection-ebdf9.firebasestorage.app',
    measurementId: 'G-S90Z0YHJR9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBakZwPY_V5zyUe168iKWwqXw3t8pz0t9k',
    appId: '1:968092830066:android:9ff67d19358438056875eb',
    messagingSenderId: '968092830066',
    projectId: 'gas-detection-ebdf9',
    databaseURL: 'https://gas-detection-ebdf9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gas-detection-ebdf9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOLdSBwG55DwKw0x5RyfxzORoQe7YPqJI',
    appId: '1:968092830066:ios:20e6f81fb31fdbd76875eb',
    messagingSenderId: '968092830066',
    projectId: 'gas-detection-ebdf9',
    databaseURL: 'https://gas-detection-ebdf9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gas-detection-ebdf9.firebasestorage.app',
    iosBundleId: 'com.exarth.gasGuard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOLdSBwG55DwKw0x5RyfxzORoQe7YPqJI',
    appId: '1:968092830066:ios:20e6f81fb31fdbd76875eb',
    messagingSenderId: '968092830066',
    projectId: 'gas-detection-ebdf9',
    databaseURL: 'https://gas-detection-ebdf9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gas-detection-ebdf9.firebasestorage.app',
    iosBundleId: 'com.exarth.gasGuard',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBG3b-cJRSscgEGxKQxH47bR1W0WuP8PZ4',
    appId: '1:968092830066:web:a9f3e13ed8e6f0e06875eb',
    messagingSenderId: '968092830066',
    projectId: 'gas-detection-ebdf9',
    authDomain: 'gas-detection-ebdf9.firebaseapp.com',
    databaseURL: 'https://gas-detection-ebdf9-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'gas-detection-ebdf9.firebasestorage.app',
    measurementId: 'G-1KT4QN29SL',
  );
}
