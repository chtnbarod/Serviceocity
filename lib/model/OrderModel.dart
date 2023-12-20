/// id : 21
/// order_id : "servicoorder_657c477620185"
/// zone_id : "7"
/// subtotal : "1.00"
/// tax : "5.00"
/// total_price : "1.00"
/// assign_partner_id : null
/// type : "COD"
/// order_status : "1"
/// created_at : "2023-12-15T07:02:54.000000Z"
/// updated_at : "2023-12-15T07:02:54.000000Z"
/// service_name : "admin"
/// category_name : "admin"

class OrderModel {
  OrderModel({
      this.id, 
      this.orderId, 
      this.zoneId, 
      this.subtotal, 
      this.tax, 
      this.totalPrice, 
      this.assignPartnerId, 
      this.type, 
      this.orderStatus, 
      this.createdAt, 
      this.updatedAt, 
      this.serviceName, 
      this.categoryName,});

  OrderModel.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'];
    zoneId = json['zone_id'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    totalPrice = json['total_price'];
    assignPartnerId = json['assign_partner_id'];
    type = json['type'];
    orderStatus = json['order_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceName = json['service_name'];
    categoryName = json['category_name'];
  }
  int? id;
  String? orderId;
  String? zoneId;
  String? subtotal;
  String? tax;
  String? totalPrice;
  dynamic assignPartnerId;
  String? type;
  String? orderStatus;
  String? createdAt;
  String? updatedAt;
  String? serviceName;
  String? categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['zone_id'] = zoneId;
    map['subtotal'] = subtotal;
    map['tax'] = tax;
    map['total_price'] = totalPrice;
    map['assign_partner_id'] = assignPartnerId;
    map['type'] = type;
    map['order_status'] = orderStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['service_name'] = serviceName;
    map['category_name'] = categoryName;
    return map;
  }

}