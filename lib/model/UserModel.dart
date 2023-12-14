/// id : 21
/// name : "chetan"
/// mobile : "6263563402"
/// email : "6263563402"
/// email_verified_at : null
/// image : null
/// country_code : null
/// address : {"id":1,"user_id":"21","address1":"Mahesh Nagar , 452001","address2":null,"name":"","landmark":"","type":"","city":"Indore","latitude":"22.715651896923","longitude":"75.838224405186","state":"Madhya Pradesh","country":"India","city_id":"1","zone_id":null,"is_active":"1","is_primary":"1","created_at":"2023-11-29T06:02:29.000000Z","updated_at":"2023-12-03T18:58:02.000000Z","deleted_at":null}
/// city : null
/// refer_code : null
/// otp : null
/// status : "0"
/// role_id : "5"
/// created_at : "2023-11-28T12:46:30.000000Z"
/// updated_at : "2023-11-28T12:46:30.000000Z"
/// deleted_at : null
/// my_refer_code : "MjEtNQ=="
/// primary_address : {"id":1,"user_id":"21","address1":"Mahesh Nagar , 452001","address2":null,"name":"","landmark":"","type":"","city":"Indore","latitude":"22.715651896923","longitude":"75.838224405186","state":"Madhya Pradesh","country":"India","city_id":"1","zone_id":null,"is_active":"1","is_primary":"1","created_at":"2023-11-29T06:02:29.000000Z","updated_at":"2023-12-03T18:58:02.000000Z","deleted_at":null}
/// myaddress : [{"id":1,"user_id":"21","address1":"Mahesh Nagar , 452001","address2":null,"name":"","landmark":"","type":"","city":"Indore","latitude":"22.715651896923","longitude":"75.838224405186","state":"Madhya Pradesh","country":"India","city_id":"1","zone_id":null,"is_active":"1","is_primary":"1","created_at":"2023-11-29T06:02:29.000000Z","updated_at":"2023-12-03T18:58:02.000000Z","deleted_at":null}]

