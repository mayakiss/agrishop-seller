// To parse this JSON data, do
//
//     final posProductResponse = posProductResponseFromJson(jsonString);

import 'dart:convert';

PosProductResponse posProductResponseFromJson(String str) =>
    PosProductResponse.fromJson(json.decode(str));

String posProductResponseToJson(PosProductResponse data) =>
    json.encode(data.toJson());

class PosProductResponse {
  Products? products;
  dynamic keyword;
  dynamic category;
  dynamic brand;

  PosProductResponse({
    this.products,
    this.keyword,
    this.category,
    this.brand,
  });

  factory PosProductResponse.fromJson(Map<String, dynamic> json) =>
      PosProductResponse(
        products: json["products"] == null
            ? null
            : Products.fromJson(json["products"]),
        keyword: json["keyword"],
        category: json["category"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "products": products?.toJson(),
        "keyword": keyword,
        "category": category,
        "brand": brand,
      };
}

class Products {
  List<PosProductData>? data;

  Products({
    this.data,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        data: json["data"] == null
            ? []
            : List<PosProductData>.from(
                json["data"]!.map((x) => PosProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PosProductData {
  int? id;
  int? stockId;
  String? name;
  String? thumbnailImage;
  String? price;
  String? basePrice;
  int? qty;
  String? variant;
  int? digital;

  PosProductData({
    this.id,
    this.stockId,
    this.name,
    this.thumbnailImage,
    this.price,
    this.basePrice,
    this.qty,
    this.variant,
    this.digital,
  });

  factory PosProductData.fromJson(Map<String, dynamic> json) => PosProductData(
        id: json["id"],
        stockId: json["stock_id"],
        name: json["name"],
        thumbnailImage: json["thumbnail_image"],
        price: json["price"],
        basePrice: json["base_price"],
        qty: json["qty"],
        variant: json["variant"],
        digital: json["digital"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stock_id": stockId,
        "name": name,
        "thumbnail_image": thumbnailImage,
        "price": price,
        "base_price": basePrice,
        "qty": qty,
        "variant": variant,
        "digital": digital,
      };
}
