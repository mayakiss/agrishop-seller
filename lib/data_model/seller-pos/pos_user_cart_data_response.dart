// To parse this JSON data, do
//
//     final posUserCartDataResponse = posUserCartDataResponseFromJson(jsonString);

import 'dart:convert';

PosUserCartDataResponse posUserCartDataResponseFromJson(String str) =>
    PosUserCartDataResponse.fromJson(json.decode(str));

String posUserCartDataResponseToJson(PosUserCartDataResponse data) =>
    json.encode(data.toJson());

class PosUserCartDataResponse {
  bool? result;
  UserCartData? data;

  PosUserCartDataResponse({
    this.result,
    this.data,
  });

  factory PosUserCartDataResponse.fromJson(Map<String, dynamic> json) =>
      PosUserCartDataResponse(
        result: json["result"],
        data: json["data"] == null ? null : UserCartData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": data?.toJson(),
      };
}

class UserCartData {
  CartData? cartData;
  String? subtotal;
  String? tax;
  String? shippingCost;
  String? shippingCost_str;
  String? discount;
  String? total;

  UserCartData({
    this.cartData,
    this.subtotal,
    this.tax,
    this.shippingCost,
    this.shippingCost_str,
    this.discount,
    this.total,
  });

  factory UserCartData.fromJson(Map<String, dynamic> json) => UserCartData(
        cartData: json["cart_data"] == null
            ? null
            : CartData.fromJson(json["cart_data"]),
        subtotal: json["subtotal"],
        tax: json["tax"],
        shippingCost: json["shippingCost"],
        shippingCost_str: json["shippingCost_str"],
        discount: json["discount"],
        total: json["Total"],
      );

  Map<String, dynamic> toJson() => {
        "cart_data": cartData?.toJson(),
        "subtotal": subtotal,
        "tax": tax,
        "shippingCost": shippingCost,
        "shippingCost_str": shippingCost_str,
        "discount": discount,
        "Total": total,
      };
}

class CartData {
  List<Datum>? data;

  CartData({
    this.data,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? stockId;
  String? productName;
  String? variation;
  var price;
  var tax;
  int? cartQuantity;
  int? minPurchaseQty;
  int? stockQty;

  Datum({
    this.id,
    this.stockId,
    this.productName,
    this.variation,
    this.price,
    this.tax,
    this.cartQuantity,
    this.minPurchaseQty,
    this.stockQty,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        stockId: json["stock_id"],
        productName: json["product_name"],
        variation: json["variation"],
        price: json["price"],
        tax: json["tax"],
        cartQuantity: json["cart_quantity"],
        minPurchaseQty: json["min_purchase_qty"],
        stockQty: json["stock_qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stock_id": stockId,
        "product_name": productName,
        "variation": variation,
        "price": price,
        "tax": tax,
        "cart_quantity": cartQuantity,
        "min_purchase_qty": minPurchaseQty,
        "stock_qty": stockQty,
      };
}
