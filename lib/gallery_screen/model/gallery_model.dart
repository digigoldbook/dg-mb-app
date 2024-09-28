class GalleryModel {
  int? status;
  List<GalleryData>? data;
  Pagination? pagination;

  GalleryModel({this.status, this.data, this.pagination});

  GalleryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GalleryData>[];
      json['data'].forEach((v) {
        data!.add(GalleryData.fromJson(v));
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

class GalleryData {
  // Renamed Data to GalleryData
  int? id;
  String? postTitle;
  String? postSlug;
  String? imageUrl;
  String? s3Key;
  int? stock;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<GalleryMeta>? meta;
  String? presignedUrl;

  GalleryData({
    this.id,
    this.postTitle,
    this.postSlug,
    this.imageUrl,
    this.s3Key,
    this.stock,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.meta,
    this.presignedUrl,
  });

  GalleryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postTitle = json['post_title'];
    postSlug = json['post_slug'];
    imageUrl = json['image_url'];
    s3Key = json['s3_key'];
    stock = json['stock'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['meta'] != null) {
      meta = <GalleryMeta>[];
      json['meta'].forEach((v) {
        meta!.add(GalleryMeta.fromJson(v));
      });
    }
    presignedUrl = json['presignedUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post_title'] = postTitle;
    data['post_slug'] = postSlug;
    data['image_url'] = imageUrl;
    data['s3_key'] = s3Key;
    data['stock'] = stock;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (meta != null) {
      data['meta'] = meta!.map((v) => v.toJson()).toList();
    }
    data['presignedUrl'] = presignedUrl;
    return data;
  }
}

class GalleryMeta {
  int? metaId;
  int? galleryId;
  String? metaKey;
  String? metaValue;

  GalleryMeta({this.metaId, this.galleryId, this.metaKey, this.metaValue});

  GalleryMeta.fromJson(Map<String, dynamic> json) {
    metaId = json['meta_id'];
    galleryId = json['gallery_id'];
    metaKey = json['meta_key'];
    metaValue = json['meta_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meta_id'] = metaId;
    data['gallery_id'] = galleryId;
    data['meta_key'] = metaKey;
    data['meta_value'] = metaValue;
    return data;
  }
}

class Pagination {
  int? totalItems;
  int? totalPages;
  int? currentPage;
  int? itemsPerPage;

  Pagination({
    this.totalItems,
    this.totalPages,
    this.currentPage,
    this.itemsPerPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    return data;
  }
}
