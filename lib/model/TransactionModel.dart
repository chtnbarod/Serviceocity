/// id : 3
/// from_id : "11"
/// to_id : "21"
/// amount : "500.00"
/// transaction_date : "2023-12-14"
/// type : "Credit"
/// details : "bonus"
/// comment : "The transaction is credited in k0's wallet by Main Admin"
/// status : "0"
/// order_id : 1
/// amount_type : "Bonus"
/// created_at : "2023-12-15T14:10:41.000000Z"
/// updated_at : "2023-12-15T14:10:41.000000Z"
/// deleted_at : ""

class TransactionModel {
  TransactionModel({
      this.id, 
      this.fromId, 
      this.toId, 
      this.amount, 
      this.transactionDate, 
      this.type, 
      this.details, 
      this.comment, 
      this.status, 
      this.orderId, 
      this.amountType, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  TransactionModel.fromJson(dynamic json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    amount = json['amount'];
    transactionDate = json['transaction_date'];
    type = json['type'];
    details = json['details'];
    comment = json['comment'];
    status = json['status'];
    orderId = json['order_id'];
    amountType = json['amount_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  int? id;
  String? fromId;
  String? toId;
  String? amount;
  String? transactionDate;
  String? type;
  String? details;
  String? comment;
  String? status;
  int? orderId;
  String? amountType;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['from_id'] = fromId;
    map['to_id'] = toId;
    map['amount'] = amount;
    map['transaction_date'] = transactionDate;
    map['type'] = type;
    map['details'] = details;
    map['comment'] = comment;
    map['status'] = status;
    map['order_id'] = orderId;
    map['amount_type'] = amountType;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}