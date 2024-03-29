import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/model/ServiceDetailsModel.dart';
import 'package:serviceocity/view/service/widget/vertical_addon.dart';

import '../../../model/ServiceModel.dart';

class AddonsService extends StatefulWidget {
  final List<Addons>? list;
  final Function(dynamic json,int index)? onUpdate;
  final Function(dynamic json,int index)? onAddToCart;
  const AddonsService({super.key,this.list,this.onUpdate,this.onAddToCart});

  @override
  State<AddonsService> createState() => _AddonsServiceState();
}

class _AddonsServiceState extends State<AddonsService> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Get.height/1.2,
        minHeight: Get.height/2,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: widget.list?.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return VerticalAddon(addons: widget.list?[index],
            onAddToCart: (dynamic json){
              setState(() {
                widget.list![index].cart = Cart.fromJson(json);
              });
            if(widget.onAddToCart != null){
              widget.onAddToCart!(json,index);
             }
            },
            onUpdate: (dynamic json){
              setState(() {
                widget.list![index].cart?.quantity = "${json['quantity']}";
              });
              if(widget.onUpdate != null){
                widget.onUpdate!(json,index);
              }
            },
          );
        },
      ),
    );
  }
}
