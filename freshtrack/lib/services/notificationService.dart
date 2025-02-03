import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
}
