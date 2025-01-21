import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/search_recipe_controller.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/widgets/main_widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colours.Green,
                    ),
                  );
                } else {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No Items Available"),
                    );
                  } else {
                    final doc = snapshot.data!.docs.first;
                    final items = doc["items"];
                    searchRecipeController.itemList.value = items;
                    searchRecipeController.filtered.value = items;
                    List<dynamic> itemList = searchRecipeController.filtered;
                    print("checkList is ${searchRecipeController.checkList}");
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
                                          .add(itemList[index]["p_name"]);
                                    },
                                    child: CheckboxListTile(
                                      activeColor: Colours.Green,
                                      value: searchRecipeController.checkList
                                          .contains(itemList[index]["p_name"]),
                                      title: Text(
                                        itemList[index]["p_name"],
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
                                              .contains(
                                                  itemList[index]["p_name"])) {
                                            searchRecipeController.checkList
                                                .add(itemList[index]["p_name"]);
                                          }
                                        } else {
                                          //* Remove the item if it is unchecked
                                          searchRecipeController.checkList
                                              .remove(
                                                  itemList[index]["p_name"]);
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
                }
              }),
          SizedBox(
            height: 4.740185 * SizeConfig.heightMultiplier,
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.125 * SizeConfig.widthMultiplier),
              child: mainButton("Search AI Recipes", () {}))
        ],
      ),
    );
  }
}

void dummy(int val) {}
