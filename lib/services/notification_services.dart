// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:tasc/models/task.dart';
import 'package:tasc/screens/home/notified_page.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    _configureLocalTimezone();
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //         requestSoundPermission: false,
    //         requestBadgePermission: false,
    //         requestAlertPermission: false,
    //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
            // iOS: initializationSettingsIOS,
            android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high);
    // var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    //below after android : apcs , iOS: iOSPlatformChannelSpecifics
    var platformChannelSpecifics =
        new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

//   AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails('your channel id', 'your channel name',
//         channelDescription: 'your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker');
//  NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'plain title',
//       'plain body',
//       notificationDetails,
//       payload: 'Default_Sound'
//       );

  scheduledNotification(int hour, int minutes, Task task) async {
    // int newTime = minutes; dont need
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!.toInt(),
        task.title,
        task.note,
        _convertTime(hour, minutes),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: newTime)),//zonedschedula -- sec will take int only no variable
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|" + "${task.note}|");
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // tz.initializeTimeZones();
    // final String timezone = await FlutterNativeTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(timezone));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    if (payload == "Theme Changed") {
      print("Nothing to Navigate");
    } else {
      Get.to(() => NotifiedPage(label: payload));
    }
  }
  // Future selectNotification(String payload) async {
  //   if (payload != null) {
  //     print('notification payload: $payload');
  //   } else {
  //     print("Notification Done");
  //   }
  //   Get.to(() => Container(
  //         color: Colors.white,
  //       ));
  // }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
    Get.dialog(Text("Welcome to flutter"));
  }
}
