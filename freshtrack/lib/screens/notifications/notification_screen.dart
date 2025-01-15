import 'package:flutter/material.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 3.792148*SizeConfig.heightMultiplier,
              )),
          centerTitle: true,
          backgroundColor: Colours.Green,
          elevation: 15,
          shadowColor: Colors.black,
          toolbarHeight: 8.9536831 * SizeConfig.heightMultiplier,
          title: Text(
            "Notifications",
            style: style.copyWith(
                fontSize: 3.686810 * SizeConfig.heightMultiplier,
                fontFamily: "Poppins",
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.6785*SizeConfig.widthMultiplier),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
