import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainScreenController extends GetxController{

  //* search Controller
  final TextEditingController searchController = TextEditingController();

  //* bottom bar index
  RxInt index = 1.obs;
}