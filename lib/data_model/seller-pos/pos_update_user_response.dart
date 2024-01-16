// To parse this JSON data, do
//
//     final posUpdateUserResponse = posUpdateUserResponseFromJson(jsonString);

import 'dart:convert';

PosUpdateUserResponse posUpdateUserResponseFromJson(String str) =>
    PosUpdateUserResponse.fromJson(json.decode(str));

String posUpdateUserResponseToJson(PosUpdateUserResponse data) =>
    json.encode(data.toJson());

class PosUpdateUserResponse {
  bool? result;
  String? message;
  var userId;
  String? temUserId;

  PosUpdateUserResponse({
    this.result,
    this.message,
    this.userId,
    this.temUserId,
  });

  factory PosUpdateUserResponse.fromJson(Map<String, dynamic> json) =>
      PosUpdateUserResponse(
        result: json["result"],
        message: json["message"],
        userId: json["userID"],
        temUserId: json["temUserId"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "userID": userId,
        "temUserId": temUserId,
      };
}
