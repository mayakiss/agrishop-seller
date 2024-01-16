// To parse this JSON data, do
//
//     final posCartAddResponse = posCartAddResponseFromJson(jsonString);

import 'dart:convert';

PosCartAddResponse posCartAddResponseFromJson(String str) =>
    PosCartAddResponse.fromJson(json.decode(str));

String posCartAddResponseToJson(PosCartAddResponse data) =>
    json.encode(data.toJson());

class PosCartAddResponse {
  int? success;
  String? message;
  dynamic userId;
  String? temUserId;

  PosCartAddResponse({
    this.success,
    this.message,
    this.userId,
    this.temUserId,
  });

  factory PosCartAddResponse.fromJson(Map<String, dynamic> json) =>
      PosCartAddResponse(
        success: json["success"],
        message: json["message"],
        userId: json["userId"],
        temUserId: json["temUserId"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "userId": userId,
        "temUserId": temUserId,
      };
}
