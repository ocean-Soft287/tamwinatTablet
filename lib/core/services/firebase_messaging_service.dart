import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:search_appp/core/network/Dio/cash_helper.dart';
import 'package:search_appp/core/routes/naviation_service.dart';
import 'package:search_appp/core/routes/routes.dart';
import 'package:search_appp/core/services/flutter_local_notification.dart';
import 'package:search_appp/features/PrintOrders/Data/datasource/remote.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._internal();

  static final FirebaseMessagingService _instance = FirebaseMessagingService._internal();

  factory FirebaseMessagingService.instance() => _instance;

  NotificationsService? _localNotificationsService;

  Future<void> init({required NotificationsService localNotificationsService}) async {
    _localNotificationsService = localNotificationsService;

    await Firebase.initializeApp(); // Important!

    await _requestPermission();
    await _handlePushNotificationsToken();


    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   /// handle notification when app is in foreground
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
   /// handle notification when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
   
    /// handle notification when app is in Terminated state
     FirebaseMessaging.instance.getInitialMessage().then((initialMessage) {

  if (initialMessage != null) {
       NavigationService.pushNamed(
     Routes.getAllNoPrintOrderScreen
    );
    
    Fluttertoast.showToast(msg: "dddddd");


    }
    });
  

    _listenForTokenRefresh();
  }

  Future<void> _handlePushNotificationsToken() async {
    String? token;
    if (Platform.isIOS) {
      token = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      token = await FirebaseMessaging.instance.getToken();
    }

    if (token == null) {
      debugPrint('Failed to get FCM/APN token');
      return;
    }

   
      PrintOrdersRemoteDataSource remoteDataSource = PrintOrdersRemoteDataSourceImpl();
      final res = await remoteDataSource.addToken(id: token);
                  await  CacheHelper.saveData( key: 'notification_route',value:  Routes.getAllNoPrintOrderScreen);
      res.fold(
        (l) => debugPrint('Error adding token: $l'),
        (r) => debugPrint('Token added successfully: $r'),
      );
   
   
    // final checkCashedToken = await CacheHelper.getData(key: 'token');
    // if (checkCashedToken == null) {
    //   PrintOrdersRemoteDataSource remoteDataSource = PrintOrdersRemoteDataSourceImpl();
    //   final res = await remoteDataSource.addToken(id: token);
    //               await  CacheHelper.saveData( key: 'notification_route',value:  Routes.getAllNoPrintOrderScreen);
    //   res.fold(
    //     (l) => debugPrint('Error adding token: $l'),
    //     (r) => debugPrint('Token added successfully: $r'),
    //   );
   
    // }
    //  else {
    //   debugPrint('Token is already sent and cached: $checkCashedToken');
    // }
  }

  void _listenForTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      debugPrint('FCM token refreshed: $fcmToken');
      // Optionally re-upload token
    }).onError((error) {
      debugPrint('Error refreshing FCM token: $error');
    });
  }

  Future<void> _requestPermission() async {
    final result = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('User granted permission: ${result.authorizationStatus}');
  }

  void _onForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message received: ${message.data.toString()}');
    final notificationData = message.notification;
    if (notificationData != null) {
      _localNotificationsService?.showNotification(
        notificationData.title,
        notificationData.body,
        message.data.toString(),
      );
    
    }
  }

  void _onMessageOpenedApp(RemoteMessage message) async{
   
  // final cashroute = await CacheHelper.getData(key: 'notification_route');
  // if(cashroute != null){
  //  NavigationService.pushNamed(cashroute);
    
  // }
     NavigationService.pushNamed(Routes.getAllNoPrintOrderScreen);

    debugPrint('Notification caused the app to open: ${message.data.toString()}');
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   
  // final cashroute = await CacheHelper.getData(key: 'notification_route');
  // if(cashroute != null){
  //  NavigationService.pushNamed(cashroute);
    
  // }
      NavigationService.pushNamed(Routes.getAllNoPrintOrderScreen);

  log('Background message received: ${message.data.toString()}');

}