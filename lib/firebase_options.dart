// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBwo_MXwZg_eU-VkLgshOjAqgaKleWzv5M',
    appId: '1:236504080573:web:11e937460abd9725b157d4',
    messagingSenderId: '236504080573',
    projectId: 'nebengk-bf210',
    authDomain: 'nebengk-bf210.firebaseapp.com',
    storageBucket: 'nebengk-bf210.appspot.com',
    measurementId: 'G-DYBTZ27QWM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrO8TrB1aN2D7nKUBleG0MwqMQBFmyj9o',
    appId: '1:236504080573:android:278e03828f66d3aab157d4',
    messagingSenderId: '236504080573',
    projectId: 'nebengk-bf210',
    storageBucket: 'nebengk-bf210.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbfCypcMemx6ByPt5pqabBR18ov0uz-CA',
    appId: '1:236504080573:ios:d45706a5bba47e09b157d4',
    messagingSenderId: '236504080573',
    projectId: 'nebengk-bf210',
    storageBucket: 'nebengk-bf210.appspot.com',
    iosBundleId: 'com.example.nebengk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbfCypcMemx6ByPt5pqabBR18ov0uz-CA',
    appId: '1:236504080573:ios:497c54e243a2b25db157d4',
    messagingSenderId: '236504080573',
    projectId: 'nebengk-bf210',
    storageBucket: 'nebengk-bf210.appspot.com',
    iosBundleId: 'com.example.nebengk.RunnerTests',
  );
}