import 'package:active_ecommerce_seller_app/api_request.dart';
import 'package:active_ecommerce_seller_app/app_config.dart';
import 'package:active_ecommerce_seller_app/data_model/phone_email_availability_response.dart';
import 'package:active_ecommerce_seller_app/data_model/profile_image_update_response.dart';
import 'package:active_ecommerce_seller_app/data_model/profile_response.dart';
import 'package:active_ecommerce_seller_app/data_model/profile_update_response.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ProfileRepository {
  Future<SellerProfileResponse> getSellerInfo() async {
    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/profile");
    final response = await ApiRequest.get(
        url: url, headers: {"Authorization": "Bearer ${access_token.$}"});

    return sellerProfileResponseFromJson(response.body);
  }

  Future<ProfileUpdateResponse> getProfileUpdateResponse(
      String name, String password) async {
    var post_body = jsonEncode({"name": "${name}", "password": "$password"});

    String url = ("${AppConfig.BASE_URL}/profile/update");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Authorization": "Bearer ${access_token.$}",
        },
        body: post_body);

    //print(response.body.toString());
    return profileUpdateResponseFromJson(response.body);
  }

  Future<ProfileImageUpdateResponse> getProfileImageUpdateResponse(
      String image, String filename) async {
    var post_body = jsonEncode({"image": "${image}", "filename": "$filename"});
    //print(post_body.toString());

    String url = ("${AppConfig.BASE_URL}/profile/update-image");
    final response = await ApiRequest.post(
        url: url,
        headers: {
          "Authorization": "Bearer ${access_token.$}",
        },
        body: post_body);

    return profileImageUpdateResponseFromJson(response.body);
  }

  Future<PhoneEmailAvailabilityResponse>
      getPhoneEmailAvailabilityResponse() async {
    //var post_body = jsonEncode({"user_id":"${user_id.$}"});

    String url = ("${AppConfig.BASE_URL}/profile/check-phone-and-email");
    final response = await ApiRequest.post(
        url: url,
        body: "",
        headers: {"Authorization": "Bearer ${access_token.$}"});

    return phoneEmailAvailabilityResponseFromJson(response.body);
  }
}
