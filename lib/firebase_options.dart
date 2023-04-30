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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxz7K0Dp0vLRwV9-ccxAGtqpQ-VwEBIU4',
    appId: '1:657885635020:android:bc2163e4f8e0884b10fd69',
    messagingSenderId: '657885635020',
    projectId: 'quran-app-f455e',
    storageBucket: 'quran-app-f455e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9NJh-NlwbB_X5piagKDhJDJ5NlDyKBFg',
    appId: '1:657885635020:ios:40198f772c755c9310fd69',
    messagingSenderId: '657885635020',
    projectId: 'quran-app-f455e',
    storageBucket: 'quran-app-f455e.appspot.com',
    androidClientId: '657885635020-p3p2nr1l6bj92p02nuroj1cqj6jb9gg8.apps.googleusercontent.com',
    iosClientId: '657885635020-p2fl9fpvt4sin5ipfjji06c0tp1dtggv.apps.googleusercontent.com',
    iosBundleId: 'com.example.quranAppCleanArchitecture',
  );
}