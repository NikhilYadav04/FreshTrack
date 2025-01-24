// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/saved_recipe_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';

// ignore: must_be_immutable
class RecipeDetailScreen extends StatelessWidget {
  final SavedRecipeController savedRecipeController = Get.put(SavedRecipeController());
  String title;
  String ingredients;
  String image;
  String making;
  RecipeDetailScreen({
    Key? key,
    required this.title,
    required this.ingredients,
    required this.image,
    required this.making,
  }) : super(key: key);

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
              final email = FirebaseAuth.instance.currentUser!.email!;
              savedRecipeController.deleteItem(context,email , title, making);
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
                  child: Image.network(
                    image,
                    height: 30.02117*SizeConfig.heightMultiplier,
                    width: 94.866*SizeConfig.widthMultiplier,
                  )),
              SizedBox(
                height: 2.1067*SizeConfig.heightMultiplier,
              ),
              Text(
                title,
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
                ingredients,
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
                making,
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
