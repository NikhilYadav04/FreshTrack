import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/saved_recipe_controller.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/screens/recipes/recipe_detail_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/widgets/main_widgets.dart';
import 'package:get/get.dart';

class SavedRecipesScreen extends StatelessWidget {
  final SavedRecipeController savedRecipeController = SavedRecipeController();
  SavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2.63343 * SizeConfig.heightMultiplier,
          ),
          Center(
              child: Text(
            "Saved Recipes",
            style: style.copyWith(
                fontFamily: "Poppins",
                fontSize: 3.6 * SizeConfig.heightMultiplier),
          )),
          SizedBox(
            height: 2.317423 * SizeConfig.heightMultiplier,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 2.67857 * SizeConfig.widthMultiplier),
            child: fieldItem(context, savedRecipeController.searchController,
                "Search Recipe", TextInputType.name, savedRecipeController.filterItem),
          ),
          SizedBox(
            height: 2.63343 * SizeConfig.heightMultiplier,
          ),
          StreamBuilder(
            stream: savedRecipeController
                .getSaved(FirebaseAuth.instance.currentUser!.email!),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colours.Green,
                  ),
                );
              } else {
                if (snapshot.hasData) {
                  print(snapshot.data.docs.length);
                  final doc = snapshot.data!.docs.first;
                  final items = doc["recipes"];
                  savedRecipeController.recipeList.value = items;
                  savedRecipeController.filtered.value = items;
                  List<dynamic> itemList = savedRecipeController.filtered;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 2.67857 * SizeConfig.widthMultiplier),
                    child: Obx(
                      ()=> ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: itemList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.to(() => RecipeDetailScreen(
                                    title: itemList[index]["title"],
                                    ingredients: itemList[index]["ingredients"],
                                    image: itemList[index]["image"],
                                    making: itemList[index]["making"],
                                  ),
                                      transition: Transition.fadeIn),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 0),
                                    height:
                                        17.90736 * SizeConfig.heightMultiplier,
                                    child: Card(
                                      elevation: 15,
                                      shadowColor: Colours.Green,
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius
                                                    .circular(2.106748 *
                                                        SizeConfig
                                                            .heightMultiplier),
                                                child: Image.network(
                                                  itemList[index]["image"],
                                                  height: 10.5 *
                                                      SizeConfig.heightMultiplier,
                                                  width: 22.5 *
                                                      SizeConfig.widthMultiplier,
                                                )),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 2.10674 *
                                                      SizeConfig.heightMultiplier,
                                                ),
                                                FittedBox(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.only(right: 8),
                                                    child: Text(
                                                      itemList[index]["title"],
                                                      style: style.copyWith(
                                                          fontFamily: "Poppins",
                                                          fontSize: 3.5 *
                                                              SizeConfig
                                                                  .heightMultiplier,
                                                          color: Colors
                                                              .grey.shade900,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1.5800 *
                                                      SizeConfig.heightMultiplier,
                                                ),
                                                Text(
                                                  itemList[index]["ingredients"]
                                                  .toString(),
                                                  maxLines: 3,
                                                  style: style.copyWith(
                                                      fontFamily: "Poppins",
                                                      fontSize: 2.1 *
                                                          SizeConfig
                                                              .heightMultiplier,
                                                      color:
                                                          Colors.grey.shade700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.896074 * SizeConfig.heightMultiplier,
                                )
                              ],
                            );
                          }),
                    ),
                  );
                } else if(snapshot.data == null || snapshot.data.length == 0){
                  return Center(
                    child: Text(
                      "No Saved Recipes",
                      style: style.copyWith(fontSize: 24,color: Colors.black),
                    ),
                  );
                }else{
                  return Center(
                    child: Text(
                      "No Saved Recipes",
                      style: style.copyWith(fontSize: 24,color: Colors.black),
                    ),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}
