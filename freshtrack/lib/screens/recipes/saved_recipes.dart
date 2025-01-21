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
                "Search Recipe", TextInputType.name,(arg){}),
          ),
          SizedBox(
            height: 2.63343 * SizeConfig.heightMultiplier,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: 2.67857 * SizeConfig.widthMultiplier),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (builder,context){
                return Column(
                  children: [
                    GestureDetector(
                      onTap: ()=>Get.to(()=>RecipeDetailScreen(),transition: Transition.fadeIn),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        height: 17.90736*SizeConfig.heightMultiplier,
                        child: Card(
                          elevation: 15,
                          shadowColor: Colours.Green,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(flex: 3,child: ClipRRect(borderRadius: BorderRadius.circular(2.106748*SizeConfig.heightMultiplier),child: Image.asset("assets/pizza.png",height: 10.5*SizeConfig.heightMultiplier,width: 22.5*SizeConfig.widthMultiplier,)),),
                              Expanded(flex: 4,child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 2.10674*SizeConfig.heightMultiplier,),
                                  Text("Pizza",style: style.copyWith(fontFamily: "Poppins",fontSize: 3.5*SizeConfig.heightMultiplier,color: Colors.grey.shade900,fontWeight: FontWeight.w800),),
                                  SizedBox(height: 1.5800*SizeConfig.heightMultiplier,),
                                  Text("(Tomato, Sauce, Cheese, Milk)",maxLines: 3,style: style.copyWith(fontFamily: "Poppins",fontSize: 1.84340*SizeConfig.heightMultiplier,color: Colors.grey.shade700),),
                                ],
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.896074*SizeConfig.heightMultiplier,)
                  ],
                );
              }),
          )
        ],
      ),
    );
  }
}
