import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/auth_controller.dart';
import 'package:freshtrack/GetX_Controllers/main_screen_controller.dart';
import 'package:freshtrack/GetX_Controllers/notification_controller.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:freshtrack/services/workManager.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/screens/main/add_item_screen.dart';
import 'package:freshtrack/screens/main/items_list_screen.dart';
import 'package:freshtrack/screens/recipes/saved_recipes.dart';
import 'package:freshtrack/screens/recipes/search_recipes.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/images.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NotificationController notificationController =
      Get.put(NotificationController());
  final MainScreenController mainScreenController =
      Get.put(MainScreenController());
  String name = "";

  final AuthController authController = Get.put(AuthController());

  List<dynamic> screens = [
    SearchRecipesScreen(),
    ItemsListScreen(),
    SavedRecipesScreen()
  ];

  void _setName() async {
    final userID = await FirebaseAuth.instance.currentUser!.uid;
    //* Open The Box;
    await keySecure.getKey();

    name = await Hive.box('freshbox').get(userID).toString().split("@")[0];
    setState(() {
      name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colours.Green,
        elevation: 15,
        shadowColor: Colors.black,
        toolbarHeight: 8.95368 * SizeConfig.heightMultiplier,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddItemScreen(), transition: Transition.upToDown);
            },
            icon: Icon(
              Icons.add_circle_outline_sharp,
              color: Colors.white,
              size: 5.47754 * SizeConfig.heightMultiplier,
            ),
          ),
          //  InkWell(
          //     onTap: () => Get.to(() => NotificationScreen(),
          //         transition: Transition.upToDown),
          //     child: Image.asset(
          //       Images.Bell,
          //       height: 4.42417 * SizeConfig.heightMultiplier,
          //       width: 9.375 * SizeConfig.widthMultiplier,
          //     )),
          InkWell(
              onTap: () {
                print("Taske xecuted clicekd");
               // Notificationservice.createanddisplaynotificationLocally("Apple","Hi dance");
                 //Notificationservice.sendNotification();
                //WorkManager.executeTask();
                //WorkManager.cancelTask();
                WorkManager.scheduleNotifyExpiry(20, "APple");
              },
              child: Image.asset(
                Images.Bell,
                height: 4.42417 * SizeConfig.heightMultiplier,
                width: 9.375 * SizeConfig.widthMultiplier,
              )),
          IconButton(
            onPressed: () {
              authController.logout(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              size: 4.9 * SizeConfig.heightMultiplier,
            ),
          ),
          // SizedBox(width: 1.1*SizeConfig.widthMultiplier,)
        ],
        title: Text(
          "Hello ${name},",
          style: style.copyWith(
              fontSize: 3.68681 * SizeConfig.heightMultiplier,
              fontFamily: "Poppins",
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => screens[mainScreenController.index.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
            height: 7.16294 * SizeConfig.heightMultiplier,
            buttonBackgroundColor: Colours.Green,
            backgroundColor: Colors.white,
            color: Colours.Green,
            onTap: (value) => mainScreenController.index.value = value,
            index: mainScreenController.index.value,
            items: [
              Icon(
                Icons.search,
                size: 4.213497 * SizeConfig.heightMultiplier,
                color: Colors.white,
              ),
              Icon(
                Icons.shopping_cart,
                size: 4.213497 * SizeConfig.heightMultiplier,
                color: Colors.white,
              ),
              Icon(
                Icons.soup_kitchen_sharp,
                size: 4.213497 * SizeConfig.heightMultiplier,
                color: Colors.white,
              ),
            ]),
      ),
    ));
  }
}
