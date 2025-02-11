import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:freshtrack/helper/keySecure.dart';
import 'package:freshtrack/helper/toastMessage.dart';
import 'package:freshtrack/services/workManager.dart';
import 'package:freshtrack/styling/strings.dart';
import 'package:freshtrack/styling/toast.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:toastification/toastification.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';

class SearchRecipeController extends GetxController {
  //* controllers for adding item and searching
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  //* loader
  RxBool isLoadingUpload = false.obs;

  //*lists
  RxList<dynamic> filtered = [].obs;
  RxList<dynamic> checkList = [].obs;

  RxList<dynamic> itemList = [].obs;

  //* loader
  RxBool isLoading = false.obs;

  //* add image in cloudinary

  Future<String> addImage(File image, BuildContext context) async {
    if (image.path.isEmpty) {
      toastMessage(context, "Image Error!", "Invalid image path",
          ToastificationType.error);
      return '';
    }

    final String cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/${keySecure.cloudinary_name}/upload';

    try {
      final compressedImageBytes = await compressAndResizeImage(image);
      if (compressedImageBytes == null) {
        toastMessage(context, "Image Error!", "Image compression failed",
            ToastificationType.error);
        return '';
      }

      dio.Dio dioInstance = dio.Dio();

      dio.FormData formData = dio.FormData.fromMap({
        'upload_preset': 'e_items',
        'file': dio.MultipartFile.fromBytes(compressedImageBytes,
            filename: "compressed.jpg"),
      });

      dio.Response response = await dioInstance.post(
        cloudinaryUrl,
        data: formData,
        options: dio.Options(
          sendTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final jsonMap = response.data;

        if (jsonMap['url'] != null) {
          return jsonMap['url'];
        }
      }

      toastMessage(
        context,
        "Image Error!",
        "Failed with status: ${response.statusCode}\nResponse: ${jsonEncode(response.data)}",
        ToastificationType.error,
      );
      return '';
    } on dio.DioException catch (e) {
      String errorMessage = "An error occurred";

      if (e.type == dio.DioExceptionType.connectionTimeout ||
          e.type == dio.DioExceptionType.receiveTimeout) {
        errorMessage = "Connection timed out!";
      } else if (e.response != null) {
        errorMessage =
            "Failed with status: ${e.response?.statusCode}\nResponse: ${jsonEncode(e.response?.data)}";
      } else {
        errorMessage = e.message ?? "Unexpected error";
      }

      toastMessage(
        context,
        "Image Error!",
        errorMessage,
        ToastificationType.error,
      );
      return '';
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

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("expiry");

      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();

      List<dynamic> list = querySnapshot.docs.first["items"];

      if (list.length >= 10) {
        toastErrorSlide(context, "You can add only 10 Items in List");
        isLoadingUpload.value = false;
      } else {
        final url = await addImage(image, context);

        if (url.isEmpty) {
          isLoadingUpload.value = false;
          toastErrorSlide(context, "Image upload failed");
          return 'Image Upload Failed';
        }

        print("Reached here");

        DateTime now = DateTime.now();
        DateTime targetDate =
            DateFormat("MMMM d, y").parse(dateController.text.trim());
        Duration difference = targetDate.difference(now);

        List<Map<String, dynamic>> items = [
          {
            "p_name": nameController.text.trim(),
            "e_date": dateController.text.trim(),
            "remaining_hours": difference.inHours.toString(),
            "imageURL": url,
          }
        ];

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

        //* After adding items schedule workmanager task for showing notifications
        WorkManager.scheduleNotifyExpiry(
            difference.inHours, nameController.text.trim());

        toastSuccessSlide(context, "Item Added Successfully");
        isLoadingUpload.value = false;
      }

      return 'Success';
    } catch (e) {
      isLoadingUpload.value = false;
      toastErrorSlide(context, "Failed to add item: $e");
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
          .where((item) =>
              item.toString().toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
  }

  //* gemini api call
  Future<List<Map<String, String>>> geminiCallAPI(BuildContext context) async {
    isLoading.value = true;

    try {
      if (checkList.isNotEmpty) {
        final model = GenerativeModel(
          model: 'gemini-2.0-flash-exp',
          apiKey: keySecure.gemini_key,
          generationConfig: GenerationConfig(
            temperature: 1,
            topK: 40,
            topP: 0.95,
            maxOutputTokens: 8192,
            responseMimeType: 'text/plain',
          ),
        );
        final chat = model.startChat(history: []);

        final message = Strings.prompt(checkList);
        final content = Content.text(message);

        print(Strings.prompt(checkList));

        final response = await chat.sendMessage(content);

        print(response);

        String cleanedResponse =
            response.text!.replaceAll(RegExp(r'```json|```'), '').trim();

        List<dynamic> decoded = jsonDecode(cleanedResponse);

        //* Convert to list of maps
        List<Map<String, String>> list = decoded.map((item) {
          if (item is Map<String, dynamic>) {
            return Map<String, String>.from(item);
          }
          throw FormatException("Expected Map, but got ${item.runtimeType}");
        }).toList();

        //* Fetch images
        for (int i = 0; i < list.length; i++) {
          final recipe = list[i]["title"];
          if (recipe != null) {
            String image = await getImageRecipe(recipe);
            list[i]["image"] = image;
          }
        }

        isLoading.value = false;

        if (list.isEmpty) {
          toastErrorSlide(context, "Please Try Again !!");
        }

        return list;
      } else {
        toastErrorSlide(context, "No Food Items Provided !!");
        isLoading.value = false;
        return [];
      }
    } catch (e) {
      isLoading.value = false;
      print("An error occurred: $e");
      return [];
    }
  }

  //* get recipe photo from api
  Future<String> getImageRecipe(String title) async {
    try {
      final recipe = title.split(" ")[2];
      final dio.Dio dioInstance = dio.Dio();

      //* Set the timeout to 6=5 seconds
      dioInstance.options.connectTimeout = Duration(seconds: 4);
      dioInstance.options.receiveTimeout = Duration(seconds: 4);

      final url =
          "https://api.spoonacular.com/recipes/complexSearch?query=$recipe&number=2&apiKey=${keySecure.spoonacular_key}";

      final response = await dioInstance.get(url);

      final responseBody = jsonDecode(response.toString());
      final imageURL = responseBody["results"][0]["image"];

      return imageURL;
    } on dio.DioException catch (e) {
      if (e.type == dio.DioExceptionType.sendTimeout ||
          e.type == dio.DioExceptionType.receiveTimeout) {
        return "Request Timed Out, Please Try Again";
      }
      return "";
    }
  }

  RxBool? isChecked = false.obs;
}
