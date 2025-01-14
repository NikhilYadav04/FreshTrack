import 'package:flutter/material.dart';
import 'package:freshtrack/styling/images.dart';
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
            height: 320,
            width: 400,
          ),
          SizedBox(height: 25,),
          Text(
            Strings.onBoardTitle[0],style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontFamily: "Glacial_Bold"
            ),
          ),
          SizedBox(height: 15,),
           Text(
            Strings.onBoardDescription[0],style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w500,
              fontFamily: "Glacial_Regular"
            ),
          ),
        ],
      ),
    );
  }
}
