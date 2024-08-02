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
    apiKey: 'AIzaSyA9f6vSTIQaD6J3sqRqWKjo5i1Ij3uokyA',
    appId: '1:187311427180:web:d6f65df380c6064ce5d249',
    messagingSenderId: '187311427180',
    projectId: 'my-real-estate-app-f5148',
    authDomain: 'my-real-estate-app-f5148.firebaseapp.com',
    storageBucket: 'my-real-estate-app-f5148.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjEgrN9c5FN3U_t8rJdsaD6uSppSM95C4',
    appId: '1:187311427180:android:e0e0c030919dd2cce5d249',
    messagingSenderId: '187311427180',
    projectId: 'my-real-estate-app-f5148',
    storageBucket: 'my-real-estate-app-f5148.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUJxOKvdMQMdRPCV6Dx35_JPodmdWGKdY',
    appId: '1:187311427180:ios:f61e06f64d473600e5d249',
    messagingSenderId: '187311427180',
    projectId: 'my-real-estate-app-f5148',
    storageBucket: 'my-real-estate-app-f5148.appspot.com',
    androidClientId: '187311427180-2r93m7vi9ptesqiaelgc44jlnmni6fok.apps.googleusercontent.com',
    iosClientId: '187311427180-7cn44d3k665rme0vqs1bhebv7sq5pv6h.apps.googleusercontent.com',
    iosBundleId: 'com.example.appRealEstate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUJxOKvdMQMdRPCV6Dx35_JPodmdWGKdY',
    appId: '1:187311427180:ios:f61e06f64d473600e5d249',
    messagingSenderId: '187311427180',
    projectId: 'my-real-estate-app-f5148',
    storageBucket: 'my-real-estate-app-f5148.appspot.com',
    androidClientId: '187311427180-2r93m7vi9ptesqiaelgc44jlnmni6fok.apps.googleusercontent.com',
    iosClientId: '187311427180-7cn44d3k665rme0vqs1bhebv7sq5pv6h.apps.googleusercontent.com',
    iosBundleId: 'com.example.appRealEstate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA9f6vSTIQaD6J3sqRqWKjo5i1Ij3uokyA',
    appId: '1:187311427180:web:0ad8ee079d31893fe5d249',
    messagingSenderId: '187311427180',
    projectId: 'my-real-estate-app-f5148',
    authDomain: 'my-real-estate-app-f5148.firebaseapp.com',
    storageBucket: 'my-real-estate-app-f5148.appspot.com',
  );
}
