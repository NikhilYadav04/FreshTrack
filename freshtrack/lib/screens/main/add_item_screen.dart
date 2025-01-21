import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/search_recipe_controller.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/widgets/auth_widgets.dart';
import 'package:freshtrack/widgets/search_widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddItemScreen extends StatefulWidget {
  AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final SearchRecipeController searchRecipeController =
      Get.put(SearchRecipeController());
  File? _imagefile;

  void _addImage() async {
    final XFile? _pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (_pickedFile != null) {
        _imagefile = File(_pickedFile.path);
      }
    });
  }

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
              size: 36,
            )),
        centerTitle: true,
        backgroundColor: Colours.Green,
        elevation: 15,
        shadowColor: Colors.black,
        toolbarHeight: 8.9536831 * SizeConfig.heightMultiplier,
        title: Text(
          "Add Item",
          style: style.copyWith(
              fontSize: 3.686810 * SizeConfig.heightMultiplier,
              fontFamily: "Poppins",
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 2.6785 * SizeConfig.widthMultiplier,
              vertical: 2.63343 * SizeConfig.heightMultiplier),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title("Image of Item"),
              SizedBox(
                height: 2.106748 * SizeConfig.heightMultiplier,
              ),
              GestureDetector(
                onTap: () {
                  _addImage();
                },
                child: _imagefile == null
                    ? Container(
                        height: 25.28098 * SizeConfig.heightMultiplier,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                1.053 * SizeConfig.heightMultiplier),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 4.634847 * SizeConfig.heightMultiplier,
                            ),
                            SizedBox(
                              height: 1.053 * SizeConfig.heightMultiplier,
                            ),
                            Center(
                              child: Text(
                                "Upload image Of Item",
                                style: style.copyWith(
                                    fontFamily: "Poppins",
                                    fontSize:
                                        2.317423 * SizeConfig.heightMultiplier),
                              ),
                            ),
                          ],
                        ),
                      )
                    : AspectRatio(
                        aspectRatio: 0.17380 * SizeConfig.heightMultiplier,
                        child: Image.file(_imagefile!),
                      ),
              ),
              SizedBox(
                height: 3.160123 * SizeConfig.heightMultiplier,
              ),
              _title("Enter Name of Item"),
              SizedBox(
                height: 1.896074 * SizeConfig.heightMultiplier,
              ),
              fieldAddItem(searchRecipeController.nameController,
                  "Eg: Amul Butter", TextInputType.name),
              SizedBox(
                height: 2.633436 * SizeConfig.heightMultiplier,
              ),
              _title("Set Expiry Date"),
              SizedBox(
                height: 1.896074 * SizeConfig.heightMultiplier,
              ),
              dateField(context, searchRecipeController.dateController,
                  "Eg: 12 April", TextInputType.datetime),
              SizedBox(
                height: 10.53374 * SizeConfig.heightMultiplier,
              ),
              Obx(
                () => searchRecipeController.isLoadingUpload.value
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colours.Green,
                      ))
                    : authButton("Add Item", () async {
                        final email =
                            await FirebaseAuth.instance.currentUser!.email;
                        searchRecipeController.addItem(
                            _imagefile!, email!, context);
                      }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

Widget _title(String title) {
  return Text(
    title,
    style: style.copyWith(
        color: Colors.grey.shade800,
        fontFamily: "Poppins",
        fontSize: 2.73876 * SizeConfig.heightMultiplier),
  );
}
