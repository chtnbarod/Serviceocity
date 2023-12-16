/// cart_id : "34"
/// id : 1
/// user_id : "21"
/// product_id : "1"
/// quantity : "2"
/// total_cost : "2"
/// created_at : "2023-11-27T15:50:52.000000Z"
/// updated_at : "2023-12-11T08:33:42.000000Z"
/// name : "admin"
/// image : ["uploads/images/17011002520WhatsApp_Image_2023-11-27_at_12.32.30_PM-removebg-preview.png"]
/// video : ""
/// details : "<p>test</p>"
/// rate_card : "uploads/rate_card/1702283622April_2017_1492167248__110.pdf"
/// time : "90"
/// max_quantity : "10"
/// price : "1"
/// sale_price : "0"
/// tax_type : "percentage"
/// tax : "5"
/// slug : "admin"
/// city : "[\"1\"]"
/// status : "1"
/// parent_id : null
/// category_id : "1"
/// subcategory_id : "1"
/// subchildcategory_id : "1"
/// metakeywords : null
/// metadescription : ""
/// showvideo : "0"
/// deleted_at : ""
/// cat_tax : "8"
/// min_charges : "500"

class CartModel {
  CartModel({
      this.cartId, 
      this.id, 
      this.userId, 
      this.productId, 
      this.quantity, 
      this.totalCost, 
      this.createdAt, 
      this.updatedAt, 
      this.name, 
      this.image, 
      this.video, 
      this.details, 
      this.rateCard, 
      this.time, 
      this.maxQuantity, 
      this.price, 
      this.salePrice, 
      this.taxType, 
      this.tax, 
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
      this.deletedAt, 
      this.catTax, 
      this.minCharges,});

  CartModel.fromJson(dynamic json) {
    cartId = json['cart_id'];
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    totalCost = json['total_cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    image = json['image'] != null ? json['image'].cast<String>() : [];
    video = json['video'];
    details = json['details'];
    rateCard = json['rate_card'];
    time = json['time'];
    maxQuantity = json['max_quantity'];
    price = json['price'];
    salePrice = json['sale_price'];
    taxType = json['tax_type'];
    tax = json['tax'];
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
    deletedAt = json['deleted_at'];
    catTax = json['cat_tax'];
    minCharges = json['min_charges'];
  }
  String? cartId;
  int? id;
  String? userId;
  String? productId;
  String? quantity;
  String? totalCost;
  String? createdAt;
  String? updatedAt;
  String? name;
  List<String>? image;
  String? video;
  String? details;
  String? rateCard;
  String? time;
  String? maxQuantity;
  String? price;
  String? salePrice;
  String? taxType;
  String? tax;
  String? slug;
  String? city;
  String? status;
  dynamic parentId;
  String? categoryId;
  String? subcategoryId;
  String? subchildcategoryId;
  dynamic metakeywords;
  String? metadescription;
  String? showvideo;
  String? deletedAt;
  String? catTax;
  String? minCharges;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_id'] = cartId;
    map['id'] = id;
    map['user_id'] = userId;
    map['product_id'] = productId;
    map['quantity'] = quantity;
    map['total_cost'] = totalCost;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['name'] = name;
    map['image'] = image;
    map['video'] = video;
    map['details'] = details;
    map['rate_card'] = rateCard;
    map['time'] = time;
    map['max_quantity'] = maxQuantity;
    map['price'] = price;
    map['sale_price'] = salePrice;
    map['tax_type'] = taxType;
    map['tax'] = tax;
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
    map['deleted_at'] = deletedAt;
    map['cat_tax'] = catTax;
    map['min_charges'] = minCharges;
    return map;
  }

}