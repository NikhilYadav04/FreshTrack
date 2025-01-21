import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ItemListController extends GetxController {
  RxList<dynamic> filtered = [].obs;
  RxList<dynamic> itemList = [].obs;

  //* get email
  String? getemail() {
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

  //* delete item
  Future<void> deleteItem(String email, String p_name, String date) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("expiry")
          .where("email", isEqualTo: email)
          .get();

      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      DocumentReference documentReference = documentSnapshot.reference;

      List<dynamic> items = List.from(documentSnapshot["items"]);

      items.removeWhere(
          (item) => item["p_name"] == p_name && item["e_date"] == date);

      print(items);

      await documentReference.update({"items": items});
    } catch (e) {
      print(e.toString());
    }
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
}
