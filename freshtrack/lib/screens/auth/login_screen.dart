import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/auth_controller.dart';
import 'package:freshtrack/screens/auth/signup_screen.dart';
import 'package:freshtrack/screens/auth/success_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/images.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/widgets/auth_widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return SafeArea(
        child: Scaffold(
      //* AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 6.8469*SizeConfig.heightMultiplier,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (){Get.back();},
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 3.37079*SizeConfig.heightMultiplier,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Login",
          style: style.copyWith(fontWeight: FontWeight.w400, fontSize: 3.37079*SizeConfig.heightMultiplier),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.67857*SizeConfig.widthMultiplier),
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                Images.Icon,
                height: 15.8006*SizeConfig.heightMultiplier,
                width: 32.3660*SizeConfig.widthMultiplier,
              )),
              Text(
                "Welcome Back",
                style: style.copyWith(color: Colours.Green, fontSize: 4.00282*SizeConfig.heightMultiplier),
              ),
              Text(
                "Login to your account",
                style: style.copyWith(
                    color: Colors.black,
                    fontSize: 3.370798*SizeConfig.heightMultiplier,
                    fontFamily: "Glacial_Regular",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height:4.213497*SizeConfig.heightMultiplier,),
              field(context, authController.keyName, authController.nameController, "Enter Your Email",TextInputType.name),
              SizedBox(height: 2.63343*SizeConfig.heightMultiplier,),
              Passwordfield(context, authController.keyPassword, authController.passwordController, "Enter your Password",authController.isVisibleLogin,authController),
              SizedBox(height:2.94944*SizeConfig.heightMultiplier,),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("Forgot Password?",style: style.copyWith(color: Colors.grey.shade800,fontSize: 2.63343*SizeConfig.heightMultiplier,fontFamily: "Glacial_Regular",fontWeight: FontWeight.bold),),
              ),
              SizedBox(height:3.6868*SizeConfig.heightMultiplier),
              authButton("Login",(){
                if(authController.keyName.currentState!.validate() && authController.keyPassword.currentState!.validate()){
                   Get.to(()=>  SuccessScreen(),transition: Transition.rightToLeft);
                }else{
                  
                }
               ;}),
              SizedBox(height: 3.16012*SizeConfig.heightMultiplier,),
              GestureDetector(
                onTap: (){  Get.to(()=> SignupScreen(),transition: Transition.rightToLeft);},
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: style.copyWith(color: Colors.grey.shade800,fontSize:2.475430*SizeConfig.heightMultiplier,fontFamily: "Glacial_Regular",fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: " Sign up",
                        style: style.copyWith(color: Colours.Green,fontSize: 2.475430*SizeConfig.heightMultiplier,fontFamily: "Glacial_Regular",fontWeight: FontWeight.bold)
                      )
                    ]
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
