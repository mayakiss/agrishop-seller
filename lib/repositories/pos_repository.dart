import 'dart:convert';

import 'package:active_ecommerce_seller_app/data_model/common_response.dart';

import '../api_request.dart';
import '../app_config.dart';
import '../data_model/seller-pos/pos_cart_add_response.dart';
import '../data_model/seller-pos/pos_customer_list_response.dart';
import '../data_model/seller-pos/pos_product_response.dart';
import '../data_model/seller-pos/pos_shipping_address_response.dart';
import '../data_model/seller-pos/pos_update_user_response.dart';
import '../data_model/seller-pos/pos_user_cart_data_response.dart';
import '../helpers/shared_value_helper.dart';

class PosRepository {
  Future<PosProductResponse> getPosProducts(
      {brand = "", category = "", keyword = ""}) async {
    String url =
        ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/products?keyword=$keyword&category=$category&brand=$brand");
    print(url);

    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
    });
    print(response.body);
    return posProductResponseFromJson(response.body);
  }

  Future<PosShippingAddressResponse> getShippingAddress({id}) async {
    String url =
        ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/get-shipping_address/$id");

    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
    });
    // print(response.body);
    return posShippingAddressResponseFromJson(response.body);
  }

  // pos cart add response
  Future<CommonResponse> createShippingAddress(postBody) async {
    String url =
        ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/create-shipping-address");
    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };
    final response =
        await ApiRequest.post(url: url, headers: reqHeader, body: postBody);
    return commonResponseFromJson(response.body);
  }

  Future<PosUpdateUserResponse> updateUser(postBody) async {

    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/update-session-user");
    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };
    print(reqHeader);
    print(postBody);
    print(url);
    final response =
        await ApiRequest.post(url: url, headers: reqHeader, body: postBody);
    return posUpdateUserResponseFromJson(response.body);
  }

  Future<PosCustomerListResponse> getCustomers() async {
    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/get-customers");

    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
    });
    return posCustomerListResponseFromJson(response.body);
  }

  // pos cart add response
  Future<PosCartAddResponse> posAddToCart(postBody) async {
    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/add-to-cart");
    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    final response =
        await ApiRequest.post(url: url, headers: reqHeader, body: postBody);
    // print(response.body);

    return posCartAddResponseFromJson(response.body);
  }

  // pos user cart data
  Future<PosUserCartDataResponse> posUserCartData(postBody) async {
    // print(postBody);

    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/user-cart-data");
    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    final response =
        await ApiRequest.post(url: url, headers: reqHeader, body: postBody);
    print(response.body);

    return posUserCartDataResponseFromJson(response.body);
  }
  Future<CommonResponse> deleteCartData(id) async {
    // print(postBody);

    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/delete-cart/$id");
    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    final response =
        await ApiRequest.get(url: url, headers: reqHeader);
    print(response.body);

    return commonResponseFromJson(response.body);
  }

  Future<CommonResponse> updateCartData(id,quantity) async {

    var body = jsonEncode({
      "quantity":quantity,
      "cart_id":id
    });

    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/update-cart");
    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    final response =
        await ApiRequest.post(url: url, headers: reqHeader,body: body);


    // print(response.body);
    return commonResponseFromJson(response.body);
  }

  // pos user cart data
  Future<CommonResponse> createPOS(
      {userId,
      paymentType,
      discount,
      offlinePaymentMethod,
      offlinePaymentAmount,
      offlineTrxId,
      offlinePaymentProof,
      tmpUserId,
      shippingInfo,
      shippingCost}) async {
    // print(postBody);

    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/order-place");
    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    var postBody = jsonEncode({
      "user_id": userId,
      "payment_type": paymentType,
      "discount": discount,
      "offline_payment_method": offlinePaymentMethod,
      "offline_payment_amount": offlinePaymentAmount,
      "offline_trx_id": offlineTrxId,
      "offline_payment_proof": offlinePaymentProof,
      "temp_usder_id": tmpUserId,
      "shippingInfo": shippingInfo,
      "shippingCost": shippingCost
    });
    print(postBody);

    final response =
        await ApiRequest.post(url: url, headers: reqHeader, body: postBody);
    print(response.body);

    return commonResponseFromJson(response.body);
  }

  Future<CommonResponse> posConfig() async {

    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/configuration");
    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    final response =
    await ApiRequest.get(url: url, headers: reqHeader);


    // print(response.body);
    return commonResponseFromJson(response.body);
  }

  Future<CommonResponse> updateConfig(width) async {

    var body = jsonEncode({
      "thermal_printer_width":width,

    });

    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/pos/configuration/update");
    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    final response =
    await ApiRequest.post(url: url, headers: reqHeader,body: body);


    // print(response.body);
    return commonResponseFromJson(response.body);
  }
}
