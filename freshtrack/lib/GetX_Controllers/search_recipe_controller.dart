import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:freshtrack/helper/toastMessage.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;

class SearchRecipeController extends GetxController {
  //* controllers for adding item and searching
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  //* loader
  RxBool isLoadingUpload = false.obs;

  //* add image in cloudinary
  Future<String> addImage(File image, BuildContext context) async {
    if (image.path.isEmpty) {
      toastMessage(context, "Image Error!", "Invalid image path",
          ToastificationType.error);
      return '';
    }

    final url = Uri.parse('https://api.cloudinary.com/v1_1/${keySecure.cloudinary_name}/upload');

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'e_items'
        ..files.add(await http.MultipartFile.fromPath('file', image.path));
      
      print(image);
      print("Hello");

      final response = await request.send().timeout(Duration(seconds: 20));

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);

         print("End");


        if (jsonMap['url'] != null) {
          return jsonMap['url'];
        } else {
          return '';
        }
      } else {
        toastMessage(
          context,
          "Image Error!",
          "Failed with status: ${response.statusCode}",
          ToastificationType.error,
        );
        return '';
      }
    } catch (e) {
      toastMessage(
        context,
        "Image Error!",
        "An exception occurred: ${e.toString()}",
        ToastificationType.error,
      );
      return '';
    }
  }

  //* add item in list
  Future<String> addItem(File image, String email, BuildContext context) async {
    try {
      isLoadingUpload.value = true;

      final url = await addImage(image, context);

      if (url.isEmpty) {
        isLoadingUpload.value = false;
        toastMessage(
            context, "Error", "Image upload failed", ToastificationType.error);
        return 'Image Upload Failed';
      }

      print("Reached here");

      List<Map<String, dynamic>> items = [
        {
          "p_name": nameController.text.trim(),
          "e_date": dateController.text.trim(),
          "imageURL": url,
        }
      ];

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("expiry");

      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        String docID = querySnapshot.docs.first.id;
        await collectionReference.doc(docID).update({
          "items": FieldValue.arrayUnion(items),
        });
      } else {
        await collectionReference.add({
          "email": email,
          "items": items,
        });
      }

      toastMessage(context, "Success", "Item Added Successfully",
          ToastificationType.success);
      isLoadingUpload.value = false;
      return 'Success';
    } catch (e) {
      isLoadingUpload.value = false;
      toastMessage(
          context, "Error", "Failed to add item: $e", ToastificationType.error);
      return 'Failed';
    }
  }

  RxBool? isChecked = false.obs;
}
