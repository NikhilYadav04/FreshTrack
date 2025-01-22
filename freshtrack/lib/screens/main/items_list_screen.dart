import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_url_gen/transformation/delivery/delivery.dart';
import 'package:cloudinary_url_gen/transformation/delivery/delivery_actions.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/item_list_controller.dart';
import 'package:freshtrack/GetX_Controllers/main_screen_controller.dart';
import 'package:freshtrack/helper/checkExpiry.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/widgets/main_widgets.dart';
import 'package:get/get.dart';

class ItemsListScreen extends StatelessWidget {
  final ItemListController itemListController = Get.put(ItemListController());
  final MainScreenController mainScreenController =
      Get.put(MainScreenController());
  ItemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 3.125 * SizeConfig.widthMultiplier),
      child: Column(
        children: [
          SizedBox(
            height: 2.63343 * SizeConfig.heightMultiplier,
          ),
          Center(
              child: Text(
            "Your Expiry Items List : ",
            style: style.copyWith(
                fontFamily: "Poppins",
                fontSize: 3.16012 * SizeConfig.heightMultiplier),
          )),
          SizedBox(
            height: 2.63343 * SizeConfig.heightMultiplier,
          ),

          //* textField ofr searching items
          fieldItem(
              context,
              mainScreenController.searchController,
              "Search Items",
              TextInputType.name,
              itemListController.filterItem),
          SizedBox(
            height: 3.2 * SizeConfig.heightMultiplier,
          ),

          //* To display list
          StreamBuilder(
              stream:
                  itemListController.fetchList(itemListController.getemail()!),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colours.Green,
                    ),
                  );
                } else {
                  if (snapshot.hasData) {
                    final doc = snapshot.data!.docs.first;
                    final items = doc["items"];
                    itemListController.itemList.value = items;
                    itemListController.filtered.value = items;
                    List<dynamic> itemList = itemListController.filtered;
                    return Obx(
                      ()=> ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: itemList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 13.2 * SizeConfig.heightMultiplier,
                                  child: Card(
                                    elevation: 16,
                                    shadowColor: CheckExpiry.checkExpiry(itemList[index]["e_date"]) ? Colors.red : Colours.Green,
                                    color: Colors.white,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              1 * SizeConfig.heightMultiplier),
                                      child: ListTile(
                                        leading: SizedBox(
                                          height: 6.32024 *
                                              SizeConfig.heightMultiplier,
                                          width: 13.39285 *
                                              SizeConfig.widthMultiplier,
                                          child: imageDisplay(
                                              itemList[index]["imageURL"]),
                                        ),
                                        title: Text(
                                          itemList[index]["p_name"],
                                          style: style.copyWith(
                                              fontFamily: "Poppins",
                                              fontSize: 2.84411 *
                                                  SizeConfig.heightMultiplier,
                                              color: Colors.black),
                                        ),
                                        subtitle: FittedBox(
                                            child: Text(
                                          "Expiry : ${itemList[index]["e_date"]}",
                                          style: style.copyWith(
                                              fontFamily: "Poppins",
                                              fontSize: 2.1 *
                                                  SizeConfig.heightMultiplier,
                                              color: Colors.grey.shade800),
                                        )),
                                        trailing: InkWell(
                                          onTap: () {
                                            itemListController.deleteItem(
                                                itemListController.getemail()!,
                                                itemList[index]["p_name"],
                                                itemList[index]["e_date"]);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade800,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2 * SizeConfig.heightMultiplier,
                                )
                              ],
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: Text("No Items Available"),
                    );
                  }
                }
              })
        ],
      ),
    );
  }
}

Widget imageDisplay(String image) {
  return CldImageWidget(
      publicId: image.split("/")[7].split(".")[0],
      transformation: Transformation()
        ..delivery(Delivery.format(Format.auto))
        ..delivery(Delivery.quality(Quality.auto()))
        ..resize(Resize.auto()),
      width: 13.39285 * SizeConfig.widthMultiplier,
      height: 6.32024 * SizeConfig.heightMultiplier);
}
