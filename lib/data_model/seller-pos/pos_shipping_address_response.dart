// To parse this JSON data, do
//
//     final posShippingAddressResponse = posShippingAddressResponseFromJson(jsonString);

import 'dart:convert';

PosShippingAddressResponse posShippingAddressResponseFromJson(String str) =>
    PosShippingAddressResponse.fromJson(json.decode(str));

String posShippingAddressResponseToJson(PosShippingAddressResponse data) =>
    json.encode(data.toJson());

class PosShippingAddressResponse {
  List<PosShippingAddressList>? data;
  bool? success;
  int? status;

  PosShippingAddressResponse({
    this.data,
    this.success,
    this.status,
  });

  factory PosShippingAddressResponse.fromJson(Map<String, dynamic> json) =>
      PosShippingAddressResponse(
        data: json["data"] == null
            ? []
            : List<PosShippingAddressList>.from(
                json["data"]!.map((x) => PosShippingAddressList.fromJson(x))),
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

class PosShippingAddressList {
  int? id;
  int? userId;
  String? address;
  String? email;
  String? name;
  int? countryId;
  int? stateId;
  int? cityId;
  String? countryName;
  String? stateName;
  String? cityName;
  String? postalCode;
  String? phone;
  int? setDefault;
  bool? locationAvailable;
  double? lat;
  double? lang;

  PosShippingAddressList({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.address,
    this.countryId,
    this.stateId,
    this.cityId,
    this.countryName,
    this.stateName,
    this.cityName,
    this.postalCode,
    this.phone,
    this.setDefault,
    this.locationAvailable,
    this.lat,
    this.lang,
  });

  factory PosShippingAddressList.fromJson(Map<String, dynamic> json) =>
      PosShippingAddressList(
        id: json["id"],
        userId: json["user_id"],
        address: json["address"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        countryName: json["country_name"],
        stateName: json["state_name"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
        phone: json["phone"],
        setDefault: json["set_default"],
        locationAvailable: json["location_available"],
        lat: json["lat"]?.toDouble(),
        lang: json["lang"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address": address,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "country_name": countryName,
        "state_name": stateName,
        "city_name": cityName,
        "postal_code": postalCode,
        "phone": phone,
        "set_default": setDefault,
        "location_available": locationAvailable,
        "lat": lat,
        "lang": lang,
      };
}
