import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Assuming this file exists, containing notification handling methods
import 'notification_controller.dart';

class DisplayNotification extends StatefulWidget {
  const DisplayNotification({Key? key});

  @override
  State<DisplayNotification> createState() => _DisplayNotificationState();
}

class _DisplayNotificationState extends State<DisplayNotification> {
  final DatabaseReference _temperatureValue =
  FirebaseDatabase.instance.reference().child('UsersData');

  @override
  void initState() {
    super.initState();

    // Set up notification listeners
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationDisplayedMethod:
      NotificationController.onNotificationDisplayMethod,
      onNotificationCreatedMethod:
      NotificationController.onNotificationCreatedMethod,
      onDismissActionReceivedMethod:
      NotificationController.onDismissActionReceiverMethod,
    );

    // Listen for temperature changes
    _temperatureValue.onValue.listen((event) {
      final temperature = event.snapshot.value;
      print('Received temperature: $temperature');

      if (temperature != null && temperature is double && temperature > 45.0) {
        _createNotification();
      }

    }, onError: (error) {
      // Handle Firebase errors
      print('Firebase error: $error');
    });
  }

  Future<void> _createNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        // id: 1,
        // channelKey: 'Temp_notification',
        // title: "Temperature Increased",
        // body: "Temperature is too high!",
        // notificationLayout: NotificationLayout.BigText, // Optional

        // Add more notification details as needed
        id: 1,
        channelKey: 'Temp_notification',  // Check if this matches your channel key
          // Check if this matches your group key
        title: "Temperature Increased",
        body: "Temperature is too high!",
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Replace with your UI elements
      body: Center(
        child:
        IconButton(
        icon: Icon(Icons.notification_add), // Replace with the desired icon
    onPressed: () {
    _createNotification();
    },
      ),
    ));
  }
}
