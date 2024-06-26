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
class ProductionFirebaseOptions {
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
    apiKey: 'AIzaSyD57eWSKG4LT-J3TTMQwj2pml6M-i9LfnM',
    appId: '1:267337617674:android:c1cb6e6b9d321d16d16af3',
    messagingSenderId: '267337617674',
    projectId: 'expends-production',
    storageBucket: 'expends-production.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnA-LOBJv5ywnEjMwHBW0WZiGzzI8uI80',
    appId: '1:267337617674:ios:a980eb5880a88ae8d16af3',
    messagingSenderId: '267337617674',
    projectId: 'expends-production',
    storageBucket: 'expends-production.appspot.com',
    androidClientId:
        '267337617674-ubddsr6i0phi8mol6gr0rc93848t29r2.apps.googleusercontent.com',
    iosClientId:
        '267337617674-cs1i77c8d40l5rool6ogqdk4h9he3h2s.apps.googleusercontent.com',
    iosBundleId: 'com.example.expenseTrackerApp',
  );
}