class UserModel {
  UserModel({
      this.id, 
      this.name, 
      this.mobile, 
      this.email, 
      this.emailVerifiedAt, 
      this.image, 
      this.countryCode, 
      this.address, 
      this.city, 
      this.referCode, 
      this.otp, 
      this.status, 
      this.roleId, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.myReferCode, 
      this.primaryAddress, 
      this.myaddress,});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    image = json['image'];
    countryCode = json['country_code'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    city = json['city'];
    referCode = json['refer_code'];
    otp = json['otp'];
    status = json['status'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    myReferCode = json['my_refer_code'];
    primaryAddress = json['primary_address'] != null ? PrimaryAddress.fromJson(json['primary_address']) : null;
    if (json['myaddress'] != null) {
      myaddress = [];
      json['myaddress'].forEach((v) {
        myaddress?.add(Myaddress.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? mobile;
  String? email;
  dynamic emailVerifiedAt;
  dynamic image;
  dynamic countryCode;
  Address? address;
  dynamic city;
  dynamic referCode;
  dynamic otp;
  String? status;
  String? roleId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? myReferCode;
  PrimaryAddress? primaryAddress;
  List<Myaddress>? myaddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['image'] = image;
    map['country_code'] = countryCode;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['city'] = city;
    map['refer_code'] = referCode;
    map['otp'] = otp;
    map['status'] = status;
    map['role_id'] = roleId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['my_refer_code'] = myReferCode;
    if (primaryAddress != null) {
      map['primary_address'] = primaryAddress?.toJson();
    }
    if (myaddress != null) {
      map['myaddress'] = myaddress?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// user_id : "21"
/// address1 : "Mahesh Nagar , 452001"
/// address2 : null
/// name : ""
/// landmark : ""
/// type : ""
/// city : "Indore"
/// latitude : "22.715651896923"
/// longitude : "75.838224405186"
/// state : "Madhya Pradesh"
/// country : "India"
/// city_id : "1"
/// zone_id : null
/// is_active : "1"
/// is_primary : "1"
/// created_at : "2023-11-29T06:02:29.000000Z"
/// updated_at : "2023-12-03T18:58:02.000000Z"
/// deleted_at : null

class Myaddress {
  Myaddress({
      this.id, 
      this.userId, 
      this.address1, 
      this.address2, 
      this.name, 
      this.landmark, 
      this.type, 
      this.city, 
      this.latitude, 
      this.longitude, 
      this.state, 
      this.country, 
      this.cityId, 
      this.zoneId, 
      this.isActive, 
      this.isPrimary, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt});

  Myaddress.fromJson(dynamic json) {
   try{
     id = json['id'];
     userId = json['user_id'];
     address1 = json['address1'];
     address2 = json['address2'];
     name = json['name'];
     landmark = json['landmark'];
     type = json['type'];
     city = json['city'];
     latitude = double.tryParse(json['latitude'].toString());
     longitude = double.tryParse(json['longitude'].toString());
     state = json['state'];
     country = json['country'];
     cityId = int.tryParse(json['city_id'].toString());
     zoneId = int.tryParse(json['zone_id'].toString());
     isActive = int.tryParse(json['is_active'].toString());
     isPrimary = int.tryParse(json['is_primary'].toString());
     createdAt = json['created_at'];
     updatedAt = json['updated_at'];
     deletedAt = json['deleted_at'];
   }catch(e){
     print("DDDFDFDFF $e");
   }
  }
  int? id;
  String? userId;
  String? address1;
  String? address2;
  String? name;
  String? landmark;
  String? type;
  String? city;
  double? latitude;
  double? longitude;
  String? state;
  String? country;
  int? cityId;
  int? zoneId;
  int? isActive;
  int? isPrimary;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['address1'] = address1;
    map['address2'] = address2;
    map['name'] = name;
    map['landmark'] = landmark;
    map['type'] = type;
    map['city'] = city;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['state'] = state;
    map['country'] = country;
    map['city_id'] = cityId;
    map['zone_id'] = zoneId;
    map['is_active'] = isActive;
    map['is_primary'] = isPrimary;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}

/// id : 1
/// user_id : "21"
/// address1 : "Mahesh Nagar , 452001"
/// address2 : null
/// name : ""
/// landmark : ""
/// type : ""
/// city : "Indore"
/// latitude : "22.715651896923"
/// longitude : "75.838224405186"
/// state : "Madhya Pradesh"
/// country : "India"
/// city_id : "1"
/// zone_id : null
/// is_active : "1"
/// is_primary : "1"
/// created_at : "2023-11-29T06:02:29.000000Z"
/// updated_at : "2023-12-03T18:58:02.000000Z"
/// deleted_at : null

class PrimaryAddress {
  PrimaryAddress({
      this.id, 
      this.userId, 
      this.address1, 
      this.address2, 
      this.name, 
      this.landmark, 
      this.type, 
      this.city, 
      this.latitude, 
      this.longitude, 
      this.state, 
      this.country, 
      this.cityId, 
      this.zoneId, 
      this.isActive, 
      this.isPrimary, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  PrimaryAddress.fromJson(dynamic json) {
    try{
      id = json['id'];
      userId = json['user_id'];
      address1 = json['address1'];
      address2 = json['address2'];
      name = json['name'];
      landmark = json['landmark'];
      type = json['type'];
      city = json['city'];
      latitude = double.tryParse(json['latitude'].toString());
      longitude = double.tryParse(json['longitude'].toString());
       state = json['state'];
       country = json['country'];
       cityId = int.tryParse(json['city_id'].toString());
       zoneId = int.tryParse(json['zone_id'].toString());
       isActive = int.tryParse(json['is_active'].toString());
       isPrimary = int.tryParse(json['is_primary'].toString());
       createdAt = json['created_at'];
       updatedAt = json['updated_at'];
       deletedAt = json['deleted_at'];
    }catch(e){
      print("DDFFDFFDF $e");
    }
  }
  int? id;
  String? userId;
  String? address1;
  dynamic address2;
  String? name;
  String? landmark;
  String? type;
  String? city;
  double? latitude;
  double? longitude;
  String? state;
  String? country;
  int? cityId;
  int? zoneId;
  int? isActive;
  int? isPrimary;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['address1'] = address1;
    map['address2'] = address2;
    map['name'] = name;
    map['landmark'] = landmark;
    map['type'] = type;
    map['city'] = city;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['state'] = state;
    map['country'] = country;
    map['city_id'] = cityId;
    map['zone_id'] = zoneId;
    map['is_active'] = isActive;
    map['is_primary'] = isPrimary;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}

/// id : 1
/// user_id : "21"
/// address1 : "Mahesh Nagar , 452001"
/// address2 : null
/// name : ""
/// landmark : ""
/// type : ""
/// city : "Indore"
/// latitude : "22.715651896923"
/// longitude : "75.838224405186"
/// state : "Madhya Pradesh"
/// country : "India"
/// city_id : "1"
/// zone_id : null
/// is_active : "1"
/// is_primary : "1"
/// created_at : "2023-11-29T06:02:29.000000Z"
/// updated_at : "2023-12-03T18:58:02.000000Z"
/// deleted_at : null

class Address {
  Address({
      this.id, 
      this.userId, 
      this.address1, 
      this.address2, 
      this.name, 
      this.landmark, 
      this.type, 
      this.city, 
      this.latitude, 
      this.longitude, 
      this.state, 
      this.country, 
      this.cityId, 
      this.zoneId, 
      this.isActive, 
      this.isPrimary, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Address.fromJson(dynamic json) {
    try{
      id = json['id'];
      userId = json['user_id'];
      address1 = json['address1'];
      address2 = json['address2'];
      name = json['name'];
      landmark = json['landmark'];
      type = json['type'];
      city = json['city'];
      latitude = double.tryParse(json['latitude'].toString());
      longitude = double.tryParse(json['longitude'].toString());
      state = json['state'];
      country = json['country'];
      cityId = int.tryParse(json['city_id'].toString());
      zoneId = int.tryParse(json['zone_id'].toString());
      isActive = int.tryParse(json['is_active'].toString());
      isPrimary = int.tryParse(json['is_primary'].toString());
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      deletedAt = json['deleted_at'];
    }catch(e){
      //
    }
  }
  int? id;
  String? userId;
  String? address1;
  String? address2;
  String? name;
  String? landmark;
  String? type;
  String? city;
  double? latitude;
  double? longitude;
  String? state;
  String? country;
  int? cityId;
  int? zoneId;
  int? isActive;
  int? isPrimary;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['address1'] = address1;
    map['address2'] = address2;
    map['name'] = name;
    map['landmark'] = landmark;
    map['type'] = type;
    map['city'] = city;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['state'] = state;
    map['country'] = country;
    map['city_id'] = cityId;
    map['zone_id'] = zoneId;
    map['is_active'] = isActive;
    map['is_primary'] = isPrimary;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}