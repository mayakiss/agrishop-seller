// To parse this JSON data, do
//
//     final digitalProductEditResponse = digitalProductEditResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_ecommerce_seller_app/data_model/uploaded_file_list_response.dart';

DigitalProductEditResponse digitalProductEditResponseFromJson(String str) =>
    DigitalProductEditResponse.fromJson(json.decode(str));

String digitalProductEditResponseToJson(DigitalProductEditResponse data) =>
    json.encode(data.toJson());

class DigitalProductEditResponse {
  DigitalProductInfo? data;
  bool? result;
  int? status;

  DigitalProductEditResponse({
    this.data,
    this.result,
    this.status,
  });

  factory DigitalProductEditResponse.fromJson(Map<String, dynamic> json) =>
      DigitalProductEditResponse(
        data: json["data"] == null
            ? null
            : DigitalProductInfo.fromJson(json["data"]),
        result: json["result"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "result": result,
        "status": status,
      };
}

class DigitalProductInfo {
  int? id;
  String? lang;
  String? productName;
  int? categoryId;
  List? categoryIds;
  MetaImg? productFile;
  String? tags;
  MetaImg? photos;
  MetaImg? thumbnailImg;
  String? metaTitle;
  String? metaDescription;
  MetaImg? metaImg;
  String? slug;
  int? unitPrice;
  int? purchasePrice;
  List<Tax>? tax;
  int? discount;
  String? discountType;
  DateTime? discountStartDate;
  DateTime? discountEndDate;
  dynamic description;

  DigitalProductInfo({
    this.id,
    this.lang,
    this.productName,
    this.categoryId,
    this.categoryIds,
    this.productFile,
    this.tags,
    this.photos,
    this.thumbnailImg,
    this.metaTitle,
    this.metaDescription,
    this.metaImg,
    this.slug,
    this.unitPrice,
    this.purchasePrice,
    this.tax,
    this.discount,
    this.discountType,
    this.discountStartDate,
    this.discountEndDate,
    this.description,
  });

  factory DigitalProductInfo.fromJson(Map<String, dynamic> json) =>
      DigitalProductInfo(
        id: json["id"],
        lang: json["lang"],
        productName: json["product_name"],
        categoryId: json["category_id"],
        categoryIds: json["category_ids"],
        productFile: json["product_file"] == null
            ? null
            : MetaImg.fromJson(json["product_file"]),
        tags: json["tags"],
        photos:
            json["photos"] == null ? null : MetaImg.fromJson(json["photos"]),
        thumbnailImg: json["thumbnail_img"] == null
            ? null
            : MetaImg.fromJson(json["thumbnail_img"]),
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImg: json["meta_img"] == null
            ? null
            : MetaImg.fromJson(json["meta_img"]),
        slug: json["slug"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"],
        tax: json["tax"] == null
            ? []
            : List<Tax>.from(json["tax"]!.map((x) => Tax.fromJson(x))),
        discount: json["discount"],
        discountType: json["discount_type"],
        discountStartDate: json["discount_start_date"] == null
            ? null
            : DateTime.parse(json["discount_start_date"]),
        discountEndDate: json["discount_end_date"] == null
            ? null
            : DateTime.parse(json["discount_end_date"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lang": lang,
        "product_name": productName,
        "category_id": categoryId,
        "category_ids": categoryIds,
        "product_file": productFile?.toJson(),
        "tags": tags,
        "photos": photos?.toJson(),
        "thumbnail_img": thumbnailImg?.toJson(),
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_img": metaImg?.toJson(),
        "slug": slug,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "tax":
            tax == null ? [] : List<dynamic>.from(tax!.map((x) => x.toJson())),
        "discount": discount,
        "discount_type": discountType,
        "discount_start_date":
            "${discountStartDate!.year.toString().padLeft(4, '0')}-${discountStartDate!.month.toString().padLeft(2, '0')}-${discountStartDate!.day.toString().padLeft(2, '0')}",
        "discount_end_date":
            "${discountEndDate!.year.toString().padLeft(4, '0')}-${discountEndDate!.month.toString().padLeft(2, '0')}-${discountEndDate!.day.toString().padLeft(2, '0')}",
        "description": description,
      };
}

class MetaImg {
  List<FileInfo>? data;

  MetaImg({
    this.data,
  });

  factory MetaImg.fromJson(Map<String, dynamic> json) => MetaImg(
        data: json["data"] == null
            ? []
            : List<FileInfo>.from(
                json["data"]!.map((x) => FileInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Tax {
  int? id;
  int? productId;
  int? taxId;
  int? tax;
  String? taxType;
  DateTime? createdAt;
  DateTime? updatedAt;

  Tax({
    this.id,
    this.productId,
    this.taxId,
    this.tax,
    this.taxType,
    this.createdAt,
    this.updatedAt,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
        productId: json["product_id"],
        taxId: json["tax_id"],
        tax: json["tax"],
        taxType: json["tax_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "tax_id": taxId,
        "tax": tax,
        "tax_type": taxType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
