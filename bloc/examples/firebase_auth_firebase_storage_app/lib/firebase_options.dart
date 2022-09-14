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
    apiKey: 'AIzaSyAMVLAp0hS0qD4o3U2XuUTGqhrwHkHY6XQ',
    appId: '1:435429712718:web:a1560427d99891784cf41f',
    messagingSenderId: '435429712718',
    projectId: 'bloc-photo-library-sky',
    authDomain: 'bloc-photo-library-sky.firebaseapp.com',
    storageBucket: 'bloc-photo-library-sky.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPysFjcF2cYZrkcI-2qjPoVdAWBcJxG5w',
    appId: '1:435429712718:android:909a484f66e023614cf41f',
    messagingSenderId: '435429712718',
    projectId: 'bloc-photo-library-sky',
    storageBucket: 'bloc-photo-library-sky.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC21e5kC5VIWNd-jQXUXSWtQijuVOe8kyM',
    appId: '1:435429712718:ios:9e24591c0d81cc014cf41f',
    messagingSenderId: '435429712718',
    projectId: 'bloc-photo-library-sky',
    storageBucket: 'bloc-photo-library-sky.appspot.com',
    iosClientId: '435429712718-fiv6kq7n4or2jvpi1nnliof5e4qgm178.apps.googleusercontent.com',
    iosBundleId: 'sky.sky.firebaseAuthFirebaseStorageApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC21e5kC5VIWNd-jQXUXSWtQijuVOe8kyM',
    appId: '1:435429712718:ios:9e24591c0d81cc014cf41f',
    messagingSenderId: '435429712718',
    projectId: 'bloc-photo-library-sky',
    storageBucket: 'bloc-photo-library-sky.appspot.com',
    iosClientId: '435429712718-fiv6kq7n4or2jvpi1nnliof5e4qgm178.apps.googleusercontent.com',
    iosBundleId: 'sky.sky.firebaseAuthFirebaseStorageApp',
  );
}