import 'package:flutter/material.dart';
import 'package:freshtrack/screens/home/homeScreen.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {

  //* Initialize hive
  await Hive.initFlutter();
  await WidgetsFlutterBinding.ensureInitialized();

  
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
        home: HomeScreen(),
      );
    });
  }
}
