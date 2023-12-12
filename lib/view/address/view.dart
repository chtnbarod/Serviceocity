import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:serviceocity/view/map/binding.dart';

import '../map/view.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Address"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GetBuilder<AccountLogic>(
          assignId: true,
          builder: (logic) {
            return Column(
              children: [

                InkWell(
                  onTap: () {
                    Get.to(MyMap(callback: (dynamic json) {
                        logic.addAddress(address: json);
                      },
                    ), binding: MyMapBinding());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        const Icon(Icons.add, color: AppColors.primary),
                        const SizedBox(width: 10,),
                        const Text("Add another address",
                          style: TextStyle(
                              color: AppColors.primary
                          ),),

                        if(logic.addingNow)
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(strokeWidth: 2,)),
                          )

                      ],
                    ),
                  ),
                ),

                const Divider(height: 1,),

                const SizedBox(height: 15,),

                Flexible(
                  child: ListView.builder(
                    itemCount: logic.userModel?.myaddress?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      bool isPrimary = logic.userModel?.myaddress?[index].id == logic.userModel?.primaryAddress?.id;
                      return InkWell(
                        onTap: (){
                          Get.to(MyMap(
                            lat: double.tryParse(
                                "${logic.userModel?.myaddress?[index]
                                    .latitude}"),
                            long: double.tryParse(
                                "${logic.userModel?.myaddress?[index]
                                    .longitude}"),
                            callback: (dynamic json) {
                              logic.updateAddress(
                                  index, address: json);
                            },
                          ), binding: MyMapBinding());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text((logic.userModel?.myaddress?[index]
                                    .type ?? "Other").toCapitalizeFirstLetter(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),),

                                if(logic.updatingIndex == index)
                                  const SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),

                                  InkWell(
                                    onTap: (){
                                      if(!isPrimary){
                                        logic.changePrimary(true,index);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if(index == logic.updatingPrimaryIndex)...[
                                            const SizedBox(
                                                width: 18,
                                                height: 18,
                                                child: CircularProgressIndicator(strokeWidth: 2,)),
                                          ]else...[
                                            SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: Checkbox(value: isPrimary,
                                                  shape: const CircleBorder(),
                                                  onChanged: (bool? isChecked){}),
                                            ),
                                          ],
                                          const SizedBox(width: 10,),
                                          Text("${isPrimary ?"":"Mark as "}Primary",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: AppColors.primary
                                            ),),

                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 5,),

                            Text(
                              logic.userModel?.myaddress?[index].address1 ?? "",
                              style: const TextStyle(
                                  fontSize: 12
                              ),),

                            const SizedBox(height: 15,),

                            const Divider(height: 1,),

                            const SizedBox(height: 5,),
                          ],
                        ),
                      );
                    },),
                )

              ],
            );
          },
        ),
      ),
    );
  }
}
