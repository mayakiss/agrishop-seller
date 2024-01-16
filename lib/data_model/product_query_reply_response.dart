// To parse this JSON data, do
//
//     final productQueryReplyResponse = productQueryReplyResponseFromJson(jsonString);

import 'dart:convert';

ProductQueryReplyResponse productQueryReplyResponseFromJson(String str) =>
    ProductQueryReplyResponse.fromJson(json.decode(str));

String productQueryReplyResponseToJson(ProductQueryReplyResponse data) =>
    json.encode(data.toJson());

class ProductQueryReplyResponse {
  ProductQueryDetailModel? data;

  ProductQueryReplyResponse({
    this.data,
  });

  factory ProductQueryReplyResponse.fromJson(Map<String, dynamic> json) =>
      ProductQueryReplyResponse(
        data: json["data"] == null
            ? null
            : ProductQueryDetailModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class ProductQueryDetailModel {
  int? id;
  String? userName;
  String? userImage;
  String? question;
  String? reply;
  String? product;
  String? status;
  String? createdAt;

  ProductQueryDetailModel({
    this.id,
    this.userName,
    this.userImage,
    this.question,
    this.reply,
    this.product,
    this.status,
    this.createdAt,
  });

  factory ProductQueryDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductQueryDetailModel(
        id: json["id"],
        userName: json["user_name"],
        userImage: json["user_image"],
        question: json["question"],
        reply: json["reply"],
        product: json["product"],
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "user_image": userImage,
        "question": question,
        "reply": reply,
        "product": product,
        "status": status,
        "created_at": createdAt,
      };
}
