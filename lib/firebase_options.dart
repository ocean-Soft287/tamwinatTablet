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
    apiKey: 'AIzaSyCYmn-akpAgdwRTvald49d9iEWu82FQcn4',
    appId: '1:208221222611:android:0a9a0933abeba1c1ef4626',
    messagingSenderId: '208221222611',
    projectId: 'onesysteamapp',
    storageBucket: 'onesysteamapp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkAH-9l2JUoemnr6pyWkj_tb1VFQC3b2Q',
    appId: '1:208221222611:ios:6a61cd0ac63ff3d2ef4626',
    messagingSenderId: '208221222611',
    projectId: 'onesysteamapp',
    storageBucket: 'onesysteamapp.firebasestorage.app',
    androidClientId: '208221222611-a1q1697rrh6ssvtso06p9glvlsmkf9hb.apps.googleusercontent.com',
    iosClientId: '208221222611-pkqdqnhkqfkottvkvq9vl0kue3k9clch.apps.googleusercontent.com',
    iosBundleId: 'com.example.tamwenatTablet',
  );

}