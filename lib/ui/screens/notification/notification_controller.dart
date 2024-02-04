import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../TempRecord.dart';

class NotificationController{

@pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod (
    ReceivedNotification receivedNotification) async{

}
@pragma('vm:entry-point')
static Future<void> onNotificationDisplayMethod (
    ReceivedNotification receivedNotification) async{

}
@pragma('vm:entry-point')
static Future<void> onDismissActionReceiverMethod (
    ReceivedNotification receivedNotification) async{
  Navigator.push(
    context as BuildContext,
    MaterialPageRoute(
      builder: (context) => const TemperatureView(),
    ),
  );
}


@pragma('vm:entry-point')
static Future<void> onActionReceivedMethod (
    ReceivedNotification receivedNotification) async{



}

}