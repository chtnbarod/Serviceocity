import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/view/service/widget/vertical_addon.dart';

import '../../../model/ServiceModel.dart';

class AddonsService extends StatelessWidget {
  final List<Addons>? list;
  const AddonsService({super.key,this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Get.height/1.2,
        minHeight: Get.height/2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: list?.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return VerticalAddon(addons: list?[index],);
        },
      ),
    );
  }
}
