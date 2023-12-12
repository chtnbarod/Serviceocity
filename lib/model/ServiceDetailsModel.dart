import 'ServiceModel.dart';

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
/// childcategory : {"id":1,"name":"adminsubcat","category_id":"1","details":"<p>kp1234</p>","image":"uploads/images/1700555403AICOD ZONA (2).png","video":null,"city":"[\"1\"]","slug":"adminsubcat","status":"1","showvideo":"0","metakeywords":null,"metadescription":null,"min_charges":"0.00","created_at":"2023-11-21T08:30:03.000000Z","updated_at":"2023-11-21T08:30:03.000000Z","deleted_at":null,"childcategoriescount":1}
/// subcategory : {"id":1,"name":"adminsubcat","category_id":"1","details":"<p>kp1234</p>","image":"uploads/images/1700555403AICOD ZONA (2).png","video":null,"city":"[\"1\"]","slug":"adminsubcat","status":"1","showvideo":"0","metakeywords":null,"metadescription":null,"min_charges":"0.00","created_at":"2023-11-21T08:30:03.000000Z","updated_at":"2023-11-21T08:30:03.000000Z","deleted_at":null,"childcategoriescount":1}
/// category : {"id":1,"name":"admin","image":"uploads/images/1700555369AICOD ZONA (2).png","video":null,"details":"<p>testkp</p>","city":"[\"1\"]","slug":"admin","showvideo":"0","status":"1","metakeywords":null,"metadescription":null,"min_charges":"0.00","created_at":"2023-11-21T08:29:29.000000Z","updated_at":"2023-11-21T08:29:29.000000Z","deleted_at":null,"subcategoriescount":1}

class ServiceDetailsModel {
  ServiceDetailsModel({
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
      this.addons,
      this.cart,
      this.childcategory,
      this.subcategory, 
      this.category,});

  ServiceDetailsModel.fromJson(dynamic json) {
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
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    childcategory = json['childcategory'] != null ? Childcategory.fromJson(json['childcategory']) : null;
    subcategory = json['subcategory'] != null ? Subcategory.fromJson(json['subcategory']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
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
  Cart? cart;
  Childcategory? childcategory;
  Subcategory? subcategory;
  Category? category;
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
    if (childcategory != null) {
      map['childcategory'] = childcategory?.toJson();
    }
    if (subcategory != null) {
      map['subcategory'] = subcategory?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    return map;
  }

}


// "id": 23,
// "user_id": "21",
// "product_id": "10",
// "quantity": "1",
// "total_cost": "100",
// "created_at": "2023-12-11T05:55:09.000000Z",
// "updated_at": "2023-12-11T05:55:09.000000Z"

class Cart{
  Cart({
    this.id,
    this.quantity,
    this.productId,
    this.totalCost,
    this.userId,
    this.createdAt,
    this.updatedAt
});
  int? id;
  String? userId;
  String? productId;
  String? quantity;
  String? totalCost;
  String? updatedAt;
  String? createdAt;

  Cart.fromJson(dynamic json) {
    id = json['id'];
    userId = "${json['user_id']}";
    productId = "${json['product_id']}";
    quantity = "${json['quantity']}";
    totalCost = "${json['total_cost']}";
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['product_id'] = productId;
    map['quantity'] = quantity;
    map['total_cost'] = totalCost;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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

class Category {
  Category({
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

  Category.fromJson(dynamic json) {
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

/// id : 1
/// name : "adminsubcat"
/// category_id : "1"
/// details : "<p>kp1234</p>"
/// image : "uploads/images/1700555403AICOD ZONA (2).png"
/// video : null
/// city : "[\"1\"]"
/// slug : "adminsubcat"
/// status : "1"
/// showvideo : "0"
/// metakeywords : null
/// metadescription : null
/// min_charges : "0.00"
/// created_at : "2023-11-21T08:30:03.000000Z"
/// updated_at : "2023-11-21T08:30:03.000000Z"
/// deleted_at : null
/// childcategoriescount : 1

class Subcategory {
  Subcategory({
      this.id, 
      this.name, 
      this.categoryId, 
      this.details, 
      this.image, 
      this.video, 
      this.city, 
      this.slug, 
      this.status, 
      this.showvideo, 
      this.metakeywords, 
      this.metadescription, 
      this.minCharges, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.childcategoriescount,});

  Subcategory.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    details = json['details'];
    image = json['image'];
    video = json['video'];
    city = json['city'];
    slug = json['slug'];
    status = json['status'];
    showvideo = json['showvideo'];
    metakeywords = json['metakeywords'];
    metadescription = json['metadescription'];
    minCharges = json['min_charges'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    childcategoriescount = json['childcategoriescount'];
  }
  int? id;
  String? name;
  String? categoryId;
  String? details;
  String? image;
  dynamic video;
  String? city;
  String? slug;
  String? status;
  String? showvideo;
  dynamic metakeywords;
  dynamic metadescription;
  String? minCharges;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? childcategoriescount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category_id'] = categoryId;
    map['details'] = details;
    map['image'] = image;
    map['video'] = video;
    map['city'] = city;
    map['slug'] = slug;
    map['status'] = status;
    map['showvideo'] = showvideo;
    map['metakeywords'] = metakeywords;
    map['metadescription'] = metadescription;
    map['min_charges'] = minCharges;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['childcategoriescount'] = childcategoriescount;
    return map;
  }

}

/// id : 1
/// name : "adminsubcat"
/// category_id : "1"
/// details : "<p>kp1234</p>"
/// image : "uploads/images/1700555403AICOD ZONA (2).png"
/// video : null
/// city : "[\"1\"]"
/// slug : "adminsubcat"
/// status : "1"
/// showvideo : "0"
/// metakeywords : null
/// metadescription : null
/// min_charges : "0.00"
/// created_at : "2023-11-21T08:30:03.000000Z"
/// updated_at : "2023-11-21T08:30:03.000000Z"
/// deleted_at : null
/// childcategoriescount : 1

class Childcategory {
  Childcategory({
      this.id, 
      this.name, 
      this.categoryId, 
      this.details, 
      this.image, 
      this.video, 
      this.city, 
      this.slug, 
      this.status, 
      this.showvideo, 
      this.metakeywords, 
      this.metadescription, 
      this.minCharges, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.childcategoriescount,});

  Childcategory.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    details = json['details'];
    image = json['image'];
    video = json['video'];
    city = json['city'];
    slug = json['slug'];
    status = json['status'];
    showvideo = json['showvideo'];
    metakeywords = json['metakeywords'];
    metadescription = json['metadescription'];
    minCharges = json['min_charges'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    childcategoriescount = json['childcategoriescount'];
  }
  int? id;
  String? name;
  String? categoryId;
  String? details;
  String? image;
  dynamic video;
  String? city;
  String? slug;
  String? status;
  String? showvideo;
  dynamic metakeywords;
  dynamic metadescription;
  String? minCharges;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? childcategoriescount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category_id'] = categoryId;
    map['details'] = details;
    map['image'] = image;
    map['video'] = video;
    map['city'] = city;
    map['slug'] = slug;
    map['status'] = status;
    map['showvideo'] = showvideo;
    map['metakeywords'] = metakeywords;
    map['metadescription'] = metadescription;
    map['min_charges'] = minCharges;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['childcategoriescount'] = childcategoriescount;
    return map;
  }

}