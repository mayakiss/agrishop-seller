// To parse this JSON data, do
//
//     final brandResponse = brandResponseFromJson(jsonString);

import 'dart:convert';

BrandResponse brandResponseFromJson(String str) => BrandResponse.fromJson(json.decode(str));

String brandResponseToJson(BrandResponse data) => json.encode(data.toJson());

class BrandResponse {
  BrandResponse({
     this.data,
  });

  List<Brand>? data;

  factory BrandResponse.fromJson(Map<String, dynamic> json) => BrandResponse(
    data: List<Brand>.from(json["data"].map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Brand {
  Brand({
     this.id,
     this.name,
     this.icon,
  });

  int? id;
  String? name;
  String? icon;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
  };
}
