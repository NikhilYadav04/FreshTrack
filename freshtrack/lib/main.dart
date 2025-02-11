import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/firebase_options.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:freshtrack/helper/toastMessage.dart';
import 'package:freshtrack/services/workManager.dart';
import 'package:freshtrack/screens/home/Homescreen.dart';
import 'package:freshtrack/screens/main/main_screen.dart';
import 'package:freshtrack/services/notificationService.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding
      .ensureInitialized(); //* Ensure Flutter engine is initialized
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "simple":
        var logger = Logger();
        debugPrint("Item is  and is running in background");
        logger.d("Item is  and is running in background");
        break;
      case "notify":
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        Notificationservice.initialize();
        var logger = Logger();

        final prefs = await SharedPreferences.getInstance();
        int attempt = prefs.getInt('attempt') ?? 0;

        if (attempt == 2) {
          //* Reset attempt and cancel the task
          await prefs.setInt('attempt', 0);
          logger.d("Attempt after ending ${attempt}");
          await Workmanager().cancelByUniqueName('notify');
        } else {
          //* Send Notification
          
          Notificationservice.createanddisplaynotificationLocally(
              "Mango", "Let's make");
          await prefs.setInt('attempt', attempt + 1);
          logger.d("Attempt ${attempt}");
        }
        //! cannot run fcm cloud server function to send notification because of free plan
        break;
      default:
        logger.d("Unknown background task: $task");
        debugPrint("Unknown background task: $task");
    }
    return Future.value(true);
  });
}

// await Hive.openBox('tasks');
// final _myBox = Hive.box('tasks');

// int attempt = _myBox.get('attempt', defaultValue: 0);

// if (attempt == 2) {
//   //* Reset attempt and cancel the task
//   _myBox.put('attempt', 0);
//   await Workmanager().cancelByUniqueName('notify');
// } else {
//   //* Send Notification
//   Notificationservice.createanddisplaynotificationLocally(
//       "Mango", "Lets make");
//   _myBox.put('attempt', attempt + 1);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* Initialize hive
  await Hive.initFlutter();

  //* Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //* Initialize Workmanager in background
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  //* Notification Service Initialize
  FirebaseMessaging.onBackgroundMessage(Notificationservice.backgroundHandler);
  Notificationservice.initialize();

  // ignore: deprecated_member_use
  CloudinaryContext.cloudinary =
      await Cloudinary.fromCloudName(cloudName: keySecure.cloudinary_name);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final authStatus = AuthStatus();

      SizeConfig().init(constraints);
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fresh Track',
        home: FutureBuilder(
          future: authStatus.checkStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colours.Green,
                child: Image.asset("assets/icon.png"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              final status = snapshot.data.toString();
              if (status == 'Login') {
                return MainScreen();
              } else {
                keySecure.getKey();
                return HomeScreen();
              }
            } else {
              toastMessage(context, "Error!", "${snapshot.error.toString()}",
                  ToastificationType.error);
              return SizedBox.shrink();
            }
          },
        ),
      );
    });
  }
}
