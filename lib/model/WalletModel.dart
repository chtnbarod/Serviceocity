/// id : 1
/// user_id : "22"
/// status : "1"
/// balance : "200.00"
/// last_transfer : "2023-12-14"
/// last_transfer_type : ""
/// bonus : "100.00"
/// min_balance : "0.00"
/// created_at : "2023-12-12T13:46:32.000000Z"
/// updated_at : "2023-12-12T13:47:34.000000Z"
/// deleted_at : ""

class WalletModel {
  WalletModel({
      this.id, 
      this.userId, 
      this.status, 
      this.balance, 
      this.lastTransfer, 
      this.lastTransferType, 
      this.bonus, 
      this.minBalance, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  WalletModel.fromJson(dynamic json) {
    try{
      id = json['id'];
      userId = json['user_id'];
      status = json['status'];
      balance = json['balance'];
      lastTransfer = json['last_transfer'];
      lastTransferType = json['last_transfer_type'];
      bonus = json['bonus'];
      minBalance = json['min_balance'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      deletedAt = json['deleted_at'];
    }catch(e){
      print("objectobject $e");
    }
  }
  int? id;
  String? userId;
  String? status;
  String? balance;
  String? lastTransfer;
  String? lastTransferType;
  String? bonus;
  String? minBalance;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['status'] = status;
    map['balance'] = balance;
    map['last_transfer'] = lastTransfer;
    map['last_transfer_type'] = lastTransferType;
    map['bonus'] = bonus;
    map['min_balance'] = minBalance;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}