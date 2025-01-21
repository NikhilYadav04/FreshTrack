import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:freshtrack/helper/toastMessage.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class SearchRecipeController extends GetxController {
  //* controllers for adding item and searching
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  //* loader
  RxBool isLoadingUpload = false.obs;

  //*lists
  RxList<dynamic> filtered = [].obs;
  RxList<dynamic> itemList = [].obs;
  RxList<dynamic> checkList = [].obs;

  //* add image in cloudinary
  Future<String> addImage(File image, BuildContext context) async {
    if (image.path.isEmpty) {
      toastMessage(context, "Image Error!", "Invalid image path",
          ToastificationType.error);
      return '';
    }

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/${keySecure.cloudinary_name}/upload');

    try {
      final compressedImageBytes = await compressAndResizeImage(image);

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'e_items'
        ..files.add(await http.MultipartFile.fromBytes(
            'file', compressedImageBytes!,
            filename: "compressed.jpg"));

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
        final errorResponseData = await response.stream.toBytes();
        final errorResponseString = String.fromCharCodes(errorResponseData);
        print(
            "Failed with status: ${response.statusCode}\nResponse: $errorResponseString");
        toastMessage(
          context,
          "Image Error!",
          "Failed with status: ${response.statusCode}\nResponse: $errorResponseString",
          ToastificationType.error,
        );
        return '';
      }
    } catch (e) {
      print(e.toString());
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

  //* compress image and resize to square
  Future<Uint8List?> compressAndResizeImage(File image) async {
    try {
      final inputBytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(inputBytes);
      if (decodedImage == null) {
        print("Failed to decode the image.");
        return null;
      }

      final cropSize = decodedImage.width < decodedImage.height
          ? decodedImage.width
          : decodedImage.height;

      final xOffset = (decodedImage.width - cropSize) ~/ 2;
      final yOffset = (decodedImage.height - cropSize) ~/ 2;

      final croppedImage = img.copyCrop(
        decodedImage,
        x: xOffset,
        y: yOffset,
        height: cropSize,
        width: cropSize,
      );

      final resizedImage = img.copyResize(
        croppedImage,
        width: 500,
        height: 500,
      );

      final resizedBytes =
          Uint8List.fromList(img.encodeJpg(resizedImage, quality: 70));

      final compressedImage = await FlutterImageCompress.compressWithList(
        resizedBytes,
        minWidth: 500,
        minHeight: 500,
        quality: 60,
      );

      if (compressedImage.isEmpty) {
        print("Compression resulted in an empty list.");
        return null;
      }

      print("Compression successful. Size: ${compressedImage.length}");
      return Uint8List.fromList(compressedImage);
    } catch (e) {
      print("Compression error: ${e.toString()}");
      return null;
    }
  }

  //* get email
  String? getEmail() {
    return FirebaseAuth.instance.currentUser!.email;
  }

  //*fetch items list
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchList(String email) {
    print(email);
    print(FirebaseFirestore.instance
        .collection("expiry")
        .where("email", isEqualTo: email)
        .get());

    return FirebaseFirestore.instance
        .collection("expiry")
        .where("email", isEqualTo: email)
        .snapshots();
  }

  //* filter items
  void filterItem(String keyword) {
    if (keyword.isEmpty) {
      filtered.value = itemList;
    } else {
      filtered.value = itemList
          .where((item) => item["p_name"]
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }
  }

  RxBool? isChecked = false.obs;
}
