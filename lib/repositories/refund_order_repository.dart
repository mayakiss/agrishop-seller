import 'dart:convert';
import 'package:active_ecommerce_seller_app/api_request.dart';
import 'package:active_ecommerce_seller_app/app_config.dart';
import 'package:active_ecommerce_seller_app/data_model/RefundOrderResponse.dart';
import 'package:active_ecommerce_seller_app/data_model/common_response.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';


class RefundOrderRepository {
  Future<RefundOrderResponse> getRefundOrderList({int page = 0}) async {
    String url =
    ("${AppConfig.BASE_URL_WITH_PREFIX}/refunds?page=${page}");

    print("product url " + url.toString());

    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
    });
    print("product res  " + response.body.toString());

    return refundOrderResponseFromJson(response.body);
  }

  Future<CommonResponse> approveRefundSellerStatusRequest(id) async {
    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/refunds/approve");

    var post_body = jsonEncode({"refund_id": id});
    print("refund id ${id}");
    var header = {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
      "Content-Type": "application/json",
    };
    final response = await ApiRequest.post(
        url: url, headers: header, body: post_body);

    print("product res  " + response.body.toString());

    return commonResponseFromJson(response.body);
  }

  Future<CommonResponse> rejectRefundSellerStatusRequest(id, message) async {
    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/refunds/reject");

    var post_body = jsonEncode({"refund_id": id, "reject_reason": message});
    var header = {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
      "Content-Type": "application/json",
    };
    final response = await ApiRequest.post(
        url: url, headers: header, body: post_body);

    print("product res  " + response.body.toString());

    return commonResponseFromJson(response.body);
  }
}
