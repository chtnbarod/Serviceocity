/// id : 9
/// service_id : "9"
/// order_id : "servicoorder_658c0db6cfb5c"
/// user_id : "21"
/// address_id : "62"
/// unit_cost : "300.00"
/// category_id : "1"
/// tax : null
/// quantity : "3"
/// coupon_id : "0"
/// date : "2023-12-27"
/// time : "90"
/// order_status : "0"
/// zone_id : "8"
/// created_at : "2023-12-09T09:08:41.000000Z"
/// updated_at : "2023-12-09T09:08:41.000000Z"
/// name : "car reparing services"
/// image : "[\"uploads\\/images\\/1702132721099-rupee-off-sale-discount-260nw-2160791255.png\",\"uploads\\/images\\/17021327211AICOD ZONA (2).png\",\"uploads\\/images\\/17021327212AICOD ZONA (3).png\"]"
/// video : null
/// details : "<p>car reparing service we offer at low price in india</p>"
/// rate_card : null
/// max_quantity : "80"
/// price : "500"
/// sale_price : "300"
/// tax_type : null
/// slug : "car-reparing-services"
/// city : "[\"1\",\"2\",\"4\",\"5\"]"
/// status : "1"
/// parent_id : null
/// subcategory_id : "1"
/// subchildcategory_id : "1"
/// metakeywords : null
/// metadescription : null
/// showvideo : "0"
/// deleted_at : null

class RecentOrderModel {
  RecentOrderModel({
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
      this.name, 
      this.image, 
      this.video, 
      this.details, 
      this.rateCard, 
      this.maxQuantity, 
      this.price, 
      this.salePrice, 
      this.taxType, 
      this.slug, 
      this.city, 
      this.status, 
      this.parentId, 
      this.subcategoryId, 
      this.subchildcategoryId, 
      this.metakeywords, 
      this.metadescription, 
      this.showvideo, 
      this.deletedAt,});

  RecentOrderModel.fromJson(dynamic json) {
    try{
      id = json['id'];
      serviceId = json['service_id'];
      orderId = json['order_id'];
      userId = json['user_id'];
      addressId = json['address_id'];
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
      name = json['name'];
      video = json['video'];
      details = json['details'];
      rateCard = json['rate_card'];
      maxQuantity = json['max_quantity'];
      price = json['price'];
      salePrice = json['sale_price'];
      taxType = json['tax_type'];
      slug = json['slug'];
      city = json['city'];
      status = json['status'];
      parentId = json['parent_id'];
      subcategoryId = json['subcategory_id'];
      subchildcategoryId = json['subchildcategory_id'];
      metakeywords = json['metakeywords'];
      metadescription = json['metadescription'];
      showvideo = json['showvideo'];
      deletedAt = json['deleted_at'];
      //image = json['image'] != null ? json['image'].cast<String>() : [];
    }catch(e){
      print("Sdsdddsssdsd $e");
    }
  }
  int? id;
  String? serviceId;
  String? orderId;
  String? userId;
  String? addressId;
  String? unitCost;
  String? categoryId;
  dynamic tax;
  String? quantity;
  String? couponId;
  String? date;
  String? time;
  String? orderStatus;
  String? zoneId;
  String? createdAt;
  String? updatedAt;
  String? name;
  List<String>? image;
  dynamic video;
  String? details;
  dynamic rateCard;
  String? maxQuantity;
  String? price;
  String? salePrice;
  dynamic taxType;
  String? slug;
  String? city;
  String? status;
  dynamic parentId;
  String? subcategoryId;
  String? subchildcategoryId;
  dynamic metakeywords;
  dynamic metadescription;
  String? showvideo;
  dynamic deletedAt;

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
    map['name'] = name;
    map['image'] = image;
    map['video'] = video;
    map['details'] = details;
    map['rate_card'] = rateCard;
    map['max_quantity'] = maxQuantity;
    map['price'] = price;
    map['sale_price'] = salePrice;
    map['tax_type'] = taxType;
    map['slug'] = slug;
    map['city'] = city;
    map['status'] = status;
    map['parent_id'] = parentId;
    map['subcategory_id'] = subcategoryId;
    map['subchildcategory_id'] = subchildcategoryId;
    map['metakeywords'] = metakeywords;
    map['metadescription'] = metadescription;
    map['showvideo'] = showvideo;
    map['deleted_at'] = deletedAt;
    return map;
  }

}