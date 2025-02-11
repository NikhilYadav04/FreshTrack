import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:freshtrack/helper/toastMessage.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/screens/auth/success_screen.dart';
import 'package:freshtrack/services/notificationService.dart';
import 'package:freshtrack/styling/toast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
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

  //* loaders
  RxBool isLoadingCreate = false.obs;
  RxBool isLoadingLogin = false.obs;
  RxBool isLoadingLogout = false.obs;

  void toggleStateLogin() {
    isVisibleLogin.value = !isVisibleLogin.value;
    isVisibleCreate.value = !isVisibleCreate.value;
  }

  //* Functions

  //* create account function
  Future<String> createAccount(BuildContext context) async {
    try {
      isLoadingCreate = true.obs;

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: nameControllerCreate.text.toString(),
              password: passwordControllerCreate.text.toString());

      if (!Hive.isBoxOpen('freshbox')) {
        await keySecure.getKey();
      }

      //* Store Email And Phone As Key-Value Pair In Local Storage
      final _myBox = await Hive.box('freshbox');
      _myBox.put(nameControllerCreate.text.toString(),
          numberControllerCreate.text.toString());

      isLoadingCreate = false.obs;
      Get.back();

      toastSuccessSlide(context, "Account Created Successfully!!");
      return "Success";
    } catch (e) {
      if (e is FirebaseAuthException) {
        isLoadingCreate = false.obs;

        switch (e.code) {
          case 'email-already-in-use':
            toastErrorSlide(context, "Email is already registered.");
            break;
          case 'weak-password':
            toastErrorSlide(context, "Email is already registered.");
            break;
          default:
            toastMessage(context, "Error", e.message ?? "An error occurred.",
                ToastificationType.error);
        }
        return "Error";
      } else {
        isLoadingCreate = false.obs;
        print(e.toString());

        toastMessage(context, "Error", e.toString(), ToastificationType.error);

        return "Error";
      }
    }
  }

  //* login account function
  Future<String> loginAccount(BuildContext context) async {
    try {
      isLoadingLogin = true.obs;

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: nameController.text.toString(),
              password: passwordController.text.toString());

      if (!Hive.isBoxOpen('freshbox')) {
        await keySecure.getKey();
      }

      //* Storing User ID And Email In Hive Storage
      final _myBox = await Hive.box('freshbox');
      _myBox.put(userCredential.user!.uid, nameController.text.toString());

      print(_myBox.get(userCredential.user!.uid));
      await Hive.box('auth').put('status', 'Login');

       //* store fcm token of each device for notification
      //await Notificationservice.storeFCMToken();

      isLoadingLogin = false.obs;
      Get.to(() => SuccessScreen(), transition: Transition.rightToLeft);

      toastSuccessSlide(context, "Logged In Successfully!!");

      return "Success";
    } catch (e) {
      isLoadingLogin = false.obs;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'wrong-password':
            toastErrorSlide(context, 'Incorrect password. Please try again.');
            break;
          case 'user-not-found':
            toastErrorSlide(context,
                'No user found with this email. Please register first.');
            break;
          default:
            toastErrorSlide(context, 'An unknown error occurred: ${e.message}');
        }
        return "Error";
      } else {
        isLoadingLogin = false.obs;

        toastMessage(context, "Error", e.toString(), ToastificationType.error);
        return "Error";
      }
    }
  }

  //* logout account function
  Future<String> logout(BuildContext context) async {
    try {
      isLoadingLogout = true.obs;

      await FirebaseAuth.instance.signOut();
      await keySecure.clearKey();
      await Hive.box('auth').put('status', 'Logout');

      isLoadingLogout = false.obs;

      Get.offAll(() => LoginScreen(), transition: Transition.upToDown);

      return "Sucess";
    } catch (e) {
      isLoadingLogout = false.obs;

      toastErrorSlide(context, "An unexpected error occurred.");
      return "Error";
    }
  }
}
