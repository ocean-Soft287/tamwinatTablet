import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:search_appp/core/network/Dio/dio_consumer.dart';
import 'package:search_appp/core/routes/naviation_service.dart';
import 'package:search_appp/core/routes/routes.dart';

class NotificationsService {
static final  awesomeNotifications = AwesomeNotifications();

  Future<void> showNotification(String? title, String? body, String? payload) async {
    final id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        payload: payload != null ? {'data': payload} : null,
        notificationLayout: payload != null ? NotificationLayout.Default : NotificationLayout.Inbox,
      ),
    );
     await startListeningNotificationEvents();

  }

  static ReceivePort? receivePort;
  static Future<void> init() async {

    await awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelKey: "basic_channel",
          channelName: 'Offers',
          channelDescription: "Offers For Users",
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          channelShowBadge: false,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
          onlyAlertOnce: true,
        )
      ],
      debug: true,
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel',
          channelGroupName: 'Category tests',
        )
      ],
    );
  }


static Future<void> startListeningNotificationEvents() async {
    debugPrint("check data with start listing");
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      // For background actions, you must hold the execution until the end

      debugPrint(
          'Message sent via notification input: "${receivedAction.buttonKeyInput}"');
      // await executeLongTaskInBackground();
   
    } else {

      // this process is only necessary when you need to redirect the user
      if (receivePort == null) {
        debugPrint(
            'onActionReceivedMethod was called inside a parallel dart isolate.');
        SendPort? sendPort =
            IsolateNameServer.lookupPortByName('notification_action_port');

        if (sendPort != null) {
          debugPrint('Redirecting the execution to main isolate process.');
          sendPort.send(receivedAction);
          return;
        }
      }
                NavigationService.pushNamed(Routes.getAllNoPrintOrderScreen);

      debugPrint("check data with receivedAction 3${receivedAction.buttonKeyInput}");

      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.title == "عرض الطلبات غير المطبوعة") {
      log("check data with receivedAction sssss${receivedAction.title}");
       NavigationService.pushNamed(Routes.getAllNoPrintOrderScreen);
    }
  
  }

  static Future<void> executeLongTaskInBackground() async {
    debugPrint("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    String url = "http://google.com";
    final re = await DioConsumer( dio:Dio ()).get(  url);
    debugPrint(re.data.toString());
    debugPrint("long task done");
  }

}