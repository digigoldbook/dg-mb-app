class GoldDepositModel {
  int? status;
  List<GoldItemData>? data;
  Pagination? pagination;

  GoldDepositModel({this.status, this.data, this.pagination});

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
  String? postTitle;
  int? userId;
  List<Items>? items;
  String? createdAt;
  String? updatedAt;

  GoldItemData(
      {this.id,
      this.postTitle,
      this.userId,
      this.items,
      this.createdAt,
      this.updatedAt});

  GoldItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postTitle = json['post_title'];
    userId = json['userId'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post_title'] = postTitle;
    data['userId'] = userId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Items {
  String? productTitle;
  int? productAmt;
  int? period;
  String? periodUnit;
  double? rate;

  Items(
      {this.productTitle,
      this.productAmt,
      this.period,
      this.periodUnit,
      this.rate});

  Items.fromJson(Map<String, dynamic> json) {
    productTitle = json['product_title'];
    productAmt = json['product_amt'];
    period = json['period'];
    periodUnit = json['period_unit'];

    // Handle int and double for 'rate'
    rate =
        (json['rate'] is int) ? (json['rate'] as int).toDouble() : json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_title'] = productTitle;
    data['product_amt'] = productAmt;
    data['period'] = period;
    data['period_unit'] = periodUnit;
    data['rate'] = rate;
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
