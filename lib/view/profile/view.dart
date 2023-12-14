import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/utils/assets.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:serviceocity/view/profile/menu_item.dart';
import 'package:serviceocity/widget/common_image.dart';

import 'logic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20,),

            GetBuilder<AccountLogic>(
              assignId: true,
              builder: (logic) {
                return Column(
                  children: [
                    CommonImage(
                      height: 100,
                      width: 100,
                      radius: 50,
                      assetPlaceholder: appUser,
                      imageUrl: "${ApiProvider.url}/${logic.userModel?.image}",
                    ),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Get.toNamed(rsAccountPage);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text((logic.userModel?.name??"").toCapitalizeFirstLetter(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                          const SizedBox(width: 5,),
                          const Icon(Icons.edit,size: 15,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5,),
                   if((logic.userModel?.mobile??"").isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone,size: 12,),
                        const SizedBox(width: 5,),
                        Text(logic.userModel?.mobile??"",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300

                        ),),
                      ],
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20,),

            Container(
              height: 10,
              color: Colors.black12,
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),

            const MenuItem(
              title: "Help Center",
              icon: Icons.chat_bubble,
              isLast: true,
            ),

            Container(
              height: 10,
              color: Colors.black12,
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),
            const MenuItem(
              title: "My Booking",
              icon: Icons.receipt,
            ),
            MenuItem(
              title: "Manage Address",
              icon: Icons.location_on,
              onClick: (){
                Get.toNamed(rsAddressPage);
              },
            ),
            const MenuItem(
              title: "Resister as Partner",
              icon: Icons.handshake_outlined,
            ),
            const MenuItem(
              title: "About Serviceocity",
              icon: Icons.info_outlined,
            ),
            const MenuItem(
              title: "Share Serviceocity",
              icon: Icons.share,
            ),
            MenuItem(
              title: "Refer & earn",
              icon: Icons.local_offer,
              onClick: (){
                Get.toNamed(rsReferPage);
              },
            ),
            const MenuItem(
              title: "My Rating",
              icon: Icons.star,
            ),
            MenuItem(
              title: "My Wallet",
              icon: Icons.account_balance_wallet,
              onClick: (){
                Get.toNamed(rsWalletPage);
              },
            ),
            const MenuItem(
              title: "Scheduling Booking",
              icon: Icons.bookmark_border,
            ),
            const MenuItem(
              title: "Rate Serviceocity",
              icon: Icons.rate_review,
            ),
          ],
        ),
      ),
    );
  }
}
