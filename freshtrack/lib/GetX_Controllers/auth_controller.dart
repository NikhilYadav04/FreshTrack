import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController {
  //* Login controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //* Create controllers
  final TextEditingController nameControllerCreate = TextEditingController();
  final TextEditingController numberControllerCreate = TextEditingController();
  final TextEditingController passwordControllerCreate =
      TextEditingController();

  //* key
  final GlobalKey<FormState> keyName = GlobalKey<FormState>();
  final GlobalKey<FormState> keyPassword = GlobalKey<FormState>();

  final GlobalKey<FormState> keyNameCreate = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneCreate = GlobalKey<FormState>();
  final GlobalKey<FormState> keyPasswordCreate = GlobalKey<FormState>();

  //* bool for obscure
  RxBool isVisibleLogin = true.obs;
  RxBool isVisibleCreate = true.obs;

  void toggleStateLogin() {
    isVisibleLogin.value = !isVisibleLogin.value;
    isVisibleCreate.value = !isVisibleCreate.value;
  }
}
