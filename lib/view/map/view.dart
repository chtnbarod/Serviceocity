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

class MyMap extends StatefulWidget {
  final double? lat;
  final double? long;
  final Function(dynamic json)? callback;
  const MyMap({super.key, this.callback,this.lat,this.long});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {


  @override
  void initState() {
    Get.find<MyMapLogic>().initMap(lat: widget.lat,long: widget.long);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<MyMapLogic>().getAddressLocation();
    });
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
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(logic.lat, logic.long),
                              zoom: 15),
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

                                if(logic.place != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("${logic.place?.subLocality??""} ${logic.place?.thoroughfare??""}, ${logic.place?.postalCode ?? ""}".trim()),
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
                                        if(widget.callback != null){
                                          widget.callback!(
                                              {
                                                "address1": "${logic.place!.subLocality??""} ${logic.place!.thoroughfare??""}, ${logic.place!.postalCode ?? ""}".trim(),
                                                "city": logic.place!.locality,
                                                "latitude": logic.lat,
                                                "longitude": logic.long,
                                                "state": logic.place!.administrativeArea,
                                                "country": logic.place!.country,
                                                "type": "home",
                                                "landmark": landmarkController.text,
                                                "name": nameController.text,
                                                "address2": address2Controller.text,
                                              }
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
                                        if(widget.callback != null){
                                          widget.callback!(
                                              {
                                                "address1": "${logic.place!.subLocality??""} ${logic.place!.thoroughfare??""}, ${logic.place!.postalCode ?? ""}".trim(),
                                                "city": logic.place!.locality,
                                                "latitude": logic.lat,
                                                "longitude": logic.long,
                                                "state": logic.place!.administrativeArea,
                                                "country": logic.place!.country,
                                                "type": "office",
                                                "landmark": landmarkController.text,
                                                "name": nameController.text,
                                                "address2": address2Controller.text,
                                              }
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
                                        if(widget.callback != null){
                                          widget.callback!(
                                              {
                                                "address1": "${logic.place!.subLocality??""} ${logic.place!.thoroughfare??""}, ${logic.place!.postalCode ?? ""}".trim(),
                                                "city": logic.place!.locality,
                                                "latitude": logic.lat,
                                                "longitude": logic.long,
                                                "state": logic.place!.administrativeArea,
                                                "country": logic.place!.country,
                                                "type": "other",
                                                "landmark": landmarkController.text,
                                                "name": nameController.text,
                                                "address2": address2Controller.text,
                                              }
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
