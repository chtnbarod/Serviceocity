/// id : 1
/// name : "admin"
/// image : ["uploads/images/17011002520WhatsApp_Image_2023-11-27_at_12.32.30_PM-removebg-preview.png"]

class SearchServiceModel {
  SearchServiceModel({
      this.id, 
      this.name, 
      this.image,});

  SearchServiceModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? json['image'].cast<String>() : [];
  }
  int? id;
  String? name;
  List<String>? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}