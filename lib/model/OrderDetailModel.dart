/// id : 77
/// service_id : "5"
/// order_id : "servicoorder_657c7008491db"
/// user_id : "22"
/// address_id : "55"
/// unit_cost : "4.00"
/// category_id : "1"
/// tax : "5.00"
/// quantity : "1"
/// coupon_id : "4"
/// date : "Fri 15"
/// time : "11:30 PM"
/// order_status : "1"
/// zone_id : "6"
/// created_at : "2023-12-15T09:56:00.000000Z"
/// updated_at : "2023-12-15T09:56:00.000000Z"
/// service : {"id":5,"name":"admi"}
/// category : {"id":1,"name":"admin","subcategoriescount":1}

class OrderDetailModel {
  OrderDetailModel({
      this.id, 
      this.serviceId, 
      this.orderId, 
      this.userId, 
      this.addressId, 
      this.unitCost, 
      this.categoryId, 
      this.tax, 
      this.quantity, 
      this.couponId, 
      this.date, 
      this.time, 
      this.orderStatus, 
      this.zoneId, 
      this.createdAt, 
      this.updatedAt, 
      this.service, 
      this.category,});

  OrderDetailModel.fromJson(dynamic json) {
    id = json['id'];
    serviceId = json['service_id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    addressId = json['address_id'];
    userAddress = json['useraddress']?['address1'];
    unitCost = json['unit_cost'];
    categoryId = json['category_id'];
    tax = json['tax'];
    quantity = json['quantity'];
    couponId = json['coupon_id'];
    date = json['date'];
    time = json['time'];
    orderStatus = json['order_status'];
    zoneId = json['zone_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  int? id;
  String? serviceId;
  String? orderId;
  String? userId;
  String? addressId;
  String? userAddress;
  String? unitCost;
  String? categoryId;
  String? tax;
  String? quantity;
  String? couponId;
  String? date;
  String? time;
  String? orderStatus;
  String? zoneId;
  String? createdAt;
  String? updatedAt;
  Service? service;
  Category? category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['service_id'] = serviceId;
    map['order_id'] = orderId;
    map['user_id'] = userId;
    map['address_id'] = addressId;
    map['unit_cost'] = unitCost;
    map['category_id'] = categoryId;
    map['tax'] = tax;
    map['quantity'] = quantity;
    map['coupon_id'] = couponId;
    map['date'] = date;
    map['time'] = time;
    map['order_status'] = orderStatus;
    map['zone_id'] = zoneId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (service != null) {
      map['service'] = service?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    return map;
  }

}

/// id : 1
/// name : "admin"
/// subcategoriescount : 1

class Category {
  Category({
      this.id, 
      this.name, 
      this.subcategoriescount,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    subcategoriescount = json['subcategoriescount'];
  }
  int? id;
  String? name;
  int? subcategoriescount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['subcategoriescount'] = subcategoriescount;
    return map;
  }

}

/// id : 5
/// name : "admi"

class Service {
  Service({
      this.id, 
      this.name,});

  Service.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}