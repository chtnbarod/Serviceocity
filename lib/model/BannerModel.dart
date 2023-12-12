/// id : 1
/// image : "uploads/banners/1701100279WhatsApp_Image_2023-11-27_at_12.32.30_PM-removebg-preview.png"
/// link : null
/// city : "[\"1\"]"
/// status : "1"
/// order : "1"
/// created_at : "2023-11-27T15:51:19.000000Z"
/// updated_at : "2023-11-27T15:51:19.000000Z"
/// deleted_at : null

class BannerModel {
  BannerModel({
      this.id, 
      this.image, 
      this.link, 
      this.city, 
      this.status, 
      this.order, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  BannerModel.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    link = json['link'];
    city = json['city'];
    status = json['status'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  int? id;
  String? image;
  dynamic link;
  String? city;
  String? status;
  String? order;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['link'] = link;
    map['city'] = city;
    map['status'] = status;
    map['order'] = order;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}