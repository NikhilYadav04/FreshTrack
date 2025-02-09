import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:http/http.dart' as http;

class Notificationservice {
  Notificationservice._();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //* initialize flutter local notifications plugin
  static void initialize() {
    //* Initialization settings for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print("onDidReceiveNotificationResponse");
        String? id = response.payload;
        if (id != null && id.isNotEmpty) {
          // print("Router Value1234 $id");

          // Navigate to a specific screen on notification tap
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => DemoScreen(
          //       id: id,
          //     ),
          //   ),
          // );
        }
      },
    );
  }

  //* to display notification popup
  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "freshtrack",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['_id'],
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static void createanddisplaynotificationLocally(
      String title, String body) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "freshtrack", "pushnotificationappchannel",
            importance: Importance.max,
            priority: Priority.high,
            // largeIcon: FilePathAndroidBitmap('assets/bell.png')
            largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher")),
      );

      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: "",
        //* default payload :- message.data['_id']
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    print(message.data.toString());
    print(message.notification!.title);
  }

  //* To Store FCM Tokens In Firestore Database
  static Future<void> storeFCMToken() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    final storeFCMToken = token.toString();
    final email = FirebaseAuth.instance.currentUser!.email!;

    if (token == null) return;

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("fcm");
    QuerySnapshot querySnapshot =
        await collectionReference.where("email", isEqualTo: email).get();

    if (querySnapshot.docs.isEmpty) {
      await collectionReference.add({
        "email": email,
        "ids": [storeFCMToken]
      });
    } else {
      final doc = querySnapshot.docs.first;
      await doc.reference.update({
        "ids": FieldValue.arrayUnion([storeFCMToken])
      });
    }
  }

  //* send notification
  static Future<void> sendNotification(String item) async {
    try {
      print("Notifications rvic started");
      final email = FirebaseAuth.instance.currentUser!.email!;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("fcm");

      // Fetch tokens for the current user's email
      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        print("No tokens found for email: $email");
        return;
      }

      final doc = querySnapshot.docs.first;
      List<dynamic> fcmTokens = await doc.get('ids');

      final url = Uri.parse(
          "https://fcm.googleapis.com/v1/projects/${keySecure.project_id}/messages:send");

      var headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${keySecure.server_key}"
      };

      for (int i = 0; i < fcmTokens.length; i++) {
        final token = fcmTokens[i];
        print(token);
        var body = {
          "message": {
            "token": "${token.toString()}",
            "notification": {
              "body": "Let's Make Some Dishes With ${item} !!",
              "title": "Hey, ${item} is about to get expired!"
            },
            "android": {
              "priority": "high",
              "notification": {"channel_id": "freshtrack"}
            }
          }
        };

        print("Notifications rvic ended");

        var response =
            await http.post(url, headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print("Notification sent to $token");
        } else {
          print(
              "Error sending notification to $token: ${response.statusCode}, ${response.body}");
        }
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }
}
