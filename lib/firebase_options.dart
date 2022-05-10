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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBYg_9ojsIWf1wSVDGMW0xPaPgzlIFgMOs',
    appId: '1:1086026774589:web:d3603932d2bd27277ad254',
    messagingSenderId: '1086026774589',
    projectId: 'flutter-chat-app-dc52c',
    authDomain: 'flutter-chat-app-dc52c.firebaseapp.com',
    storageBucket: 'flutter-chat-app-dc52c.appspot.com',
    measurementId: 'G-19VW3YSPTK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMqwMptXBP5YOhEfSXoPR1VixdK1Nn3H0',
    appId: '1:1086026774589:android:8454c3b04c9a7a117ad254',
    messagingSenderId: '1086026774589',
    projectId: 'flutter-chat-app-dc52c',
    storageBucket: 'flutter-chat-app-dc52c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCP3_OpaZqyI1ZlSEuMj-8BXVGN3TiYerg',
    appId: '1:1086026774589:ios:351c6a876fd8b9c97ad254',
    messagingSenderId: '1086026774589',
    projectId: 'flutter-chat-app-dc52c',
    storageBucket: 'flutter-chat-app-dc52c.appspot.com',
    iosClientId: '1086026774589-svj23s6hgqb76437fc81fkeem5kvmj4b.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutter-chat-app',
  );
}
