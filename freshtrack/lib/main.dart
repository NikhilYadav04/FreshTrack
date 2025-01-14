import 'package:flutter/material.dart';
import 'package:freshtrack/screens/home/homeScreen.dart';
import 'package:freshtrack/screens/main/main_screen.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      SizeConfig().init(constraints);
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fresh Track',
        home: MainScreen(),
      );
    });
  }
}
