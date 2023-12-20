import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:serviceocity/view/map/AddressListModel.dart';
import 'package:serviceocity/view/map/binding.dart';

import '../map/view.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Address"),
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
                      bool isPrimary = logic.userModel?.myaddress?[index].id == logic.userModel?.primaryAddress?.id;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 10,),
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  )
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                              child: InkWell(
                                onTap: logic.deleting == index ? null : (){
                                  logic.deleteAddress(index: index);
                                },
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: logic.deleting == index ?
                                  const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ) :
                                  const Icon(Icons.delete,color: Colors.black87,size: 15,),
                                ),
                              ),
                          ),

                          InkWell(
                            onTap: (){
                              Get.to(MyMap(addressListModel: AddressListModel.fromJson(logic.userModel?.myaddress?[index].toJson()),
                                callback: (AddressListModel json) {
                                  logic.updateAddress(
                                      index, address: json.toJson());
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


                                              Text("${isPrimary ?"":"Mark as "}Primary",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: AppColors.primary
                                                ),),

                                              const SizedBox(width: 10,),

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
                          ),
                        ],
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
