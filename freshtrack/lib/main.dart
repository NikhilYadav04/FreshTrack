import 'package:flutter/material.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:freshtrack/helper/toastMessage.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/screens/home/homeScreen.dart';
import 'package:freshtrack/screens/main/main_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:toastification/toastification.dart';

void main() async {
  //* Initialize hive
  await Hive.initFlutter();
  await WidgetsFlutterBinding.ensureInitialized();

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
              return Center(
                child: CircularProgressIndicator(color: Colours.Green),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              final status = snapshot.data.toString();
              if (status == 'Login') {
                keySecure.getKey();
                Get.to(() => MainScreen(), transition: Transition.fadeIn);
              } else {
                keySecure.getKey();
                Get.to(() => LoginScreen(), transition: Transition.fadeIn);
              }
              return SizedBox.shrink();
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
