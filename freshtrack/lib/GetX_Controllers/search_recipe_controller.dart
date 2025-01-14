import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchRecipeController extends GetxController{
  //* controllers for adding item and searching
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  RxBool? isChecked = false.obs;
}