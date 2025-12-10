// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
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
    apiKey: 'AIzaSyCLoFdqapvOmD7PAX3tu8lF4Ut5skTIa6U',
    appId: '1:957157113170:web:10d875c69d548cae1f0e8b',
    messagingSenderId: '957157113170',
    projectId: 'portal-berita-db-a48af',
    authDomain: 'portal-berita-db-a48af.firebaseapp.com',
    storageBucket: 'portal-berita-db-a48af.firebasestorage.app',
    measurementId: 'G-S3FTNCV6DV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLoFdqapvOmD7PAX3tu8lF4Ut5skTIa6U',
    appId: '1:957157113170:web:10d875c69d548cae1f0e8b',
    messagingSenderId: '957157113170',
    projectId: 'portal-berita-db-a48af',
    authDomain: 'portal-berita-db-a48af.firebaseapp.com',
    storageBucket: 'portal-berita-db-a48af.firebasestorage.app',
    measurementId: 'G-S3FTNCV6DV',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLoFdqapvOmD7PAX3tu8lF4Ut5skTIa6U',
    appId: '1:957157113170:web:10d875c69d548cae1f0e8b',
    messagingSenderId: '957157113170',
    projectId: 'portal-berita-db-a48af',
    authDomain: 'portal-berita-db-a48af.firebaseapp.com',
    storageBucket: 'portal-berita-db-a48af.firebasestorage.app',
    measurementId: 'G-S3FTNCV6DV',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLoFdqapvOmD7PAX3tu8lF4Ut5skTIa6U',
    appId: '1:957157113170:web:10d875c69d548cae1f0e8b',
    messagingSenderId: '957157113170',
    projectId: 'portal-berita-db-a48af',
    authDomain: 'portal-berita-db-a48af.firebaseapp.com',
    storageBucket: 'portal-berita-db-a48af.firebasestorage.app',
    measurementId: 'G-S3FTNCV6DV',
  );
}
