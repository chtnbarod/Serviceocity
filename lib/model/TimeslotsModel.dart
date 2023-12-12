/// status : "current"
/// days : ["Thu 07","Fri 08","Sat 09","Sun 10","Mon 11","Tue 12","Wed 13","Thu 14","Fri 15","Sat 16"]
/// tslot : ["20:30","21:30","22:00","22:30"]

class TimeslotsModel {
  TimeslotsModel({
      this.status, 
      this.days, 
      this.tslot,});

  TimeslotsModel.fromJson(dynamic json) {
    status = json['status'];
    days = json['days'] != null ? json['days'].cast<String>() : [];
    tslot = json['tslot'] != null ? json['tslot'].cast<String>() : [];
  }
  String? status;
  List<String>? days;
  List<String>? tslot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['days'] = days;
    map['tslot'] = tslot;
    return map;
  }

}