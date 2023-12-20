import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:serviceocity/view/map/AddressListModel.dart';

import '../../utils/assets.dart';

class MyMapLogic extends GetxController{


  GoogleMapController? _controller;
  GoogleMapController? get getController => _controller;

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  AddressListModel? addressListModel;

  Set<Marker> markers = {};
  MarkerId markerId = const MarkerId("MARKER@1");

  LatLng latLng = const LatLng(22.715651896922722,75.83822440518583);

  void initMap({ double? lat, double? long }){
    if(lat != null && long != null){
      latLng = LatLng(lat,long);
    }
    markers.add(
      Marker(markerId: markerId,
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),),);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if(!kDebugMode){
          getAddressLocation();
        }
      });
  }

  void onCameraMove(LatLng position){
    latLng = position;

    markers.clear();
    markers.add(
      Marker(markerId: markerId,
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),),);

    _moveToLocation();
    getAddressLocation();
  }

  // Function to move the camera to a specific location
  Future<void> _moveToLocation() async {
    if (_controller != null) {
      double zoomLevel = await _controller!.getZoomLevel();
      await _controller!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng,zoom: zoomLevel),
      ));
    }
  }

  bool process = false;
  Future<void> getAddressLocation() async{
    if(process) return;
    process = true;
    update();

    await Dio().get("https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$googleAPIKey").then((value) => {
      if(value.data["status"] == "OK"){
        addressListModel = getCity(value.data['results']),
      },
    }).whenComplete(() => {
      process = false,
      print("addressListModel ${addressListModel?.toJson()}"),
      update(),
    });
  }

  getPlaceData(String? placeId) async{
    var url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$googleAPIKey";
    await Dio().get(url).then((value) => {
      if(value.statusCode == 200 && value.data?['result']?['geometry']?['location'] != null){
        onCameraMove(LatLng(value.data['result']['geometry']['location']['lat'], value.data['result']['geometry']['location']['lng'])),
      }
    });
  }

  AddressListModel getCity(dynamic json){
    String city = "";
    String state = "";
    String country = "";
    json[0]['address_components'].forEach((v) {
      if(v['types'][0] == 'administrative_area_level_1'){
        state = v['long_name'];
      }
      if(v['types'][0] == 'administrative_area_level_3'){
        city = v['long_name'];
      }
      if(v['types'][0] == 'country'){
        country = v['long_name'];
      }
    });

    if(city.isEmpty){
      json[1]['address_components'].forEach((v) {
        if(v['types'][0] == 'administrative_area_level_3'){
          city = v['long_name'];
        }
      });
    }

    if(city.isEmpty){
      json[2]['address_components'].forEach((v) {
        if(v['types'][0] == 'administrative_area_level_3'){
          city = v['long_name'];
        }
      });
    }

    return AddressListModel.fromJson({
      "address1" : json[0]['formatted_address'],
      "city" : city,
      "state" : state,
      "country" : country,
      "latitude" : latLng.latitude,
      "longitude" : latLng.longitude
    });
  }

  @override
  void onClose() {
    _controller?.dispose();
    super.onClose();
  }
}