import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:freshtrack/helper/toastMessage.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
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
  void createAccount(BuildContext context) async {
    try {
      isLoadingCreate = true.obs;

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: nameControllerCreate.text.toString(),
              password: passwordControllerCreate.text.toString());

      //* Store Email And Phone As Key-Value Pair In Local Storage
      final _myBox = await Hive.box('freshbox');
      _myBox.put(nameControllerCreate.text.toString(),
          numberControllerCreate.text.toString());

      isLoadingCreate = false.obs;

      toastMessage(context, "Success!", "Account Created Successfully!",
          ToastificationType.success);
    } catch (e) {
      if (e is FirebaseAuthException) {
        isLoadingCreate = false.obs;

        switch (e.code) {
          case 'email-already-in-use':
            toastMessage(context, "Error", "Email is already registered.",
                ToastificationType.error);
            break;
          case 'weak-password':
            toastMessage(context, "Error", "Password is too weak.",
                ToastificationType.error);
            break;
          default:
            toastMessage(context, "Error", e.message ?? "An error occurred.",
                ToastificationType.error);
        }
      } else {
        isLoadingCreate = false.obs;

        toastMessage(context, "Error", "An unexpected error occurred.",
            ToastificationType.error);
      }
      ;
    }
  }

  //* login account function
  void loginAccount(BuildContext context) async {
    try {
      isLoadingLogin = true.obs;

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: nameController.text.toString(), password: passwordController.text.toString());

      //* Storing User ID And Email In Hive Storage
      final _myBox = await Hive.box('freshbox');
      _myBox.put(userCredential.user!.uid, nameController.text.toString());
      await Hive.box('auth').put('status', 'Login');

      isLoadingLogin = false.obs;

      toastMessage(context,"Success!", "Logged In Successfully", ToastificationType.success);
    } catch (e) {
      isLoadingLogin = false.obs;
       if(e is FirebaseAuthException){
        switch (e.code) {
        case 'wrong-password':
          toastMessage(context,"Error", 'Incorrect password. Please try again.',ToastificationType.error);
          break;
        case 'user-not-found':
          toastMessage(context,"Error" ,'No user found with this email. Please register first.',ToastificationType.error);
          break;
        default:
          toastMessage(context,"Error", 'An unknown error occurred: ${e.message}',ToastificationType.error);
      }
       }else{
        isLoadingLogin = false.obs;

        toastMessage(context, "Error", "An unexpected error occurred.",
          ToastificationType.error);
       }
    }
  }

  //* logout account function
  void logout(BuildContext context) async{
    try{
      isLoadingLogout = true.obs;

      await FirebaseAuth.instance.signOut();
      await keySecure.clearKey();
      await Hive.box('auth').put('status', 'Logout');

      isLoadingLogout = false.obs;

      Get.offAll(()=>LoginScreen(),transition: Transition.upToDown);
    }catch(e){
      isLoadingLogout = false.obs;

       toastMessage(context, "Error", "An unexpected error occurred.",
          ToastificationType.error);
    }
  }
}
