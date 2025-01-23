// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';

// ignore: must_be_immutable
class GeminiRecipes extends StatelessWidget {
  List<Map<String, String>> recipes;
  GeminiRecipes({
    Key? key,
    required this.recipes,
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
              size: 3.792148 * SizeConfig.heightMultiplier,
            )),
        centerTitle: true,
        backgroundColor: Colours.Green,
        elevation: 15,
        shadowColor: Colors.black,
        toolbarHeight: 8.9536831 * SizeConfig.heightMultiplier,
        title: Text(
          "Recipes For You",
          style: style.copyWith(
              fontSize: 3.686810 * SizeConfig.heightMultiplier,
              fontFamily: "Poppins",
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 2.63343 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 2.678571 * SizeConfig.widthMultiplier),
                child: FittedBox(
                  child: Center(
                      child: Text(
                    "AI-Suggested Recipes for Your\nIngredients.",
                    style: style.copyWith(
                        fontFamily: "Poppins",
                        fontSize: 3.16012 * SizeConfig.heightMultiplier),
                  )),
                ),
              ),
              SizedBox(
                height: 1.317423 * SizeConfig.heightMultiplier,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.678571 * SizeConfig.widthMultiplier,
                            vertical: 1.053 * SizeConfig.heightMultiplier),
                        child: Card(
                          elevation: 16,
                          shadowColor: Colours.Green,
                          color: Colors.white,
                          child: Container(
                              height: 43.188353 * SizeConfig.heightMultiplier,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 1 * SizeConfig.heightMultiplier),
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        leading: Image.asset(
                                            "assets/main/burger.png"),
                                        title: Text(
                                          recipes[index]["title"].toString(),
                                          style: Style.copyWith(
                                              color: Colors.green.shade800,
                                              fontSize: 2.73877 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.785714 *
                                                SizeConfig.widthMultiplier),
                                        child: Text(
                                            recipes[index]["making"].toString(),
                                            // """Preheat your oven to 400°F (200°C). Unroll a store-bought puff pastry sheet onto a baking sheet. Lightly score a border about an inch from the edge. Spread a thin layer of your favorite cheese inside the border, leaving a small gap around the edge. Layer sliced tomatoes and thinly sliced onions over the cheese. Bake for 20-25 minutes, or until the crust is golden brown and the cheese is melted and bubbly. Let it cool slightly before serving.""",
                                            style: Style.copyWith(
                                              color: Colors.grey.shade900,
                                              fontSize: 1.896074 *
                                                  SizeConfig.heightMultiplier,
                                            )),
                                      )),
                                ],
                              )),
                        ));
                  }),
              SizedBox(
                height: 2.106748 * SizeConfig.heightMultiplier,
              )
            ],
          ),
        ),
      ),
    ));
  }
}

TextStyle Style = TextStyle(fontFamily: "Poppins");
