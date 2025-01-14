import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/home_controller.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/screens/onboard/Onboard1.dart';
import 'package:freshtrack/screens/onboard/Onboard2.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/images.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 67, 128, 69),
      body: Stack(
        fit: StackFit.expand,
        children: [
          //* Title
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.14,
            child: _title(),
          ),

          //*PageView
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.865,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.1 * SizeConfig.widthMultiplier),
              child: PageView(
                controller: _homeController.pageController,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: [
                  Onboard1(),
                  Onboard2(),
                ],
              ),
            ),
          ),

          //* Indicators
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.465,
            child: Center(
              child: SmoothPageIndicator(
                controller: _homeController.pageController,
                count: 2,
                effect: SwapEffect(
                    dotHeight: 2.12 * SizeConfig.heightMultiplier,
                    dotWidth: 4.5 * SizeConfig.widthMultiplier,
                    activeDotColor: Colors.white,
                    dotColor: Colours.Green,
                    type: SwapType.yRotation),
              ),
            ),
          ),

          //* Slider Button
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.162,
            child: Column(
              children: [
                SliderButton(
                    height: 10.007*SizeConfig.heightMultiplier,
                    vibrationFlag: true,
                    width:84.821 * SizeConfig.widthMultiplier,
                    buttonSize:7.3736*SizeConfig.heightMultiplier,
                    icon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colours.Green,
                      size: 4.42417*SizeConfig.heightMultiplier,
                    ),
                    boxShadow: BoxShadow(
                        color: Colours.Green, blurRadius: 5, spreadRadius: 5),
                    shimmer: false,
                    label: Text(
                      "Continue Journey ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 7, 76, 9),
                          fontSize: 3.05478*SizeConfig.heightMultiplier,
                          fontFamily: "Hanken_Bold",
                          fontWeight: FontWeight.bold),
                    ),
                    action: () async {
                      Get.to( ()=> LoginScreen(),transition: Transition.downToUp);
                      return false;
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }
}

Widget _title() {
  return Padding(
    padding:
        EdgeInsets.symmetric(horizontal: 2.67857 * SizeConfig.widthMultiplier),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "FreshTrack",
          style: TextStyle(
              color: Colors.white,
              fontSize: 5.2 * SizeConfig.heightMultiplier,
              fontFamily: "Glacial_Bold"),
        ),
        SizedBox(
          width: 2.23214 * SizeConfig.widthMultiplier,
        ),
        Image.asset(
          Images.Icon,
          height: 9.4 * SizeConfig.heightMultiplier,
          width: 19.4 * SizeConfig.widthMultiplier,
        )
      ],
    ),
  );
}

TextStyle style = TextStyle(
    color: Colours.Green,
    fontSize: 5.2 * SizeConfig.heightMultiplier,
    fontFamily: "Glacial_Bold");
