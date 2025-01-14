import 'package:flutter/material.dart';
import 'package:freshtrack/styling/images.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/styling/strings.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              Images.Onboard2,
              height: 33.70798*SizeConfig.heightMultiplier,
              width: 80.428571*SizeConfig.widthMultiplier,
            ),
          ),
          SizedBox(height: 2.63343*SizeConfig.heightMultiplier,),
          Text(
            Strings.onBoardTitle[1],style: TextStyle(
              color: Colors.white,
              fontSize: 3.476135*SizeConfig.heightMultiplier,
              fontFamily: "Glacial_Bold"
            ),
          ),
          SizedBox(height: 1.580061*SizeConfig.heightMultiplier,),
           Text(
            Strings.onBoardDescription[1],style: TextStyle(
              color: Colors.white,
              fontSize: 2.73877*SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
              fontFamily: "Glacial_Regular"
            ),
          ),
        ],
      ),
    );
  }
}