import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/auth_controller.dart';
import 'package:freshtrack/screens/home/Homescreen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';

Widget field(BuildContext context, GlobalKey<FormState> key,
    TextEditingController controller, String label, TextInputType type) {
  return Form(
      key: key,
      child: FormField(validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'This field cannot be empty';
        } else if (type == TextInputType.name) {
          if (!GetUtils.isAlphabetOnly(value.toString())) {
            return 'Name should be in alphabet only';
          }
        }else if (type == TextInputType.phone) {
          if (!GetUtils.isLengthEqualTo(value.toString(), 10)) {
            return 'Name should be 10 digits only.';
          }
        }
        return null;
      }, builder: (context) {
        return TextField(
          keyboardType: type,
          style: style.copyWith(
              color: Colors.black, fontFamily: "Glacial_Regular", fontSize: 2.633436*SizeConfig.heightMultiplier),
          controller: controller,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Color.fromARGB(170, 218, 213, 213),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 2.106748*SizeConfig.heightMultiplier, horizontal: 3.34821*SizeConfig.widthMultiplier),
              label: Text(
                label,
                style: style.copyWith(
                    color: Colors.black,
                    fontFamily: "Glacial_Regular",
                    fontSize: 2.633436*SizeConfig.heightMultiplier),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colours.Green, width: 2),
                  borderRadius: BorderRadius.circular(0.6320246910979322*SizeConfig.heightMultiplier)),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(0.6320246910979322*SizeConfig.heightMultiplier),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(0.6320246910979322*SizeConfig.heightMultiplier),
              )),
        );
      }));
}

Widget Passwordfield(
    BuildContext context,
    GlobalKey<FormState> key,
    TextEditingController controller,
    String label,
    RxBool obscureText,
    AuthController auth_controller) {
  return Form(
      key: key,
      child: FormField(validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'This field cannot be empty';
        } else if (GetUtils.isLengthLessThan(value.toString(), 6)) {
          return 'Password is too short';
        }
        return null;
      }, builder: (context) {
        return Obx(
          () => TextField(
            obscureText: obscureText.value,
            style: style.copyWith(
                color: Colors.black,
                fontFamily: "Glacial_Regular",
                fontSize: 2.633436*SizeConfig.heightMultiplier),
            controller: controller,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: auth_controller.toggleStateLogin,
                    icon: obscureText.value
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                            size: 3.37079*SizeConfig.heightMultiplier,
                          )
                        : Icon(Icons.visibility,
                            color: Colors.black, size: 3.37079*SizeConfig.heightMultiplier)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Color.fromARGB(170, 218, 213, 213),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.1067*SizeConfig.heightMultiplier, horizontal: 3.348214*SizeConfig.widthMultiplier),
                label: Text(
                  label,
                  style: style.copyWith(
                      color: Colors.black,
                      fontFamily: "Glacial_Regular",
                      fontSize: 2.63343*SizeConfig.heightMultiplier),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colours.Green, width: 2),
                    borderRadius: BorderRadius.circular(0.63202*SizeConfig.heightMultiplier)),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(0.63202*SizeConfig.heightMultiplier),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(0.63202*SizeConfig.heightMultiplier),
                )),
          ),
        );
      }));
}

Widget authButton(String title, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 6.84693*SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.63202*SizeConfig.heightMultiplier), color: Colours.Green),
      child: Center(
        child: Text(
          title,
          style: style.copyWith(
              color: Colors.white,
              fontSize: 3.16012*SizeConfig.heightMultiplier,
              fontFamily: "Glacial_Regular",
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
