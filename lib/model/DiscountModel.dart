/// id : 2
/// user_id : null
/// status : "1"
/// type : "amount"
/// code : "ddd"
/// amount : "200.00"
/// percent : "0"
/// limit : "10"
/// use : "continue"
/// banner : "uploads/banners/1701783197TripAdvisor-launches-new-features-removebg-preview.png"
/// category : "1"
/// city : "[\"1\"]"
/// start : "2023-12-04"
/// end : "2023-12-21"
/// created_at : "2023-12-05T13:33:17.000000Z"
/// updated_at : "2023-12-05T13:33:17.000000Z"
/// deleted_at : null

class DiscountModel {
  DiscountModel({
      this.id, 
      this.userId, 
      this.status, 
      this.type, 
      this.code, 
      this.amount, 
      this.percent, 
      this.limit, 
      this.use, 
      this.banner, 
      this.category, 
      this.city, 
      this.start, 
      this.end, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  DiscountModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    status = json['status'];
    type = json['type'];
    code = json['code'];
    amount = json['amount'];
    percent = json['percent'];
    limit = json['limit'];
    use = json['use'];
    banner = json['banner'];
    category = json['category'];
    city = json['city'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  int? id;
  dynamic userId;
  String? status;
  String? type;
  String? code;
  String? amount;
  String? percent;
  String? limit;
  String? use;
  String? banner;
  String? category;
  String? city;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['status'] = status;
    map['type'] = type;
    map['code'] = code;
    map['amount'] = amount;
    map['percent'] = percent;
    map['limit'] = limit;
    map['use'] = use;
    map['banner'] = banner;
    map['category'] = category;
    map['city'] = city;
    map['start'] = start;
    map['end'] = end;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}