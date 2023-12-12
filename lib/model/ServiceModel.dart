/// id : 1
/// name : "admin"
/// image : ["uploads/images/17011002520WhatsApp_Image_2023-11-27_at_12.32.30_PM-removebg-preview.png"]
/// video : null
/// details : "<p>test</p>"
/// rate_card : null
/// time : "90"
/// max_quantity : "10"
/// price : "200"
/// sale_price : "150"
/// slug : "admin"
/// city : "[\"1\"]"
/// status : "1"
/// category_id : "1"
/// subcategory_id : "1"
/// subchildcategory_id : "1"
/// metakeywords : null
/// metadescription : null
/// showvideo : "0"
/// created_at : "2023-11-27T15:50:52.000000Z"
/// updated_at : "2023-11-27T15:50:52.000000Z"
/// deleted_at : null
/// addons : [{"id":1,"name":"admin addon","image":"[\"uploads\\/images\\/17016756110goa-m.jpg\"]","video":null,"details":"<p>test</p>","rate_card":null,"time":"90","max_quantity":"10","price":"200","sale_price":"150","status":"0","showvideo":"0","service_id":"1","addon_id":"0","created_at":"2023-12-04T07:40:11.000000Z","updated_at":"2023-12-04T07:40:11.000000Z","deleted_at":null},{"id":2,"name":"admin","image":"[\"uploads\\/images\\/17016761330goa-m.jpg\"]","video":null,"details":"<p>test</p>","rate_card":null,"time":"90","max_quantity":"10","price":"200","sale_price":"150","status":"0","showvideo":"0","service_id":"1","addon_id":"0","created_at":"2023-12-04T07:48:53.000000Z","updated_at":"2023-12-04T07:48:53.000000Z","deleted_at":null}]

class ServiceModel {
  ServiceModel({
      this.id, 
      this.name, 
      this.image, 
      this.video, 
      this.details, 
      this.rateCard, 
      this.time, 
      this.maxQuantity, 
      this.price, 
      this.salePrice, 
      this.slug, 
      this.city, 
      this.status, 
      this.categoryId, 
      this.subcategoryId, 
      this.subchildcategoryId, 
      this.metakeywords, 
      this.metadescription, 
      this.showvideo, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.addons,});

  ServiceModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? json['image'].cast<String>() : [];
    video = json['video'];
    details = json['details'];
    rateCard = json['rate_card'];
    time = json['time'];
    maxQuantity = json['max_quantity'];
    price = json['price'];
    salePrice = json['sale_price'];
    slug = json['slug'];
    city = json['city'];
    status = json['status'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subchildcategoryId = json['subchildcategory_id'];
    metakeywords = json['metakeywords'];
    metadescription = json['metadescription'];
    showvideo = json['showvideo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['addons'] != null) {
      addons = [];
      json['addons'].forEach((v) {
        addons?.add(Addons.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  List<String>? image;
  dynamic video;
  String? details;
  dynamic rateCard;
  String? time;
  String? maxQuantity;
  String? price;
  String? salePrice;
  String? slug;
  String? city;
  String? status;
  String? categoryId;
  String? subcategoryId;
  String? subchildcategoryId;
  dynamic metakeywords;
  dynamic metadescription;
  String? showvideo;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<Addons>? addons;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['video'] = video;
    map['details'] = details;
    map['rate_card'] = rateCard;
    map['time'] = time;
    map['max_quantity'] = maxQuantity;
    map['price'] = price;
    map['sale_price'] = salePrice;
    map['slug'] = slug;
    map['city'] = city;
    map['status'] = status;
    map['category_id'] = categoryId;
    map['subcategory_id'] = subcategoryId;
    map['subchildcategory_id'] = subchildcategoryId;
    map['metakeywords'] = metakeywords;
    map['metadescription'] = metadescription;
    map['showvideo'] = showvideo;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (addons != null) {
      map['addons'] = addons?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "admin addon"
/// image : "[\"uploads\\/images\\/17016756110goa-m.jpg\"]"
/// video : null
/// details : "<p>test</p>"
/// rate_card : null
/// time : "90"
/// max_quantity : "10"
/// price : "200"
/// sale_price : "150"
/// status : "0"
/// showvideo : "0"
/// service_id : "1"
/// addon_id : "0"
/// created_at : "2023-12-04T07:40:11.000000Z"
/// updated_at : "2023-12-04T07:40:11.000000Z"
/// deleted_at : null

class Addons {
  Addons({
      this.id, 
      this.name, 
      this.image, 
      this.video, 
      this.details, 
      this.rateCard, 
      this.time, 
      this.maxQuantity, 
      this.price, 
      this.salePrice, 
      this.status, 
      this.showvideo, 
      this.serviceId, 
      this.addonId, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Addons.fromJson(dynamic json) {
    try{
      id = json['id'];
      name = json['name'];
      video = json['video'];
      details = json['details'];
      rateCard = json['rate_card'];
      time = json['time'];
      maxQuantity = json['max_quantity'];
      price = json['price'];
      salePrice = json['sale_price'];
      status = json['status'];
      showvideo = json['showvideo'];
      serviceId = json['service_id'];
      addonId = json['addon_id'];
      image = json['image'] != null ? json['image'].cast<String>() : [];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      deletedAt = json['deleted_at'];
    }catch(e){
      print("json_image $e");
    }
  }
  int? id;
  String? name;
  List<String>? image;
  dynamic video;
  String? details;
  dynamic rateCard;
  String? time;
  String? maxQuantity;
  String? price;
  String? salePrice;
  String? status;
  String? showvideo;
  String? serviceId;
  String? addonId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['video'] = video;
    map['details'] = details;
    map['rate_card'] = rateCard;
    map['time'] = time;
    map['max_quantity'] = maxQuantity;
    map['price'] = price;
    map['sale_price'] = salePrice;
    map['status'] = status;
    map['showvideo'] = showvideo;
    map['service_id'] = serviceId;
    map['addon_id'] = addonId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}