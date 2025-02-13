import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:freshtrack/helper/toastMessage.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/screens/auth/success_screen.dart';
import 'package:freshtrack/styling/toast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:toastification/toastification.dart';
import 'package:workmanager/workmanager.dart';

class AuthController extends GetxController {
  //* Login controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //* Create controllers
  final TextEditingController nameControllerCreate = TextEditingController();
  final TextEditingController numberControllerCreate = TextEditingController();
  final TextEditingController passwordControllerCreate =
      TextEditingController();

  //* Forgot PassControllers
  final TextEditingController forgotEmailController = TextEditingController();
  final TextEditingController forgotCodeController = TextEditingController();

  final TextEditingController changePasswordController =
      TextEditingController();
  final TextEditingController changePasswordControllerVerify =
      TextEditingController();

  //* key
  final GlobalKey<FormState> keyName = GlobalKey<FormState>();
  final GlobalKey<FormState> keyPassword = GlobalKey<FormState>();

  final GlobalKey<FormState> keyNameCreate = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneCreate = GlobalKey<FormState>();
  final GlobalKey<FormState> keyPasswordCreate = GlobalKey<FormState>();

  final GlobalKey<FormState> forgotEmailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotCodeKey = GlobalKey<FormState>();

  final GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> changePasswordVerifyKey = GlobalKey<FormState>();

  //* bool for obscure
  RxBool isVisibleLogin = true.obs;
  RxBool isVisibleCreate = true.obs;
  RxBool isVisibleChange = true.obs;
  RxBool isVisibleChangeVerify = true.obs;

  //* loaders
  RxBool isLoadingCreate = false.obs;
  RxBool isLoadingLogin = false.obs;
  RxBool isLoadingLogout = false.obs;
  RxBool isLoadingForgotEmail = false.obs;
  RxBool isLoadingForgotCode = false.obs;
  RxBool isLoadingChangePassword = false.obs;

  void toggleStateLogin() {
    isVisibleLogin.value = !isVisibleLogin.value;
    isVisibleCreate.value = !isVisibleCreate.value;
    isVisibleChange.value = !isVisibleChange.value;
    isVisibleChangeVerify.value = !isVisibleChangeVerify.value;
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
      await Workmanager().cancelAll();

      isLoadingLogout = false.obs;

      Get.offAll(() => LoginScreen(), transition: Transition.upToDown);

      return "Sucess";
    } catch (e) {
      isLoadingLogout = false.obs;

      toastErrorSlide(context, "An unexpected error occurred.");
      return "Error";
    }
  }

  //* change password via email link
  Future<void> sendPasswordResetEmail(
      BuildContext context) async {
    try {
      isLoadingForgotEmail.value = true;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmailController.text.toString());
      toastSuccessSlideLong(context, 'Password reset link sent to ${forgotEmailController.text.toString()}');
      isLoadingForgotEmail.value = false;
    } catch (e) {
      toastErrorSlide(context, 'Error: ${e.toString()}');
      isLoadingForgotEmail.value = false;
    }
  }

  //* send code to email
  Future<void> sendCode(BuildContext context, String email) async {
    try {
      isLoadingForgotEmail.value = true;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('codes');
      QuerySnapshot querySnapshot =
          await collectionReference.where('email', isEqualTo: email).get();

      final code = "";

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.update({'code': code});
      } else {
        await collectionReference.add({"email": email, "code": code});
      }

      toastSuccessSlide(context, "Code Sent To Your Email");

      isLoadingForgotEmail.value = false;
    } catch (e) {
      toastErrorSlide(context, "Error : ${e.toString()}");
      isLoadingForgotEmail.value = false;
    }
  }

  //* verify code
  Future<String> verifyCode(BuildContext context, String code) async {
    try {
      isLoadingForgotCode.value = true;
      final email = await FirebaseAuth.instance.currentUser!.email!;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('codes')
          .where('email', isEqualTo: email)
          .get();
      final sentCode = querySnapshot.docs.first.get('code').toString();

      if (sentCode == code) {
        toastSuccessSlide(context, "Code Verified Successfully !");
        isLoadingForgotCode.value = false;
        return "Success";
      } else {
        toastErrorSlide(context, "Incorrect Code Entered !");
        isLoadingForgotCode.value = false;
        return "Error Verifying";
      }
    } catch (e) {
      toastErrorSlide(context, "Error : ${e.toString()}");
      isLoadingForgotCode.value = false;
    }
    return "";
  }

  //* change password
  Future<String> changePassword(String password) async {
    try {
      return "";
    } catch (e) {
      return "Error : ${e.toString()}";
    }
  }
}

ToastController toastSuccessSlideLong(BuildContext context, String title) {
  return InteractiveToast.slideSuccess(
    context,
    title: Text(
      "${title}",
      style: TextStyle(
          fontSize: 20,
          fontFamily: "Glacial_Bold",
          color: Colors.green.shade800),
    ),
    toastSetting: SlidingToastSetting(
      toastStartPosition: ToastPosition.bottom,
      toastAlignment: Alignment(0, 0.9),
      maxHeight: 180,
      maxWidth: 400,
      animationDuration: Duration(seconds: 1),
      displayDuration: Duration(seconds: 6),
    ),
  );
}