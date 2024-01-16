import 'package:active_ecommerce_seller_app/api_request.dart';
import 'package:active_ecommerce_seller_app/data_model/digital_product_edit_response.dart';
import 'package:active_ecommerce_seller_app/data_model/product/category_response_model.dart';

import '../app_config.dart';
import '../data_model/common_response.dart';
import '../data_model/digital_product_response.dart';
import '../helpers/shared_value_helper.dart';

class DigitalProductRepository {
  /// get
  /// digital
  /// product
  Future<DigitalProductResponse> getDigitalProducts(
      {name = "", page = 1}) async {
    String url =
        "${AppConfig.BASE_URL_WITH_PREFIX}/digital-products?page=$page&name=$name";

    final response = await ApiRequest.get(url: url, headers: {
      "Authorization": "Bearer ${access_token.$}",
    });

    return digitalProductResponseFromJson(response.body);
  }

  /// add
  /// digital
  /// product

  Future<CommonResponse> addDigitalProductResponse(String postBody) async {
    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/digital-products/store");

    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    final response =
        await ApiRequest.post(url: url, headers: reqHeader, body: postBody);

    return commonResponseFromJson(response.body);
  }

  /// edit
  /// digital
  /// product
  ///

  Future<DigitalProductEditResponse> editDigitalProduct(
      {required id, lang = "en"}) async {
    String url =
        ("${AppConfig.BASE_URL_WITH_PREFIX}/digital-products/edit/$id?lang=$lang");

    final response = await ApiRequest.get(url: url, headers: {
      "Authorization": "Bearer ${access_token.$}",
    });
    return digitalProductEditResponseFromJson(response.body);
  }

  /// update
  /// digital
  /// product

  Future<CommonResponse> updateDigitalProduct(postBody, productId, lang) async {
    String url =
        ("${AppConfig.BASE_URL_WITH_PREFIX}/digital-products/update/$productId?lang=$lang");

    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    final response =
        await ApiRequest.post(url: url, headers: reqHeader, body: postBody);

    return commonResponseFromJson(response.body);
  }

  digitalProductDeleteReq({required id}) async {
    String url =
        ("${AppConfig.BASE_URL_WITH_PREFIX}/digital-products/destroy/$id");

    final response = await ApiRequest.get(url: url, headers: {
      "Authorization": "Bearer ${access_token.$}",
    });
    //print("product res  "+response.body.toString());
    return commonResponseFromJson(response.body);
  }

  /// digital
  /// product
  /// category

  Future<CategoryResponse> getCategoryRes() async {
    String url =
        ("${AppConfig.BASE_URL_WITH_PREFIX}/digital-products/categories");

    var reqHeader = {
      "Authorization": "Bearer ${access_token.$}",
    };

    final response = await ApiRequest.get(url: url, headers: reqHeader);

    return categoryResponseFromJson(response.body);
  }
}
