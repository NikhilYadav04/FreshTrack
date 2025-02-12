import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/search_recipe_controller.dart';
import 'package:freshtrack/helper/DateFormatter.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/screens/recipes/gemini_recipes.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/styling/toast.dart';
import 'package:freshtrack/widgets/main_widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class SearchRecipesScreen extends StatelessWidget {
  final SearchRecipeController searchRecipeController =
      SearchRecipeController();
  SearchRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2.63343 * SizeConfig.heightMultiplier,
          ),
          FittedBox(
              child: Center(
                  child: Text(
            "Choose Items to Discover\nAI-Powered Recipes!",
            style: style.copyWith(
                fontFamily: "Poppins",
                fontSize: 3.16012 * SizeConfig.heightMultiplier),
          ))),
          SizedBox(
            height: 2.317423 * SizeConfig.heightMultiplier,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 2.67857 * SizeConfig.widthMultiplier),
            child: fieldItem(
                context,
                searchRecipeController.searchController,
                "Search Items",
                TextInputType.name,
                searchRecipeController.filterItem),
          ),
          SizedBox(
            height: 2.63343 * SizeConfig.heightMultiplier,
          ),
          StreamBuilder(
              stream: searchRecipeController
                  .fetchList(searchRecipeController.getEmail()!),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Image.asset("assets/main/item.png"));
                } else {
                  final doc = snapshot.data!.docs.first;
                  final items = doc["items"];
                  searchRecipeController.itemList.value =
                      DateTimeFormatter.findExpiry(items);
                  searchRecipeController.filtered.value =
                      DateTimeFormatter.findExpiry(items);
                  List<dynamic> itemList = searchRecipeController.filtered;
                  return Obx(
                    () => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: itemList.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    searchRecipeController.checkList
                                        .add(itemList[index]);
                                  },
                                  child: CheckboxListTile(
                                    activeColor: Colours.Green,
                                    value: searchRecipeController.checkList
                                        .contains(itemList[index]),
                                    title: Text(
                                      itemList[index],
                                      style: style.copyWith(
                                        fontSize: 3.054788 *
                                            SizeConfig.heightMultiplier,
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onChanged: (bool? value) {
                                      if (value == true) {
                                        //* Add the item if it is checked
                                        if (!searchRecipeController.checkList
                                            .contains(itemList[index])) {
                                          searchRecipeController.checkList
                                              .add(itemList[index]);
                                        }
                                      } else {
                                        //* Remove the item if it is unchecked
                                        searchRecipeController.checkList
                                            .remove(itemList[index]);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 1.053 * SizeConfig.heightMultiplier,
                                )
                              ],
                            ),
                          );
                        }),
                  );
                }
              }),
          SizedBox(
            height: 4.740185 * SizeConfig.heightMultiplier,
          ),
          Obx(
            () => searchRecipeController.isLoading.value
                ? Center(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colours.Green,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.125 * SizeConfig.widthMultiplier),
                    child: mainButton("Search AI Recipes", () async {
                      Get.dialog(AlertDialog(
                        backgroundColor: Colors.transparent,
                        actions: [
                          Center(
                            child: Lottie.asset("assets/animation/food.json"),
                          )
                        ],
                      ));

                      final List<Map<String, String>> list =
                          await searchRecipeController.geminiCallAPI(context);

                      if (Get.isDialogOpen == true) {
                        Navigator.of(context).pop();
                      }

                      print(list);
                      if (list.isNotEmpty) {
                        Get.to(
                            () => GeminiRecipes(
                                  recipes: list,
                                ),
                            transition: Transition.fade);
                      } else {
                        toastErrorSlide(context, "Please Try Again !!");
                      }
                    })),
          ),
          SizedBox(height: 35,)
        ],
      ),
    );
  }
}

void dummy(int val) {}
