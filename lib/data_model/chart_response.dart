// To parse this JSON data, do
//
//     final chartResponse = chartResponseFromJson(jsonString);

import 'dart:convert';

Map<String, ChartResponse> chartResponseFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, ChartResponse>(k, ChartResponse.fromJson(v)));

String chartResponseToJson(Map<String, ChartResponse> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ChartResponse {
  String? date;
  double? total;

  ChartResponse({
    this.date,
    this.total,
  });

  factory ChartResponse.fromJson(Map<String, dynamic> json) => ChartResponse(
        date: json["date"],
        total: json["total"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "total": total,
      };
}
