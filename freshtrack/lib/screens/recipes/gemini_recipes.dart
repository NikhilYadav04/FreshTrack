// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/saved_recipe_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:group_button/group_button.dart';

// ignore: must_be_immutable
class GeminiRecipes extends StatelessWidget {
  final SavedRecipeController savedRecipeController =
      Get.put(SavedRecipeController());
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
                            horizontal: 3.125 * SizeConfig.widthMultiplier,
                            vertical: 1.2 * SizeConfig.heightMultiplier),
                        child: Card(
                          elevation: 15,
                          shadowColor: Colors.green,
                          color: Colors.white,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: ExpansionTile(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text(
                                      recipes[index]["making"].toString(),
                                      style: Style.copyWith(
                                        color: Colors.grey.shade900,
                                        fontSize:
                                            2 * SizeConfig.heightMultiplier,
                                      ),
                                    ),
                                  )
                                ],
                                leading: SizedBox(
                                    height:
                                        6.32024 * SizeConfig.heightMultiplier,
                                    width:
                                        13.39285 * SizeConfig.widthMultiplier,
                                    child: recipes[index]["image"].toString() == "" ? Image.asset("assets/main/burger.png") : Image.network(
                                        recipes[index]["image"].toString())),
                                title: FittedBox(
                                  child: Text(
                                    maxLines: 2,
                                    recipes[index]["title"].toString(),
                                    style: Style.copyWith(
                                        color: Colors.green.shade800,
                                        fontSize:
                                            2.7 * SizeConfig.heightMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Obx(
                                    () => GroupButton(
                                      onSelected: (value, Index, isSelected) {
                                        savedRecipeController.addRecipe(
                                            context,
                                            recipes[index]["title"].toString(),
                                            recipes[index]["making"]
                                                .toString(),recipes[index]["image"]
                                                .toString(),recipes[index]["ingredients"]
                                                .toString());
                                      },
                                      options: GroupButtonOptions(
                                          buttonHeight: 35,
                                          buttonWidth: 75,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          //* if recipe is saved is checked in local storage
                                          selectedColor: savedRecipeController
                                                  .saveList
                                                  .any((map) =>
                                                      map[recipes[index]["title"]
                                                          .toString()] ==
                                                      true)
                                              ? Colors.green
                                              : Colors.red,
                                          unselectedColor:
                                              savedRecipeController.saveList.any((map) => map[recipes[index]["title"].toString()] == true)
                                                  ? Colors.green
                                                  : Colors.red,
                                          mainGroupAlignment:
                                              MainGroupAlignment.start,
                                          selectedTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: "Poppins"),
                                          unselectedTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: "Poppins")),
                                      buttons: [
                                        savedRecipeController.saveList.any(
                                                (map) =>
                                                    map[recipes[index]["title"]
                                                        .toString()] ==
                                                    true)
                                            ? 'Saved'
                                            : 'Save'
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
