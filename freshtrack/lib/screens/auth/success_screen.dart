import 'package:flutter/material.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/images.dart';
import 'package:freshtrack/widgets/auth_widgets.dart';

import '../../styling/sizeConfig.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 2.8* SizeConfig.widthMultiplier),
          child: Column(
            children: [
              SizedBox(height: 100,),
              Center(
                  child: Image.asset(
                Images.Icon,
                height: 250,
                width: 250,
              )),
              Text(
                "Success!!",
                style: style.copyWith(
                    color: Colours.Green,
                    fontSize: 6 * SizeConfig.heightMultiplier),
              ),
              SizedBox(height: 30,),
              Text(
                "Welcome aboard! Your account is created. ready—begin tracking your food's expiry dates and reduce waste now.",
                style: style.copyWith(
                    color: Colors.black,
                    fontSize: 2.6*SizeConfig.heightMultiplier,
                    fontFamily: "Glacial_Regular",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5 * SizeConfig.heightMultiplier),
              authButton("Start Your Journey", () {
                ;
              }),
            ],
          ),
        ),
      ),
    ));
  }
}

TextStyle style = TextStyle(
  fontFamily: "Glacial_Bold",
  color: Colors.black,
);
