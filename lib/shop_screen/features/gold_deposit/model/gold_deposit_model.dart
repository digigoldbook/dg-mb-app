class GoldDepositModel {
  int? status;
  List<GoldItemData>? data;
  Pagination? pagination;

  GoldDepositModel({
    this.status,
    this.data,
    this.pagination,
  });

  GoldDepositModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GoldItemData>[];
      json['data'].forEach((v) {
        data!.add(GoldItemData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class GoldItemData {
  int? id;
  String? productName;
  List<ProductTitle>? productTitle;
  String? serialNo;
  String? uniqueCode;
  String? customerName;
  int? customerContact;
  String? bankBoneNumber;
  int? itemCount;
  String? productAmount;
  String? productRate;
  int? duration;
  String? durationUnit;
  String? productStatus;
  int? shopId;
  String? createdAt;
  String? updatedAt;

  GoldItemData(
      {this.id,
      this.productName,
      this.productTitle,
      this.serialNo,
      this.uniqueCode,
      this.customerName,
      this.customerContact,
      this.bankBoneNumber,
      this.itemCount,
      this.productAmount,
      this.productRate,
      this.duration,
      this.durationUnit,
      this.productStatus,
      this.shopId,
      this.createdAt,
      this.updatedAt});

  GoldItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    if (json['product_title'] != null) {
      productTitle = <ProductTitle>[];
      json['product_title'].forEach((v) {
        productTitle!.add(ProductTitle.fromJson(v));
      });
    }
    serialNo = json['serial_no'];
    uniqueCode = json['unique_code'];
    customerName = json['customer_name'];
    customerContact = json['customer_contact'];
    bankBoneNumber = json['bank_bone_number'];
    itemCount = json['item_count'];
    productAmount = json['product_amount'];
    productRate = json['product_rate'];
    duration = json['duration'];
    durationUnit = json['duration_unit'];
    productStatus = json['product_status'];
    shopId = json['shop_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    if (productTitle != null) {
      data['product_title'] = productTitle!.map((v) => v.toJson()).toList();
    }
    data['serial_no'] = serialNo;
    data['unique_code'] = uniqueCode;
    data['customer_name'] = customerName;
    data['customer_contact'] = customerContact;
    data['bank_bone_number'] = bankBoneNumber;
    data['item_count'] = itemCount;
    data['product_amount'] = productAmount;
    data['product_rate'] = productRate;
    data['duration'] = duration;
    data['duration_unit'] = durationUnit;
    data['product_status'] = productStatus;
    data['shop_id'] = shopId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class ProductTitle {
  String? item;
  String? createdAt;
  String? updatedAt;

  ProductTitle({this.item, this.createdAt, this.updatedAt});

  ProductTitle.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = item;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? limit;
  int? totalCount;

  Pagination({this.currentPage, this.totalPages, this.limit, this.totalCount});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    limit = json['limit'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['limit'] = limit;
    data['totalCount'] = totalCount;
    return data;
  }
}
