// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
// import 'package:serviceocity/widget/custom_button.dart';
//
// import '../../../model/UserModel.dart';
// import '../../../utils/assets.dart';
// import '../../../widget/custom_input.dart';
// import '../logic.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
//
//
//
// class Location extends StatefulWidget {
//   final PrimaryAddress? primaryAddress;
//   const Location({super.key,this.primaryAddress});
//
//   @override
//   State<Location> createState() => _LocationState();
// }
//
// class _LocationState extends State<Location> {
//
//
//   @override
//   void initState() {
//     Get.find<HomeLogic>().initMap(long: widget.primaryAddress?.longitude,lat: widget.primaryAddress?.latitude);
//     super.initState();
//     if(widget.primaryAddress != null){
//       nameController.text = widget.primaryAddress?.name??"";
//       landmarkController.text = widget.primaryAddress?.landmark??"";
//       address2Controller.text = widget.primaryAddress?.address2??"";
//     }
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.find<HomeLogic>().getAddressLocation();
//     });
//   }
//
//   TextEditingController controller = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController landmarkController = TextEditingController();
//   TextEditingController address2Controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         height: Get.height,
//         width: Get.width,
//         decoration: const BoxDecoration(
//             color: Colors.white,
//         ),
//         child: GetBuilder<HomeLogic>(
//           assignId: true,
//           builder: (logic) {
//             return Stack(
//               children: [
//                 Column(
//                   children: [
//
//                     Flexible(
//                       child: GoogleMap(
//                         myLocationEnabled: false,
//                         initialCameraPosition: CameraPosition(
//                             target: logic.latLong, zoom: 12),
//                         mapType: MapType.normal,
//                         onMapCreated: logic.onMapCreated,
//                         markers: logic.markers,
//                         onTap: (LatLng lat){
//                           logic.onCameraMove(lat);
//                         },
//                       ),
//                     ),
//
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 20),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: 70,
//                                     height: 4,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                            if(logic.place != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10),
//                               child: Text("${logic.place?.subLocality??""} ${logic.place?.thoroughfare??""}, ${logic.place?.postalCode ?? ""}".trim()),
//                             ),
//
//                             const SizedBox(height: 20,),
//
//                             CustomInput(
//                               hintText: "Address 2",
//                               fontSize: 16,
//                               textController: address2Controller
//                             ),
//
//                             const SizedBox(height: 20,),
//
//                             CustomInput(
//                               hintText: "Landmark (Optional)",
//                               fontSize: 16,
//                               textController: landmarkController,
//                             ),
//
//                             const SizedBox(height: 20,),
//
//                             CustomInput(
//                               hintText: "Name",
//                               fontSize: 16,
//                               textController: nameController,
//                             ),
//
//                             const SizedBox(height: 20,),
//
//                             const Text("Save as"),
//
//                             const SizedBox(height: 20,),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 CustomButton(
//                                   height: 30,
//                                   text: "Home",
//                                   horizontalPadding: 20,
//                                   onTap: (){
//                                     logic.addUserAddress('Home',context,address: address2Controller.text,landmark: landmarkController.text,name: nameController.text);
//                                   },
//                                   isLoading: logic.addingIndex == 'Home',
//                                   isEnable: logic.addingNow == false,
//                                 ),
//                                 const SizedBox(width: 10,),
//                                 CustomButton(
//                                   height: 30,
//                                   text: "Office",
//                                   horizontalPadding: 20,
//                                   onTap: (){
//                                     logic.addUserAddress('Office',context,address: address2Controller.text,landmark: landmarkController.text,name: nameController.text);
//                                   },
//                                   isLoading: logic.addingIndex == 'Office',
//                                   isEnable: logic.addingNow == false,
//                                 ),
//                                 const SizedBox(width: 10,),
//                                 CustomButton(
//                                   height: 30,
//                                   text: "Other",
//                                   onTap: (){
//                                     logic.addUserAddress('Other',context,address: address2Controller.text,landmark: landmarkController.text,name: nameController.text);
//                                   },
//                                   horizontalPadding: 20,
//                                   isLoading: logic.addingIndex == 'Other',
//                                   isEnable: logic.addingNow == false,
//                                 ),
//                               ],
//                             ),
//
//                             const SizedBox(height: 20,),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 40,left: 10,right: 10),
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5)
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.search),
//                         const SizedBox(width: 5,),
//                         Flexible(
//                           child: GooglePlaceAutoCompleteTextField(
//                             textEditingController: controller,
//                             googleAPIKey: googleAPIKey,
//                             inputDecoration: const InputDecoration(
//                                 border: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 disabledBorder: InputBorder.none,
//                                 hintText: "Search",
//                             ),
//                             boxDecoration: const BoxDecoration(
//                               color: Colors.white
//                             ),
//                             isLatLngRequired: false,
//                             seperatedBuilder: const Divider(),
//                             itemClick: (Prediction prediction){
//                               controller.clear();
//                               FocusScope.of(context).unfocus();
//                               logic.getPlaceData(prediction.placeId);
//                             },
//                             isCrossBtnShown: true,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//     return GetBuilder<HomeLogic>(
//       assignId: true,
//       builder: (logic) {
//         return const Stack(
//           children: [
//
//
//
//
//           ],
//         );
//       },
//     );
//   }
// }
