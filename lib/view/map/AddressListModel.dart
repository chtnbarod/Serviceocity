/// id : 1
/// address1 : "dfgg"
/// city : "place!.locality"
/// state : "place!.administrativeArea"
/// country : "place dfg"
/// latitude : 20.5555
/// longitude : 52.00001
/// address2 : "dfgdfg"
/// landmark : "d"
/// name : "name"
/// type : "dfgdfg"

class AddressListModel {
  AddressListModel({
      this.id, 
      this.address1, 
      this.city, 
      this.state, 
      this.country, 
      this.latitude, 
      this.longitude, 
      this.address2, 
      this.landmark, 
      this.name, 
      this.type,});

  AddressListModel.fromJson(dynamic json) {
    try{
      id = json['id'];
      address1 = json['address1'];
      city = json['city'];
      state = json['state'];
      country = json['country'];
      latitude = json['latitude'];
      longitude = json['longitude'];
      address2 = json['address2'];
      landmark = json['landmark'];
      name = json['name'];
      type = json['type'];
    }catch(e){
      //
    }
  }
  int? id;
  String? address1;
  String? city;
  String? state;
  String? country;
  double? latitude;
  double? longitude;
  String? address2;
  String? landmark;
  String? name;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['address1'] = address1;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['address2'] = address2;
    map['landmark'] = landmark;
    map['name'] = name;
    map['type'] = type;
    return map;
  }

}