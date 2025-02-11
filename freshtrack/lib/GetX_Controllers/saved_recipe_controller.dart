import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/styling/toast.dart';
import 'package:get/get.dart';

class SavedRecipeController extends GetxController {
  //* controller for searching
  final TextEditingController searchController = TextEditingController();

  RxList<Map<String, bool>> saveList = <Map<String, bool>>[].obs;

  RxList<dynamic> recipeList = [].obs;
  RxList<dynamic> filtered = [].obs;

  //* add saved recipe
  Future<String> addRecipe(BuildContext context, String title, String making,
      String image, String ingredients) async {
    try {
      final email = FirebaseAuth.instance.currentUser!.email;
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("saved");

      List<Map<String, String>> recipe = [
        {
          "title": title,
          "making": making,
          "image": image,
          "ingredients": ingredients
        }
      ];

      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();
      ;

      List<dynamic> list = querySnapshot.docs.first["recipes"];
      if (list.length >= 10) {
        toastErrorSlide(context, "Only 10 recipes can be saved");
        return "Limit Exceeded";
      } else {
        //* add saved recipe in a list to check if it is saved
        saveList.add({"${title}": true});

        if (querySnapshot.docs.isNotEmpty) {
          final docID = querySnapshot.docs.first.id;

          await collectionReference
              .doc(docID)
              .update({"recipes": FieldValue.arrayUnion(recipe)});
          toastSuccessSlide(context, "Recipe Saved Successfully!");
          return "Success";
        } else {
          await collectionReference.add(recipe);
          toastSuccessSlide(context, "Recipe Saved Successfully!");
          return "Success";
        }
      }
    } catch (e) {
      print(e.toString());
      return "Error";
    }
  }

  //* check if saved
  Future<bool> checkRecipe(BuildContext context, String title) async {
    try {
      print("Hello");
      final email = FirebaseAuth.instance.currentUser!.email;

      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("saved");

      QuerySnapshot querySnapshot =
          await collectionReference.where("email", isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        return false;
      } else {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        List<dynamic> recipeList = documentSnapshot.get("recipe");

        bool titleExists = recipeList.any((recipe) => recipe["title"] == title);
        return titleExists ? true : false; //*return true if title exits
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //* get all saved recipes
  Stream<QuerySnapshot<Map<String, dynamic>>> getSaved(String email) {
    return FirebaseFirestore.instance
        .collection("saved")
        .where("email", isEqualTo: email)
        .snapshots();
  }

  //* delete saved recipes
  Future<void> deleteItem(
      BuildContext context, String email, String title, String making) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("saved")
          .where("email", isEqualTo: email)
          .get();

      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      DocumentReference documentReference = documentSnapshot.reference;

      List<dynamic> recipes = List.from(documentSnapshot["recipes"]);

      recipes.removeWhere(
          (item) => item["title"] == title && item["making"] == making);

      await documentReference.update({"recipes": recipes});

      toastSuccessSlide(context, "Recipe Deleted Successfully");
    } catch (e) {
      print(e.toString());
    }
  }

  //* filter items
  void filterItem(String keyword) {
    if (keyword.isEmpty) {
      filtered.value = recipeList;
    } else {
      filtered.value = recipeList
          .where((item) => item["title"]
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }
  }
}
