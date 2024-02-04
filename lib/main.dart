
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:smart_home_project/bloc/temp_bloc/temp_bloc.dart';
import 'package:smart_home_project/ui/auth_screen/login_screen.dart';
import 'package:smart_home_project/ui/screens/TempRecord.dart';
import 'package:smart_home_project/ui/screens/led_control_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:smart_home_project/ui/screens/notification/display_notification.dart';
import 'package:smart_home_project/ui/screens/notification/notification_controller.dart';
import 'package:smart_home_project/ui/screens/welcome_screen.dart';

import 'bloc/switch_bloc.dart';
import 'data/appdata_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(
    null,
    [
     NotificationChannel(
       channelGroupKey: 'Temp_notification_group',
         channelKey: 'Temp_notification',
         channelName: 'Temp_notification',
         channelDescription: 'Temperature is Increased be alert',
       ledColor: Colors.red
     )
    ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: 'Temp_notification_group',
          channelGroupName: 'Temp Group ')
    ]);
  bool isAllowedToSendNotification= await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotification){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  // Always initialize Awesome Notifications
  // await NotificationController.initializeLocalNotifications();
  // await NotificationController.initializeIsolateReceivePort();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD8EatFFINeZp9cvoqcfVQsOD1KS2U9FYA",
      appId: "1:76628789109:android:1d48b11f0699248eb4f53c",

      projectId: "shahbaziotapp",
      messagingSenderId: '76628789109',
      databaseURL: "https://shahbaziotapp-default-rtdb.firebaseio.com/",

    ),
  );
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppDataProvider()),
          //ChangeNotifierProvider(create: (_) => CartProvider()),
        ],

        child: MyApp(),)
  );


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [

        BlocProvider<SwitchBloc>(
          create: (_) => SwitchBloc(),
        ),
        BlocProvider<TempBloc>(
          create: (_) => TempBloc(),
        ),
      ],
      child:  const MaterialApp(
        // home:  SwitchWidget(),
        home: WelcomeScreen(),
      ),
    );

  }
}

