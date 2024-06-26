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
    apiKey: 'AIzaSyCObmHctQtBVel7qe5xSR3ow4MwpRJj_ng',
    appId: '1:296290464946:web:3cac8a3a22de26e34185ab',
    messagingSenderId: '296290464946',
    projectId: 'graduation-project-6d506',
    authDomain: 'graduation-project-6d506.firebaseapp.com',
    storageBucket: 'graduation-project-6d506.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXPCmNnep1NCIN_TIVUVLgqrRN22avhfE',
    appId: '1:296290464946:android:adaf32309c2617614185ab',
    messagingSenderId: '296290464946',
    projectId: 'graduation-project-6d506',
    storageBucket: 'graduation-project-6d506.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFmHdvYEara9Gsf47O_sJN1W3yeAbSca0',
    appId: '1:296290464946:ios:37b615c0950983d34185ab',
    messagingSenderId: '296290464946',
    projectId: 'graduation-project-6d506',
    storageBucket: 'graduation-project-6d506.appspot.com',
    iosBundleId: 'com.example.graduationProject2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFmHdvYEara9Gsf47O_sJN1W3yeAbSca0',
    appId: '1:296290464946:ios:37b615c0950983d34185ab',
    messagingSenderId: '296290464946',
    projectId: 'graduation-project-6d506',
    storageBucket: 'graduation-project-6d506.appspot.com',
    iosBundleId: 'com.example.graduationProject2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCObmHctQtBVel7qe5xSR3ow4MwpRJj_ng',
    appId: '1:296290464946:web:42ff9153ff8cf8da4185ab',
    messagingSenderId: '296290464946',
    projectId: 'graduation-project-6d506',
    authDomain: 'graduation-project-6d506.firebaseapp.com',
    storageBucket: 'graduation-project-6d506.appspot.com',
  );
}
