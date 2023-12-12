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

class CategoryModel {
  CategoryModel({
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

  CategoryModel.fromJson(dynamic json) {
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