// To parse this JSON data, do
//
//     final posCustomerListResponse = posCustomerListResponseFromJson(jsonString);

import 'dart:convert';

PosCustomerListResponse posCustomerListResponseFromJson(String str) =>
    PosCustomerListResponse.fromJson(json.decode(str));

String posCustomerListResponseToJson(PosCustomerListResponse data) =>
    json.encode(data.toJson());

class PosCustomerListResponse {
  List<Datum>? data;
  bool? success;
  int? status;

  PosCustomerListResponse({
    this.data,
    this.success,
    this.status,
  });

  factory PosCustomerListResponse.fromJson(Map<String, dynamic> json) =>
      PosCustomerListResponse(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "status": status,
      };
}

class Datum {
  int? id;
  String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
