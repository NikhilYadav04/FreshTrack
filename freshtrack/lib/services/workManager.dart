
import 'package:flutter/material.dart';
import 'package:freshtrack/services/notificationService.dart';
import 'package:logger/logger.dart';
import 'package:workmanager/workmanager.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class WorkManager {
  static const taskName = "simple";
  static const notifyTask = "notify";

  static void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      switch (taskName) {
        case "simple":
          logger.d("Hii this background task EXEEEEEEEECUTED");
          Future.delayed(Duration(seconds: 5), () {
            debugPrint(
                "Task Excuted HIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
          });
          break;
        default:
          logger.d("Unknown background task: $taskName");
          debugPrint("Unknown background task: $taskName");
      }
      return Future.value(true);
    });
  }

  //* execute WorkManger Periodic Task
  static void executeTask() async {
    // final AndroidIntent intent = AndroidIntent(
    //   action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
    // );
    // await intent.launch();
    var uniqueID = DateTime.now().second.toString();
    await Workmanager().registerOneOffTask(uniqueID, taskName,
        initialDelay: Duration(seconds: 20),
        existingWorkPolicy: ExistingWorkPolicy.keep);
  }

  //* cancel all tasks
  static void cancelTask() async {
    await Workmanager().cancelAll();
  }

  //* notification logic for expiry items

  //* 1] Schedule the Workmanager Task
  static void scheduleNotifyExpiry(int minutes, String item) async {
    var uniqueID = DateTime.now().second.toString();
    Workmanager().registerOneOffTask(uniqueID, "notify",
        inputData: {"item": item}, initialDelay: Duration(minutes: minutes));
  }

  //* 2] Function to display notifications
  static void notifyExpiryTask(String item) async {
    Notificationservice.sendNotification(item);
  }
}
