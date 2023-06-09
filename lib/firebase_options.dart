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
    apiKey: 'AIzaSyABlhVHGih92LswoQr9pCBfv-i5zjSKQss',
    appId: '1:1024167287227:android:92831f2ffd6d5162908c9e',
    messagingSenderId: '1024167287227',
    projectId: 'push-notifications-test-8ceb5',
    storageBucket: 'push-notifications-test-8ceb5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTJWBNqw-HxwocQWyttEvvVv4CKSn7bhg',
    appId: '1:1024167287227:ios:82db0e63813ee8d4908c9e',
    messagingSenderId: '1024167287227',
    projectId: 'push-notifications-test-8ceb5',
    storageBucket: 'push-notifications-test-8ceb5.appspot.com',
    androidClientId: '1024167287227-pogg7ffd33mont8a3gigfkf1mpu7rtvu.apps.googleusercontent.com',
    iosClientId: '1024167287227-u31v81lr69ggmk4dda21n7ks5pv6ilpi.apps.googleusercontent.com',
    iosBundleId: 'com.example.pushApp',
  );
}
