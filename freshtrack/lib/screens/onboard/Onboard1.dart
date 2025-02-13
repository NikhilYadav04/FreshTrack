import 'package:flutter/material.dart';
import 'package:freshtrack/styling/images.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/styling/strings.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Images.Onboard1,
            height: 33.70798*SizeConfig.heightMultiplier,
            width: 89.28571*SizeConfig.widthMultiplier,
          ),
          SizedBox(height: 2.63343*SizeConfig.heightMultiplier,),
          Text(
            Strings.onBoardTitle[0],style: TextStyle(
              color: Colors.white,
              fontSize: 3.5814*SizeConfig.heightMultiplier,
              fontFamily: "Glacial_Bold"
            ),
          ),
          SizedBox(height: 1.5800*SizeConfig.heightMultiplier,),
           Text(
            Strings.onBoardDescription[0],style: TextStyle(
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
