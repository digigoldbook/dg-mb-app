class ShopModel {
  int? status;
  List<ShopData>? shopData; // Now a list of `ShopData`
  Pagination? pagination;

  ShopModel({this.status, this.shopData, this.pagination});

  ShopModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      shopData = <ShopData>[];
      json['data'].forEach((v) {
        shopData!.add(ShopData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (shopData != null) {
      data['data'] = shopData!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class ShopData {
  int? id;
  String? shopName;
  String? shopAddress;
  String? shopContact;
  String? shopRegNo;
  String? createdAt;
  String? updatedAt;
  List<ShopMeta>? shopMeta;

  ShopData({
    this.id,
    this.shopName,
    this.shopAddress,
    this.shopContact,
    this.shopRegNo,
    this.createdAt,
    this.updatedAt,
    this.shopMeta,
  });

  ShopData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopName = json['shop_name'];
    shopAddress = json['shop_address'];
    shopContact =
        json['shop_contact'].toString(); // Convert to string if it's a number
    shopRegNo = json['shop_reg_no'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['meta'] != null) {
      shopMeta = <ShopMeta>[];
      json['meta'].forEach((v) {
        shopMeta!.add(ShopMeta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shop_name'] = shopName;
    data['shop_address'] = shopAddress;
    data['shop_contact'] = shopContact;
    data['shop_reg_no'] = shopRegNo;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (shopMeta != null) {
      data['meta'] = shopMeta!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopMeta {
  int? metaId;
  int? shopId;
  String? metaKey;
  String? metaValue;

  ShopMeta({this.metaId, this.shopId, this.metaKey, this.metaValue});

  ShopMeta.fromJson(Map<String, dynamic> json) {
    metaId = json['meta_id'];
    shopId = json['shop_id'];
    metaKey = json['meta_key'];
    metaValue = json['meta_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meta_id'] = metaId;
    data['shop_id'] = shopId;
    data['meta_key'] = metaKey;
    data['meta_value'] = metaValue;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? totalPages;
  int? perPage;
  int? totalCount;

  Pagination(
      {this.currentPage, this.totalPages, this.perPage, this.totalCount});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    perPage = json['perPage'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['totalPages'] = totalPages;
    data['perPage'] = perPage;
    data['totalCount'] = totalCount;
    return data;
  }
}
