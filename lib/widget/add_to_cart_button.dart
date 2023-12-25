import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_client.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/view/cart/logic.dart';

import '../theme/app_colors.dart';
import '../utils/toast.dart';
import '../view/cart/circle_icon_button.dart';

class AddToCartButton extends StatefulWidget {
  final int quantity;
  final int? serviceId;
  final int? cartId;
  final Function(dynamic json)? onUpdate;
  final Function(dynamic json)? onAddToCart;
  const AddToCartButton({
    Key? key,
    this.onUpdate,
    this.onAddToCart,
    this.quantity = 0,
    this.serviceId,
    this.cartId,
  }) : super(key: key);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {

  bool isIncrease = false;
  bool isDecrease = false;
  bool isAddToCart = false;


  @override
  Widget build(BuildContext context) {
    Color color = AppColors.primary;
    double height = 35;
    double width = 80;
    double buttonSize = 30;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(color: color,width: 0.5),
          color: AppColors.primaryColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          if(widget.quantity < 1)...[
            if(isAddToCart)...[
              SizedBox(
                  width: (buttonSize),
                  height: (buttonSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: (buttonSize/1.5),
                          height: (buttonSize/1.5),
                          child: const CircularProgressIndicator(strokeWidth: 1,color: AppColors.primary,)),
                    ],
                  )),
            ]else...[
              InkWell(
                onTap: () async {
                  setState(() {
                    isAddToCart = true;
                  });
                  Response res = await Get.find<ApiClient>().postAPI(ApiProvider.addToCart, {
                    "product_id" : widget.serviceId,
                    "quantity" : "1",
                  });
                  setState(() {
                    isAddToCart = false;
                  });
                  if(widget.onAddToCart != null){
                    if(res.statusCode == 200){
                      widget.onAddToCart!(res.body);
                      Get.find<CartLogic>().getCart();
                    }if(res.statusCode == 422){
                      Toast.show(toastMessage: res.body['error']??"try again",isError: true);
                    }
                  }
                },
                child: SizedBox(
                  width: width-2,
                  height: height-2,
                  child: const Center(
                    child: Text("Add",
                      style: TextStyle(
                          color: AppColors.primary
                      ),),
                  ),
                ),
              ),
            ]
          ]else...[
            if(isDecrease)...[
              SizedBox(
                  width: (buttonSize),
                  height: (buttonSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: (buttonSize/1.5),
                          height: (buttonSize/1.5),
                          child: const CircularProgressIndicator(strokeWidth: 1,color: AppColors.primary,)),
                    ],
                  )),
            ]else...[
              CircleIconButton(
                buttonSize: buttonSize,
                onTap: () async{
                  setState(() {
                    isDecrease = true;
                  });
                 Response res = await Get.find<ApiClient>().putAPI(ApiProvider.updateCart, {
                    "id" : widget.cartId,
                    "quantityminus" : widget.quantity,
                  });
                  setState(() {
                    isDecrease = false;
                  });
                  if(widget.onUpdate != null){
                    if(res.statusCode == 200){
                      if(widget.quantity == 1){
                        Get.find<CartLogic>().getCart();
                      }
                      widget.onUpdate!(res.body);
                    }
                  }
                },
                iconData: FlutterRemix.subtract_line,
              ),
            ],
            const Spacer(),
            Center(
              child: Text("${widget.quantity}",
                style: const TextStyle(
                    color: AppColors.primary
                ),),
            ),
            const Spacer(),
            if((isIncrease))...[
              SizedBox(
                  width: (buttonSize),
                  height: (buttonSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: (buttonSize/1.5),
                          height: (buttonSize/1.5),
                          child: const CircularProgressIndicator(strokeWidth: 1,color: AppColors.primary,)),
                    ],
                  )),
            ]else...[
              CircleIconButton(
                onTap: () async{
                  setState(() {
                    isIncrease = true;
                  });
                  Response res = await Get.find<ApiClient>().putAPI(ApiProvider.updateCart, {
                    "id" : widget.cartId,
                    "quantity" : widget.quantity,
                  });
                  setState(() {
                    isIncrease = false;
                  });
                  if(widget.onUpdate != null){
                    if(res.statusCode == 200){
                      widget.onUpdate!(res.body);
                    }
                  }
                },
                buttonSize: buttonSize,
                iconData: FlutterRemix.add_line,
              ),
            ],
          ],
        ],
      ),
    );
  }
}
