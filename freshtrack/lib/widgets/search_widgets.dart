import 'package:flutter/material.dart';
import 'package:freshtrack/helper/DateFormatter.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';

Widget fieldAddItem(
    TextEditingController controller, String label, TextInputType type) {
  return Form(
      child: TextFormField(
    keyboardType: type,
    style: style.copyWith(
        color: Colors.black,
        fontFamily: "Poppins",
        fontSize: 2.633436 * SizeConfig.heightMultiplier),
    controller: controller,
    decoration: InputDecoration(
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

Widget dateField(BuildContext context, TextEditingController controller,
    String label, TextInputType type) {
  return Form(
      child: TextFormField(
    keyboardType: type,
    style: style.copyWith(
        color: Colors.black,
        fontFamily: "Poppins",
        fontSize: 2.633436 * SizeConfig.heightMultiplier),
    controller: controller,
    decoration: InputDecoration(
        suffixIcon: GestureDetector(
            onTap: () {
               _selectDate(context, controller);
              controller.text = DateTimeFormatter.formatDate(controller.text);
            },
            child: Icon(
              Icons.calendar_month,
              size: 3.370798*SizeConfig.heightMultiplier,
              color: Colors.black,
            )),
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

Future<void> _selectDate(
    BuildContext context, TextEditingController textController) async {
  DateTime? date = await showDatePicker(
    context: context,
    firstDate: DateTime(2000),
    initialDate: DateTime.now(),
    lastDate: DateTime(2100),
  );

  if (date != null) {
    String formattedDate =
        date.toString().split(" ")[0].split("-").reversed.join("-");
    textController.text = formattedDate;
    textController.text = DateTimeFormatter.formatDate(textController.text);
  }
}
