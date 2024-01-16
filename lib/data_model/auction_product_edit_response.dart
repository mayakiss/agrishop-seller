// To parse this JSON data, do
//
//     final auctionProductEditResponse = auctionProductEditResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_ecommerce_seller_app/data_model/uploaded_file_list_response.dart';

AuctionProductEditResponse auctionProductEditResponseFromJson(String str) =>
    AuctionProductEditResponse.fromJson(json.decode(str));

String auctionProductEditResponseToJson(AuctionProductEditResponse data) =>
    json.encode(data.toJson());

class AuctionProductEditResponse {
  AuctionProductData? data;
  bool? result;
  int? status;

  AuctionProductEditResponse({
    this.data,
    this.result,
    this.status,
  });

  factory AuctionProductEditResponse.fromJson(Map<String, dynamic> json) =>
      AuctionProductEditResponse(
        data: json["data"] == null
            ? null
            : AuctionProductData.fromJson(json["data"]),
        result: json["result"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "result": result,
        "status": status,
      };
}

class AuctionProductData {
  int? id;
  String? lang;
  String? productName;
  int? categoryId;
  List? categoryIds;
  int? brandId;
  String? productUnit;
  int? weight;
  String? tags;
  MetaImg? photos;
  MetaImg? thumbnailImg;
  String? videoProvider;
  String? videoLink;
  int? startingBid;
  DateTime? auctionStartDate;
  DateTime? auctionEndDate;
  String? description;
  String? shippingType;
  int? shippingCost;
  int? cashOnDelivery;
  dynamic estShippingDays;
  List<Tax>? tax;
  String? taxType;
  MetaImg? pdf;
  String? metaTitle;
  String? metaDescription;
  MetaImg? metaImg;
  String? slug;

  AuctionProductData({
    this.id,
    this.lang,
    this.productName,
    this.categoryId,
    this.categoryIds,
    this.brandId,
    this.productUnit,
    this.weight,
    this.tags,
    this.photos,
    this.thumbnailImg,
    this.videoProvider,
    this.videoLink,
    this.startingBid,
    this.auctionStartDate,
    this.auctionEndDate,
    this.description,
    this.shippingType,
    this.shippingCost,
    this.cashOnDelivery,
    this.estShippingDays,
    this.tax,
    this.taxType,
    this.pdf,
    this.metaTitle,
    this.metaDescription,
    this.metaImg,
    this.slug,
  });

  factory AuctionProductData.fromJson(Map<String, dynamic> json) =>
      AuctionProductData(
        id: json["id"],
        lang: json["lang"],
        productName: json["product_name"],
        categoryId: json["category_id"],
        categoryIds: json["category_ids"],
        brandId: json["brand_id"],
        productUnit: json["product_unit"],
        weight: json["weight"],
        tags: json["tags"],
        photos:
            json["photos"] == null ? null : MetaImg.fromJson(json["photos"]),
        thumbnailImg: json["thumbnail_img"] == null
            ? null
            : MetaImg.fromJson(json["thumbnail_img"]),
        videoProvider: json["video_provider"],
        videoLink: json["video_link"],
        startingBid: json["starting_bid"],
        auctionStartDate: json["auction_start_date"] == null
            ? null
            : DateTime.parse(json["auction_start_date"]),
        auctionEndDate: json["auction_end_date"] == null
            ? null
            : DateTime.parse(json["auction_end_date"]),
        description: json["description"],
        shippingType: json["shipping_type"],
        shippingCost: json["shipping_cost"],
        cashOnDelivery: json["cash_on_delivery"],
        estShippingDays: json["est_shipping_days"],
        tax: json["tax"] == null
            ? []
            : List<Tax>.from(json["tax"]!.map((x) => Tax.fromJson(x))),
        taxType: json["tax_type"],
        pdf: json["pdf"] == null ? null : MetaImg.fromJson(json["pdf"]),
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImg: json["meta_img"] == null
            ? null
            : MetaImg.fromJson(json["meta_img"]),
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lang": lang,
        "product_name": productName,
        "category_id": categoryId,
        "category_ids": categoryIds,
        "brand_id": brandId,
        "product_unit": productUnit,
        "weight": weight,
        "tags": tags,
        "photos": photos?.toJson(),
        "thumbnail_img": thumbnailImg?.toJson(),
        "video_provider": videoProvider,
        "video_link": videoLink,
        "starting_bid": startingBid,
        "auction_start_date":
            "${auctionStartDate!.year.toString().padLeft(4, '0')}-${auctionStartDate!.month.toString().padLeft(2, '0')}-${auctionStartDate!.day.toString().padLeft(2, '0')}",
        "auction_end_date":
            "${auctionEndDate!.year.toString().padLeft(4, '0')}-${auctionEndDate!.month.toString().padLeft(2, '0')}-${auctionEndDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "shipping_type": shippingType,
        "shipping_cost": shippingCost,
        "cash_on_delivery": cashOnDelivery,
        "est_shipping_days": estShippingDays,
        "tax":
            tax == null ? [] : List<dynamic>.from(tax!.map((x) => x.toJson())),
        "tax_type": taxType,
        "pdf": pdf?.toJson(),
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_img": metaImg?.toJson(),
        "slug": slug,
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
