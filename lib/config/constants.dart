import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class ApiConstants {
  // static String HOST_URL = 'https://tnhapp-uat.thainakarin.co.th'; //uat
  static String HOST_URL = 'https://tnhapp.thainakarin.co.th'; //product
  static String API_VERSION = '/api';
  static String version =
      '20240405'; //version ที่ต้องปรับเพื่ออัพเดทแอพบน store
  static String versionName =
      '1.0.9'; //version บางบอกแอพเราเป็น version ไหนไว้แสดงบนแอพ
  static String deviceUpDateversion = '6';
  static String devicePlatform = Platform.isAndroid
      ? '1'
      : Platform.isIOS
          ? '2'
          : '3';

  static const optionNotiAndroid = FirebaseOptions(
    //setup noti android
    apiKey: 'AIzaSyB6W67VhkTMVIOqp5J_sEfcc0NSdrCt8Xs',
    appId: '1:383135115009:android:b31ea773e1b5ec5a445d00',
    messagingSenderId: '383135115009',
    projectId: 'app.tnh.health',
    storageBucket: 'tnh-application.appspot.com',
  );

  static const optionNotiIos = FirebaseOptions(
    //setup noti ios
    apiKey: 'AIzaSyCj61fwjge0fr3cFCRqjHZKApY_rJdvgAA',
    appId: '1:383135115009:ios:18a014bfb5e53ed6445d00',
    messagingSenderId: '383135115009',
    projectId: 'app.tnh.health',
    storageBucket: 'tnh-application.appspot.com',
  );
}
