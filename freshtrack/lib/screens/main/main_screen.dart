import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/main_screen_controller.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/screens/main/add_item_screen.dart';
import 'package:freshtrack/screens/main/items_list_screen.dart';
import 'package:freshtrack/screens/notifications/notification_screen.dart';
import 'package:freshtrack/screens/recipes/saved_recipes.dart';
import 'package:freshtrack/screens/recipes/search_recipes.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/images.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  final MainScreenController mainScreenController = Get.put(MainScreenController());

  List<dynamic> screens = [
    SearchRecipesScreen(),
    ItemsListScreen(),
    SavedRecipesScreen()
  ];
  MainScreen({super.key});

    @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colours.Green,
            elevation: 15,
            shadowColor: Colors.black,
            toolbarHeight: 8.95368*SizeConfig.heightMultiplier,
            actions: [
              IconButton(onPressed: (){
                Get.to(()=>AddItemScreen(),transition: Transition.upToDown);
              }, icon: Icon(Icons.add_circle_outline_sharp,color: Colors.white,size: 5.47754*SizeConfig.heightMultiplier,),),
              InkWell
              (
                onTap: ()=>Get.to(()=>NotificationScreen(),transition: Transition.upToDown),
                child: Image.asset(Images.Bell,height: 4.42417*SizeConfig.heightMultiplier,width: 9.375*SizeConfig.widthMultiplier,)),
              SizedBox(width: 1.11607*SizeConfig.widthMultiplier,)
            ],
            title: Text("Hello Nikhil,",style: style.copyWith(fontSize: 3.68681*SizeConfig.heightMultiplier,fontFamily: "Poppins",color: Colors.white,fontWeight: FontWeight.w600),),
          ),
      body: SingleChildScrollView(
        child: Obx(
          ()=>  screens[mainScreenController.index.value],
        ),
      ),
      bottomNavigationBar: Obx(
        ()=> CurvedNavigationBar(
          height: 7.16294*SizeConfig.heightMultiplier,
          buttonBackgroundColor: Colours.Green,
          backgroundColor: Colors.white,
          color: Colours.Green,
          onTap: (value) => mainScreenController.index.value = value,
          index: mainScreenController.index.value,
          items: [
            Icon(Icons.search,size: 4.213497*SizeConfig.heightMultiplier,color: Colors.white,),
             Icon(Icons.shopping_cart,size: 4.213497*SizeConfig.heightMultiplier,color: Colors.white,),
            Icon(Icons.soup_kitchen_sharp,size: 4.213497*SizeConfig.heightMultiplier,color: Colors.white,),
          ]
          ),
      ),
    ));
  }
}