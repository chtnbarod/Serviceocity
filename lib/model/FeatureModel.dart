/// id : 1
/// title : "Diwali Offer"
/// details : "offer"
/// feature_cats : [{"id":1,"name":"admin","image":"uploads/images/1700555369AICOD ZONA (2).png","video":null,"details":"<p>testkp</p>","city":"[\"1\"]","slug":"admin","showvideo":"0","status":"1","metakeywords":null,"metadescription":null,"min_charges":"0.00","created_at":"2023-11-21T08:29:29.000000Z","updated_at":"2023-11-21T08:29:29.000000Z","deleted_at":null,"subcategoriescount":1}]
/// feature_services : [{"id":1,"name":"admin","image":["uploads/images/17011002520WhatsApp_Image_2023-11-27_at_12.32.30_PM-removebg-preview.png"],"video":null,"details":"<p>test</p>","rate_card":null,"time":"90","max_quantity":"10","price":"1","sale_price":"0","slug":"admin","city":"[\"1\"]","status":"1","parent_id":null,"category_id":"1","subcategory_id":"1","subchildcategory_id":"1","metakeywords":null,"metadescription":null,"showvideo":"0","created_at":"2023-11-27T15:50:52.000000Z","updated_at":"2023-11-27T15:50:52.000000Z","deleted_at":null}]
/// status : "1"
/// start : null
/// end : null
/// created_at : "2023-11-27T15:51:47.000000Z"
/// updated_at : "2023-11-27T15:51:47.000000Z"
/// deleted_at : null

class FeatureModel {
  FeatureModel({
      this.id, 
      this.title, 
      this.details, 
      this.featureCats, 
      this.featureServices, 
      this.status, 
      this.start, 
      this.end, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  FeatureModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    if (json['feature_cats'] != null) {
      featureCats = [];
      json['feature_cats'].forEach((v) {
        featureCats?.add(FeatureCats.fromJson(v));
      });
    }
    if (json['feature_services'] != null) {
      featureServices = [];
      json['feature_services'].forEach((v) {
        featureServices?.add(FeatureServices.fromJson(v));
      });
    }
    status = json['status'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  int? id;
  String? title;
  String? details;
  List<FeatureCats>? featureCats;
  List<FeatureServices>? featureServices;
  String? status;
  dynamic start;
  dynamic end;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['details'] = details;
    if (featureCats != null) {
      map['feature_cats'] = featureCats?.map((v) => v.toJson()).toList();
    }
    if (featureServices != null) {
      map['feature_services'] = featureServices?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['start'] = start;
    map['end'] = end;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}

/// id : 1
/// name : "admin"
/// image : ["uploads/images/17011002520WhatsApp_Image_2023-11-27_at_12.32.30_PM-removebg-preview.png"]
/// video : null
/// details : "<p>test</p>"
/// rate_card : null
/// time : "90"
/// max_quantity : "10"
/// price : "1"
/// sale_price : "0"
/// slug : "admin"
/// city : "[\"1\"]"
/// status : "1"
/// parent_id : null
/// category_id : "1"
/// subcategory_id : "1"
/// subchildcategory_id : "1"
/// metakeywords : null
/// metadescription : null
/// showvideo : "0"
/// created_at : "2023-11-27T15:50:52.000000Z"
/// updated_at : "2023-11-27T15:50:52.000000Z"
/// deleted_at : null

class FeatureServices {
  FeatureServices({
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
      this.parentId, 
      this.categoryId, 
      this.subcategoryId, 
      this.subchildcategoryId, 
      this.metakeywords, 
      this.metadescription, 
      this.showvideo, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  FeatureServices.fromJson(dynamic json) {
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
    parentId = json['parent_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subchildcategoryId = json['subchildcategory_id'];
    metakeywords = json['metakeywords'];
    metadescription = json['metadescription'];
    showvideo = json['showvideo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
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
  dynamic parentId;
  String? categoryId;
  String? subcategoryId;
  String? subchildcategoryId;
  dynamic metakeywords;
  dynamic metadescription;
  String? showvideo;
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
    map['slug'] = slug;
    map['city'] = city;
    map['status'] = status;
    map['parent_id'] = parentId;
    map['category_id'] = categoryId;
    map['subcategory_id'] = subcategoryId;
    map['subchildcategory_id'] = subchildcategoryId;
    map['metakeywords'] = metakeywords;
    map['metadescription'] = metadescription;
    map['showvideo'] = showvideo;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}

/// id : 1
/// name : "admin"
/// image : "uploads/images/1700555369AICOD ZONA (2).png"
/// video : null
/// details : "<p>testkp</p>"
/// city : "[\"1\"]"
/// slug : "admin"
/// showvideo : "0"
/// status : "1"
/// metakeywords : null
/// metadescription : null
/// min_charges : "0.00"
/// created_at : "2023-11-21T08:29:29.000000Z"
/// updated_at : "2023-11-21T08:29:29.000000Z"
/// deleted_at : null
/// subcategoriescount : 1

class FeatureCats {
  FeatureCats({
      this.id, 
      this.name, 
      this.image, 
      this.video, 
      this.details, 
      this.city, 
      this.slug, 
      this.showvideo, 
      this.status, 
      this.metakeywords, 
      this.metadescription, 
      this.minCharges, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.subcategoriescount,});

  FeatureCats.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    video = json['video'];
    details = json['details'];
    city = json['city'];
    slug = json['slug'];
    showvideo = json['showvideo'];
    status = json['status'];
    metakeywords = json['metakeywords'];
    metadescription = json['metadescription'];
    minCharges = json['min_charges'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    subcategoriescount = json['subcategoriescount'];
  }
  int? id;
  String? name;
  String? image;
  dynamic video;
  String? details;
  String? city;
  String? slug;
  String? showvideo;
  String? status;
  dynamic metakeywords;
  dynamic metadescription;
  String? minCharges;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? subcategoriescount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['video'] = video;
    map['details'] = details;
    map['city'] = city;
    map['slug'] = slug;
    map['showvideo'] = showvideo;
    map['status'] = status;
    map['metakeywords'] = metakeywords;
    map['metadescription'] = metadescription;
    map['min_charges'] = minCharges;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['subcategoriescount'] = subcategoriescount;
    return map;
  }

}