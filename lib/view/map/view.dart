import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:serviceocity/view/home/logic.dart';
import 'package:serviceocity/view/map/logic.dart';
import 'package:serviceocity/widget/custom_button.dart';

import '../../utils/assets.dart';
import '../../widget/custom_input.dart';
import 'AddressListModel.dart';

class MyMap extends StatefulWidget {
  final AddressListModel? addressListModel;
  final Function(AddressListModel addressListModel)? callback;
  const MyMap({super.key, this.callback,this.addressListModel,});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {


  @override
  void initState() {
    if(widget.addressListModel != null){
      nameController.text = widget.addressListModel?.name??"";
      landmarkController.text = widget.addressListModel?.landmark??"";
      address2Controller.text = widget.addressListModel?.address2??"";
    }

    super.initState();
    Get.find<MyMapLogic>().initMap(lat: widget.addressListModel?.latitude,
        long: widget.addressListModel?.longitude);

  }

  TextEditingController controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Choose Location"),
          centerTitle: true,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: GetBuilder<MyMapLogic>(
            assignId: true,
            builder: (logic) {
              return Stack(
                children: [

                  Column(
                    children: [

                      Flexible(
                        child: GoogleMap(
                          myLocationEnabled: false,
                          initialCameraPosition: CameraPosition(target: logic.latLng, zoom: 10),
                          mapType: MapType.normal,
                          onMapCreated: logic.onMapCreated,
                          markers: logic.markers,
                          onTap: (LatLng lat) {
                            logic.onCameraMove(lat);
                          },
                        ),
                      ),

                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 4,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                if(logic.addressListModel != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(logic.addressListModel?.address1??""),
                                  ),

                                const SizedBox(height: 20,),

                                CustomInput(
                                    hintText: "Address 2",
                                    fontSize: 16,
                                    textController: address2Controller
                                ),

                                const SizedBox(height: 20,),

                                CustomInput(
                                  hintText: "Landmark (Optional)",
                                  fontSize: 16,
                                  textController: landmarkController,
                                ),

                                const SizedBox(height: 20,),

                                CustomInput(
                                  hintText: "Name",
                                  fontSize: 16,
                                  textController: nameController,
                                ),

                                const SizedBox(height: 20,),

                                const Text("Save as"),

                                const SizedBox(height: 20,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomButton(
                                      height: 30,
                                      text: "Home",
                                      horizontalPadding: 20,
                                      onTap: () {
                                        if(widget.callback != null && logic.addressListModel != null){
                                          widget.callback!(logic.addressListModel!
                                            ..id = widget.addressListModel?.id
                                            ..type = "Home"
                                            ..address2 = address2Controller.text
                                            ..landmark = landmarkController.text
                                            ..name = nameController.text
                                          );
                                          Get.back();
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 10,),
                                    CustomButton(
                                      height: 30,
                                      text: "Office",
                                      horizontalPadding: 20,
                                      onTap: () {
                                        if(widget.callback != null && logic.addressListModel != null){
                                          widget.callback!(logic.addressListModel!
                                            ..id = widget.addressListModel?.id
                                            ..type = "Office"
                                            ..address2 = address2Controller.text
                                            ..landmark = landmarkController.text
                                            ..name = nameController.text
                                          );
                                          Get.back();
                                        }
                                      },

                                    ),
                                    const SizedBox(width: 10,),
                                    CustomButton(
                                      height: 30,
                                      text: "Other",
                                      onTap: () {
                                        if(widget.callback != null && logic.addressListModel != null){
                                          widget.callback!(logic.addressListModel!
                                            ..id = widget.addressListModel?.id
                                            ..type = "Other"
                                            ..address2 = address2Controller.text
                                            ..landmark = landmarkController.text
                                            ..name = nameController.text
                                          );
                                          Get.back();
                                        }
                                      },
                                      horizontalPadding: 20,

                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(width: 5,),
                          Flexible(
                            child: GooglePlaceAutoCompleteTextField(
                              textEditingController: controller,
                              googleAPIKey: googleAPIKey,
                              inputDecoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: "Search",
                              ),
                              boxDecoration: const BoxDecoration(
                                  color: Colors.white
                              ),
                              isLatLngRequired: false,
                              seperatedBuilder: const Divider(),
                              itemClick: (Prediction prediction){
                                controller.clear();
                                FocusScope.of(context).unfocus();
                                logic.getPlaceData(prediction.placeId);
                              },
                              isCrossBtnShown: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              );
            },
          ),
        ),
      ),
    );
  }

}
