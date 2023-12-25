import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/view/checkout/logic.dart';
import 'package:serviceocity/view/wallet/logic.dart';

import '../../theme/app_colors.dart';

enum PaymentMethod { COD, ONLINE, WALLET }

typedef OnPaymentTab = void Function(PaymentMethod? mode);

class PaymentMode extends StatefulWidget {
  final PaymentMethod? initialValue;
  final OnPaymentTab? onPaymentTab;

  const PaymentMode({Key? key, this.initialValue, this.onPaymentTab})
      : super(key: key);

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {

  PaymentMethod? selected;

  int? id;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue == PaymentMethod.COD) {
      selected = PaymentMethod.COD;
      id = 1;
    }
    if (widget.initialValue == PaymentMethod.ONLINE) {
      selected = PaymentMethod.ONLINE;
      id = 2;
    }
    if (widget.initialValue == PaymentMethod.WALLET) {
      selected = PaymentMethod.WALLET;
      id = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        const SizedBox(height: 15,),

        InkWell(
          onTap: () {
            selected = PaymentMethod.COD;
            id = 1;
            if (widget.onPaymentTab != null) {
              widget.onPaymentTab!(selected!);
            }
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 24,
                width: 24,
                child: Radio(
                  value: 1,
                  groupValue: id,
                  onChanged: (val) {
                    selected = PaymentMethod.COD;
                    id = 1;
                    if (widget.onPaymentTab != null) {
                      widget.onPaymentTab!(selected!);
                    }
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 10,),
              Text(
                'Cash on delivery',
                style: TextStyle(
                    color: AppColors.blackColor(),
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25,),

        InkWell(
          onTap: () {
            selected = PaymentMethod.ONLINE;
            id = 2;
            if (widget.onPaymentTab != null) {
              widget.onPaymentTab!(selected!);
            }
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 24,
                height: 24,
                child: Radio(
                  value: 2,
                  groupValue: id,
                  onChanged: (val) {
                    selected = PaymentMethod.ONLINE;
                    id = 2;
                    if (widget.onPaymentTab != null) {
                      widget.onPaymentTab!(selected!);
                    }
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 10,),
              Text(
                'Pay Now',
                style: TextStyle(
                    color: AppColors.blackColor(),
                    fontSize: 17,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25,),

        GetBuilder<WalletLogic>(
          assignId: true,
          builder: (logic) {
            double balance = double.tryParse(logic.wallet?.balance??"0")??0;
            bool isGraterThen = balance >= Get.find<CheckoutLogic>().checkoutData.total;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: isGraterThen ? () {
                    selected = PaymentMethod.WALLET;
                    id = 3;
                    if (widget.onPaymentTab != null) {
                      widget.onPaymentTab!(selected!);
                    }
                    setState(() {});
                  } : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Radio(
                          value: 3,
                          groupValue: id,
                          onChanged: isGraterThen ? (val) {
                            selected = PaymentMethod.WALLET;
                            id = 3;
                            if (widget.onPaymentTab != null) {
                              widget.onPaymentTab!(selected!);
                            }
                            setState(() {});
                          } : null,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        'Wallet',
                        style: TextStyle(
                            color: isGraterThen ? AppColors.blackColor() : AppColors.blackColor().withOpacity(0.5),
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    const SizedBox(width: 34,),
                    Text("$balance",
                      style: TextStyle(
                          color: isGraterThen || logic.wallet?.balance == null ?  Colors.black : Colors.red
                      ),),
                  ],
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 15,),

      ],
    );
  }
}
