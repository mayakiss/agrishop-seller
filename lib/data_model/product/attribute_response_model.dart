// To parse this JSON data, do
//
//     final attributeResponse = attributeResponseFromJson(jsonString);

import 'dart:convert';

AttributeResponse attributeResponseFromJson(String str) => AttributeResponse.fromJson(json.decode(str));

String attributeResponseToJson(AttributeResponse data) => json.encode(data.toJson());

class AttributeResponse {
  AttributeResponse({
     this.data,
  });

  List<Attribute>? data;

  factory AttributeResponse.fromJson(Map<String, dynamic> json) => AttributeResponse(
    data: List<Attribute>.from(json["data"].map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Attribute {
  Attribute({
     this.id,
     this.name,
     this.values,
  });

  var id;
  String? name;
  List<Value>? values;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["id"],
    name: json["name"],
    values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "values": List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}

class Value {
  Value({
     this.id,
     this.attributeId,
     this.value,
    this.colorCode,
     this.createdAt,
     this.updatedAt,
  });

  var id;
  var attributeId;
  String? value;
  dynamic colorCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    attributeId: json["attribute_id"],
    value: json["value"],
    colorCode: json["color_code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attribute_id": attributeId,
    "value": value,
    "color_code": colorCode,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
