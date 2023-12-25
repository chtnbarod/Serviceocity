import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/view/account/logic.dart';

import '../../theme/app_colors.dart';
import '../map/AddressListModel.dart';
import '../map/binding.dart';
import '../map/view.dart';

class SelectAddressPage extends StatelessWidget {
  final Function(dynamic json)? callback;
  const SelectAddressPage({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountLogic>(
      assignId: true,
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            InkWell(
              onTap: () {
                Get.to(MyMap(callback: (AddressListModel json) {
                  logic.addAddress(address: json.toJson());
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
                  bool isPrimary = logic.userModel?.myaddress?[index].id ==
                      logic.userModel?.primaryAddress?.id;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text((logic.userModel?.myaddress?[index]
                                        .type ?? "Other").toCapitalizeFirstLetter(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                      ),),
                                  ],
                                ),

                                if(isPrimary)
                                  const Text("Primary",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: AppColors.primary
                                    ),),
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
                      ),
                      InkWell(
                        onTap: logic.isVerifyIndex == index ? null : (){
                          logic.validateAddress(index: index,id: "${logic.userModel?.myaddress?[index].id}").then((value) => {
                            if(value){
                              if(callback != null){
                                callback!(logic.userModel?.myaddress?[index].toJson()),
                                Get.back(),
                              }
                            }
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5,color:  Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 40,
                            width: 65,
                            child: logic.isVerifyIndex == index ?
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(strokeWidth: 1,)),
                              ],
                            ) :
                            const Center(
                              child: Text("Select",
                                style: TextStyle(
                                    color: Colors.blue
                                ),),
                            )
                        ),
                      ),
                    ],
                  );
                },),
            ),
          ],
        );
      },
    );
  }
}
