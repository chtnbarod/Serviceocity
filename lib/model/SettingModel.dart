/// id : 1
/// app_name : "service_o_city"
/// app_logo : "uploads/images/app_logo_1703155882.png"
/// about_us : "servie_o_city"
/// contact_us : "servie_o_city"
/// refer_earn_from_amount : "150.00"
/// refer_earn_to_amount : "150.00"
/// refund_policy : "<p>service_o_city</p>"
/// terms_and_conditions : "<p>service_o_city</p>"
/// created_at : ""
/// updated_at : "2023-12-21T11:01:20.000000Z"

class SettingModel {
  SettingModel({
      this.id, 
      this.appName, 
      this.appLogo, 
      this.aboutUs, 
      this.contactUs, 
      this.referEarnFromAmount, 
      this.referEarnToAmount, 
      this.refundPolicy, 
      this.termsAndConditions, 
      this.createdAt, 
      this.updatedAt,});

  SettingModel.fromJson(dynamic json) {
    try{
      id = json['id'];
      appName = json['app_name'];
      appLogo = json['app_logo'];
      aboutUs = json['about_us'];
      contactUs = json['contact_us'];
      referEarnFromAmount = json['refer_earn_from_amount'];
      referEarnToAmount = json['refer_earn_to_amount'];
      refundPolicy = json['refund_policy'];
      termsAndConditions = json['terms_and_conditions'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
    }catch(e){
      ///
    }
  }
  int? id;
  String? appName;
  String? appLogo;
  String? aboutUs;
  String? contactUs;
  String? referEarnFromAmount;
  String? referEarnToAmount;
  String? refundPolicy;
  String? termsAndConditions;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['app_name'] = appName;
    map['app_logo'] = appLogo;
    map['about_us'] = aboutUs;
    map['contact_us'] = contactUs;
    map['refer_earn_from_amount'] = referEarnFromAmount;
    map['refer_earn_to_amount'] = referEarnToAmount;
    map['refund_policy'] = refundPolicy;
    map['terms_and_conditions'] = termsAndConditions;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}