class CashDepositModel {
  int? status;
  List<Items>? items;

  CashDepositModel({this.status, this.items});

  CashDepositModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? amount;
  String? rate;
  int? time;
  String? timeUnit;
  String? customerName;
  int? customerContact;
  int? shopId;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
      this.amount,
      this.rate,
      this.time,
      this.timeUnit,
      this.customerName,
      this.customerContact,
      this.shopId,
      this.createdAt,
      this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    rate = json['rate'];
    time = json['time'];
    timeUnit = json['time_unit'];
    customerName = json['customer_name'];
    customerContact = json['customer_contact'];
    shopId = json['shop_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['rate'] = rate;
    data['time'] = time;
    data['time_unit'] = timeUnit;
    data['customer_name'] = customerName;
    data['customer_contact'] = customerContact;
    data['shop_id'] = shopId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
