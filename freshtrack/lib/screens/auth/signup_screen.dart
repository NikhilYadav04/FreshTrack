import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/auth_controller.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/images.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/widgets/auth_widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 6.84693 * SizeConfig.heightMultiplier,
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
          "Create",
          style: style.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 3.3707 * SizeConfig.heightMultiplier),
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
                "Register Account",
                style: style.copyWith(
                    color: Colours.Green,
                    fontSize: 4.00282 * SizeConfig.heightMultiplier),
              ),
              Text(
                "Create your new account",
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
                  authController.keyNameCreate,
                  authController.nameControllerCreate,
                  "Enter Your Email",
                  TextInputType.name),
              SizedBox(
                height: 2.63343 * SizeConfig.heightMultiplier,
              ),
              field(
                  context,
                  authController.phoneCreate,
                  authController.numberControllerCreate,
                  "Enter Your Phone Number",
                  TextInputType.number),
              SizedBox(
                height: 2.63343 * SizeConfig.heightMultiplier,
              ),
              Passwordfield(
                  context,
                  authController.keyPasswordCreate,
                  authController.passwordControllerCreate,
                  "Enter your Password",
                  authController.isVisibleCreate,
                  authController),
              SizedBox(height: 7 * SizeConfig.heightMultiplier),
              Obx(
                () => authController.isLoadingCreate.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : authButton("Create", () async{
                        if (authController.keyNameCreate.currentState!
                                .validate() &&
                            authController.phoneCreate.currentState!
                                .validate() &&
                            authController.keyPasswordCreate.currentState!
                                .validate()) {
                          await authController.createAccount(context);
                        } else {}
                      }),
              ),
              SizedBox(
                height: 3.16012 * SizeConfig.heightMultiplier,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: style.copyWith(
                          color: Colors.grey.shade800,
                          fontSize: 2.475430 * SizeConfig.heightMultiplier,
                          fontFamily: "Glacial_Regular",
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: " Log in",
                            style: style.copyWith(
                                color: Colours.Green,
                                fontSize:
                                    2.475430 * SizeConfig.heightMultiplier,
                                fontFamily: "Glacial_Regular",
                                fontWeight: FontWeight.bold))
                      ]),
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
