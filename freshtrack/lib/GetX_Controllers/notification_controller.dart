import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freshtrack/services/notificationService.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("j=hello it is started");
    setupFirebaseNotifications();
  }

  //* to handle notifications
  void setupFirebaseNotifications() {
    //* When the app is terminated and opened by clicking a notification
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    //* When the app is in the foreground
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          Notificationservice.createanddisplaynotification(message);
        }
      },
    );

    //* When the app is in the background and opened via notification
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          Notificationservice.createanddisplaynotification(message);
        }
      },
    );
  }

  //* handle navigation based on notification payload ID
  void handleNotificationNavigation(RemoteMessage message) {
    if (message.data['_id'] != null) {
      Get.toNamed('/demo', arguments: {"id": message.data['_id']});
    }
  }
}
