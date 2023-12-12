import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/price_converter.dart';
import 'package:serviceocity/view/checkout/logic.dart';
import 'package:serviceocity/view/offer/binding.dart';
import 'package:serviceocity/view/offer/view.dart';
import 'package:serviceocity/widget/custom_button.dart';

import '../../core/routes.dart';
import 'package:country_list_pick/country_list_pick.dart';


class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<CheckoutLogic>(
          assignId: true,
          builder: (logic) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (bool? checked) {

                      }),
                      const Text("Avoid Calling before reach home",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12
                        ),)
                    ],
                  ),

                  const SizedBox(height: 10,),
                  Container(
                    height: 5,
                    color: Colors.grey.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),


                  InkWell(
                    onTap: () {
                      Get.to(OfferPage(
                        callback: (dynamic json){
                          logic.applyCode(json);
                        },
                      ),binding: OfferBinding(),arguments: {
                        "category_id" : logic.cartModel?.categoryId
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.discount, color: AppColors.primary,),
                              SizedBox(width: 10,),
                              Text("Coupons and offer ",
                                style: TextStyle(
                                    color: Colors.black87
                                ),)
                            ],
                          ),

                          Row(
                            children: [
                              Text("Offer",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple
                                ),),
                              SizedBox(width: 5,),
                              Icon(Icons.arrow_forward_ios,
                                color: Colors.deepPurple, size: 20,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    height: 5,
                    color: Colors.grey.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),

                  const SizedBox(height: 30,),

                  const Text("Payment Summary",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),

                  const SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Item Total",
                        style: TextStyle(
                            fontWeight: FontWeight.w500

                        ),),
                      Text("\u{20b9}${logic.checkoutData.price}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                        ),),
                    ],
                  ),


                 if(logic.checkoutData.discount>0)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Discount",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500
                              ),),
                            Text("${logic.json['code']}",
                              style: const TextStyle(
                                  fontSize: 12
                              ),),
                          ],
                        ),
                        Text("\u{20b9}${logic.checkoutData.discount}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.green
                          ),),
                      ],
                    ),
                  ),



                  const SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Taxes and Fee",
                        style: TextStyle(
                            fontWeight: FontWeight.w500

                        ),),
                      Text("\u{20b9}${logic.checkoutData.tax}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                        ),),
                    ],
                  ),

                  const SizedBox(height: 15,),

                  Container(
                    height: 2,
                    color: Colors.grey.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),


                  const SizedBox(height: 15,),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold

                        ),),
                      Text("\u{20b9}${logic.checkoutData.total}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),),
                    ],
                  ),

                  const SizedBox(height: 25,),

                 if(logic.checkoutData.discount>0)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3)
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.discount, color: Colors.green.shade900,),
                        const SizedBox(width: 10,),
                        Text(
                            "Yeh! You have saved \u{20b9}${logic.checkoutData.discount} on final bill")
                      ],
                    ),
                  ),


                  const SizedBox(height: 25,),

                  Container(
                    height: 5,
                    color: Colors.grey.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),

                  const SizedBox(height: 15,),

                  CustomButton(
                    text: "Proceed",
                    onTap: () {
                      Get.toNamed(rsTimeSlotsPage,arguments: {
                        "category_id" : logic.cartModel?.categoryId
                      });
                    },
                  ),

                  const SizedBox(height: 15,),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
