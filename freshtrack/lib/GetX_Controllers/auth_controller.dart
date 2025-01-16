import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/helper/toastMessage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:toastification/toastification.dart';

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

  //* Functions

  //* create functions
  void createAccount(BuildContext context) async {
    try {
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: nameControllerCreate.text.toString(), password: passwordControllerCreate.text.toString());
        toastMessage(context, "Done!", "Success", ToastificationType.success);
    } catch (e) {
      toastMessage(context, "Authentication Error", e.toString(), ToastificationType.error);
    }
  }
}
