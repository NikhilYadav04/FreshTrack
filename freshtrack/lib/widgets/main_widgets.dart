import 'package:flutter/material.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';

Widget fieldItem(BuildContext context, TextEditingController controller,
    String label, TextInputType type,void Function(String) onTap,) {
  return Form(
      child: TextFormField(
    onChanged: (value) {
      onTap(value);
    },
    keyboardType: type,
    style: style.copyWith(
        color: Colors.black,
        fontFamily: "Poppins",
        fontSize: 2.633436 * SizeConfig.heightMultiplier),
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.search,size: 3.3707*SizeConfig.heightMultiplier,color: Colors.black,),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Color.fromARGB(170, 218, 213, 213),
        contentPadding: EdgeInsets.symmetric(
            vertical: 1.6 * SizeConfig.heightMultiplier,
            horizontal: 3.34821 * SizeConfig.widthMultiplier),
        label: Text(
          label,
          style: style.copyWith(
              color: Colors.black,
              fontFamily: "Poppins",
              fontSize: 2.633436 * SizeConfig.heightMultiplier),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colours.Green, width: 2),
            borderRadius: BorderRadius.circular(
                0.6320246910979322 * SizeConfig.heightMultiplier)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(
              0.6320246910979322 * SizeConfig.heightMultiplier),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
              0.6320246910979322 * SizeConfig.heightMultiplier),
        )),
  ));
}

Widget mainButton(String title, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 6.84693 * SizeConfig.heightMultiplier,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 2,spreadRadius: 2,color: Colors.lightGreen.shade800)
        ],
          borderRadius:
              BorderRadius.circular(0.63202 * SizeConfig.heightMultiplier),
          color: Colours.Green),
      child: Center(
        child: Text(
          title,
          style: style.copyWith(
              color: Colors.white,
              fontSize: 3.16012 * SizeConfig.heightMultiplier,
              fontFamily: "Glacial_Regular",
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}