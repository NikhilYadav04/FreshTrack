import 'package:flutter/material.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 3.79214*SizeConfig.heightMultiplier,
            )
            ),
          actions: [
            IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 3.79214*SizeConfig.heightMultiplier,
            )
            ),
          ],
        centerTitle: true,
        backgroundColor: Colours.Green,
        elevation: 15,
        shadowColor: Colors.black,
        toolbarHeight: 8.9536831 * SizeConfig.heightMultiplier,
        title: Text(
          "Recipe Detail",
          style: style.copyWith(
              fontSize: 3.686810 * SizeConfig.heightMultiplier,
              fontFamily: "Poppins",
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.9017*SizeConfig.widthMultiplier),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.63343*SizeConfig.heightMultiplier,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(1.053*SizeConfig.heightMultiplier),
                  child: Image.asset(
                    "assets/pizza.png",
                    height: 30.02117*SizeConfig.heightMultiplier,
                    width: 94.866*SizeConfig.widthMultiplier,
                  )),
              SizedBox(
                height: 2.1067*SizeConfig.heightMultiplier,
              ),
              Text(
                "Italian Classic Pizza",
                style: style.copyWith(
                    fontSize: 3.581473*SizeConfig.heightMultiplier,
                    fontFamily: "Poppins",
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height:  2.1067*SizeConfig.heightMultiplier,
              ),
              Text(
                "Ingredients Used :",
                style: style.copyWith(
                    fontSize: 2.949448*SizeConfig.heightMultiplier,
                    fontFamily: "Poppins",
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 1.58006*SizeConfig.heightMultiplier,
              ),
              Text(
                "Cheese, tomato, Onion, Capsicum",
                style: style.copyWith(
                    fontSize: 2.528098*SizeConfig.heightMultiplier,
                    fontFamily: "Poppins",
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height:   2.1067*SizeConfig.heightMultiplier,
              ),
              Text(
                "How To Prepare? :",
                style: style.copyWith(
                    fontSize: 2.949448*SizeConfig.heightMultiplier,
                    fontFamily: "Poppins",
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 1.58006*SizeConfig.heightMultiplier,
              ),
              Text(
                "To make a delicious pizza, start by preparing the dough. Mix two cups of flour, a teaspoon each of sugar, salt, and yeast, then add warm water and a drizzle of olive oil. Knead the dough until it’s smooth and let it rise for about an hour. Once the dough is ready, roll it out on a floured surface to your preferred thickness. Preheat the oven to 475°F (245°C) while you spread a generous layer of pizza sauce over the rolled-out dough, leaving a little space for the crust. Add your favorite toppings like cheese, vegetables, and meats, ensuring they’re evenly distributed.",
                style: style.copyWith(
                    fontSize: 2.31742*SizeConfig.heightMultiplier,
                    fontFamily: "Poppins",
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w800),
              ),
               SizedBox(
                height: 2.63343*SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
