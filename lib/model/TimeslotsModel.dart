/// status : "current"
/// days : [{"day_name":"Mon","date":"2023-12-25"},{"day_name":"Tue","date":"2023-12-26"},{"day_name":"Wed","date":"2023-12-27"},{"day_name":"Thu","date":"2023-12-28"},{"day_name":"Fri","date":"2023-12-29"},{"day_name":"Sat","date":"2023-12-30"},{"day_name":"Sun","date":"2023-12-31"}]
/// tslot : ["11:30 PM","02:00 AM","02:30 AM","05:30 AM","10:00 PM"]

class TimeslotsModel {
  TimeslotsModel({
      this.status, 
      this.days, 
      this.tslot,});

  TimeslotsModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['days'] != null) {
      days = [];
      json['days'].forEach((v) {
        days?.add(Days.fromJson(v));
      });
    }
    tslot = json['tslot'] != null ? json['tslot'].cast<String>() : [];
  }
  String? status;
  List<Days>? days;
  List<String>? tslot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (days != null) {
      map['days'] = days?.map((v) => v.toJson()).toList();
    }
    map['tslot'] = tslot;
    return map;
  }

}

/// day_name : "Mon"
/// date : "2023-12-25"

class Days {
  Days({
      this.dayName, 
      this.date,});

  Days.fromJson(dynamic json) {
    dayName = json['day_name'];
    date = json['date'];
  }
  String? dayName;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day_name'] = dayName;
    map['date'] = date;
    return map;
  }

}