// To parse this JSON data, do
//
//     final colorResponse = colorResponseFromJson(jsonString);

import 'dart:convert';

ColorResponse colorResponseFromJson(String str) => ColorResponse.fromJson(json.decode(str));

String colorResponseToJson(ColorResponse data) => json.encode(data.toJson());

class ColorResponse {
  ColorResponse({
     this.data,
  });

  List<ColorInfo>? data;

  factory ColorResponse.fromJson(Map<String, dynamic> json) => ColorResponse(
    data: List<ColorInfo>.from(json["data"].map((x) => ColorInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ColorInfo {
  ColorInfo({
     this.id,
     this.name,
     this.code,
  });

  int? id;
  String? name;
  String? code;

  factory ColorInfo.fromJson(Map<String, dynamic> json) => ColorInfo(
    id: json["id"],
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}
