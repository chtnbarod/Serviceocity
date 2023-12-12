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

class SubCategoryModel {
  SubCategoryModel({
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

  SubCategoryModel.fromJson(dynamic json) {
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