// To parse this JSON data, do
//
//     final taxResponse = taxResponseFromJson(jsonString);

import 'dart:convert';

TaxResponse taxResponseFromJson(String str) => TaxResponse.fromJson(json.decode(str));

String taxResponseToJson(TaxResponse data) => json.encode(data.toJson());

class TaxResponse {
  TaxResponse({
     this.data,
  });

  List<Datum>? data;

  factory TaxResponse.fromJson(Map<String, dynamic> json) => TaxResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
     this.id,
     this.name,
  });

  int? id;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
