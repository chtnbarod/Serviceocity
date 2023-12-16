import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/view/account/logic.dart';

import '../../theme/app_colors.dart';

class SelectAddressPage extends StatelessWidget {
  final Function(dynamic json)? callback;
  const SelectAddressPage({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountLogic>(
      assignId: true,
      builder: (logic) {
        return ListView.builder(
          itemCount: logic.userModel?.myaddress?.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            bool isPrimary = logic.userModel?.myaddress?[index].id ==
                logic.userModel?.primaryAddress?.id;
            return InkWell(
              onTap: () {
                if(callback != null){
                  callback!(logic.userModel?.myaddress?[index].toJson());
                  Get.back();
                }
              },
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
            );
          },);
      },
    );
  }
}
