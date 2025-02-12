import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/auth_controller.dart';
import 'package:freshtrack/screens/auth/change_password_screen.dart';
import 'package:freshtrack/screens/auth/signup_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/images.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/widgets/auth_widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class VerifyCodeScreen extends StatelessWidget {
  VerifyCodeScreen({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //* AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 6.8469 * SizeConfig.heightMultiplier,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 3.37079 * SizeConfig.heightMultiplier,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Verify Code",
          style: style.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 3.37079 * SizeConfig.heightMultiplier),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 2.67857 * SizeConfig.widthMultiplier),
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                Images.Icon,
                height: 15.8006 * SizeConfig.heightMultiplier,
                width: 32.3660 * SizeConfig.widthMultiplier,
              )),
              Text(
                "Verify Code!!",
                style: style.copyWith(
                    color: Colours.Green,
                    fontSize: 4.00282 * SizeConfig.heightMultiplier),
              ),
              Text(
                "Enter the code here",
                style: style.copyWith(
                    color: Colors.black,
                    fontSize: 3.370798 * SizeConfig.heightMultiplier,
                    fontFamily: "Glacial_Regular",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4.213497 * SizeConfig.heightMultiplier,
              ),
              field(
                  context,
                  authController.forgotCodeKey,
                  authController.forgotCodeController,
                  "Enter Your Code",
                  TextInputType.name),
              SizedBox(height: 3.6868 * SizeConfig.heightMultiplier),
              //* Loading Logic For Button
              Obx(
                () => authController.isLoadingForgotCode.value
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colours.Green,
                      ))
                    : authButton("Send Code", () async {
                        if (authController.forgotCodeKey.currentState!
                            .validate()) {
                          await authController.loginAccount(context);
                        } else {}
                        ;
                      }),
              ),
              SizedBox(
                height: 3.16012 * SizeConfig.heightMultiplier,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ChangePasswordScreen(),
                      transition: Transition.rightToLeft);
                },
                child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                        text: "Check the code received",
                        style: style.copyWith(
                            color: Colors.grey.shade800,
                            fontSize: 2.475430 * SizeConfig.heightMultiplier,
                            fontFamily: "Glacial_Regular",
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: " on your email.",
                              style: style.copyWith(
                                  color: Colours.Green,
                                  fontSize:
                                      2.475430 * SizeConfig.heightMultiplier,
                                  fontFamily: "Glacial_Regular",
                                  fontWeight: FontWeight.bold))
                        ]),
                  ),
                ),
              )
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
