import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/assets.dart';

class MyMapLogic extends GetxController{


  GoogleMapController? _controller;

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Placemark? place;

  Set<Marker> markers = {};
  MarkerId markerId = const MarkerId("MARKER@1");

  double lat = 22.715651896922722;
  double long = 75.83822440518583;

  void initMap({ double? lat, double? long }){
    print("latlatlat $lat");
    if(lat != null && long != null){
      this.lat = lat;
      this.long = long;
    }
    markers.add(
      Marker(markerId: markerId,
        position: LatLng(this.lat,this.long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),),);
    update();
  }

  void onCameraMove(LatLng position){
    lat = position.latitude;
    long = position.longitude;

    markers.clear();
    markers.add(
      Marker(markerId: markerId,
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),),);

    _moveToLocation(position);
    update();
    getAddressLocation();
  }

  // Function to move the camera to a specific location
  Future<void> _moveToLocation(LatLng location) async {
    if (_controller != null) {
      await _controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 15.0, // You can set the desired zoom level
        ),
      ));
    }
  }

  bool process = false;
  Future<void> getAddressLocation() async{
    print("STEP::A");
    if(process) return;
    process = true;
    update();
    await placemarkFromCoordinates(lat, long).then((value) => {
      place = value[0],
      update(),
      print("STEP::AC $value"),
    },onError: (e){
      print("STEP::AM $e");
    }).catchError((e){
      process = false;
      print("STEP::Ax $e");
    }).whenComplete(() => {
      process = false,
      update(),
      print("STEP::AZ")
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


}