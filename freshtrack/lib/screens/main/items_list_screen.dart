import 'package:flutter/material.dart';
import 'package:freshtrack/GetX_Controllers/main_screen_controller.dart';
import 'package:freshtrack/screens/auth/login_screen.dart';
import 'package:freshtrack/styling/colors.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:freshtrack/widgets/main_widgets.dart';
import 'package:get/get.dart';

class ItemsListScreen extends StatelessWidget {
  final MainScreenController mainScreenController = Get.put(MainScreenController());
  ItemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.125*SizeConfig.widthMultiplier),
      child: Column(
        children: [
          SizedBox(height: 2.63343*SizeConfig.heightMultiplier,),
          Center(child: Text("Your Expiry Items List : ",style: style.copyWith(fontFamily: "Poppins",fontSize: 3.16012*SizeConfig.heightMultiplier),)),
          SizedBox(height: 2.63343*SizeConfig.heightMultiplier,),
          fieldItem(context, mainScreenController.searchController, "Search Items", TextInputType.name),
          SizedBox(height: 3.2*SizeConfig.heightMultiplier,),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context,index){
              return Column(
                children: [
                  Container(
                    height: 13.2*SizeConfig.heightMultiplier,
                    child: Card(
                      elevation: 15,
                      shadowColor: Colours.Green,
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1*SizeConfig.heightMultiplier),
                        child: ListTile(
                          leading: Image.asset("assets/main/burger.png",height: 6.32024*SizeConfig.heightMultiplier,width: 13.39285*SizeConfig.widthMultiplier,),
                          title : Text("Apples",style: style.copyWith(fontFamily: "Poppins",fontSize: 2.84411*SizeConfig.heightMultiplier,color: Colors.black),),
                          subtitle: FittedBox(child: Text("Expiry : 16 January, 2025",style: style.copyWith(fontFamily: "Poppins",fontSize: 2.1*SizeConfig.heightMultiplier,color: Colors.grey.shade800),)),
                          trailing: InkWell(onTap: (){},child: Icon(Icons.delete,color: Colors.grey.shade800,size: 28,),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2*SizeConfig.heightMultiplier,)
                ],
              );
            }
            )
        ],
      ),
    );
  }
}