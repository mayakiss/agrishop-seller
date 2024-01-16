import '../api_request.dart';
import '../app_config.dart';
import '../data_model/common_response.dart';
import '../data_model/product_queries_response.dart';
import '../data_model/product_query_reply_response.dart';
import '../dummy_data/allProducts.dart';
import '../helpers/shared_value_helper.dart';

class ProductQueryRepository {
  Future<ProductQueriesResponse> getProductQueriesList({
    page = 1,
  }) async {
    $();
    String url =
        ("${AppConfig.BASE_URL_WITH_PREFIX}/products/queries?page=$page");

    var reqHeader = {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
      "Content-Type": "application/json"
    };
    final response = await ApiRequest.get(url: url, headers: reqHeader);

    return productQueriesResponseFromJson(response.body);
  }

  Future<ProductQueryReplyResponse> getProductQueryDetails(id) async {
    $();
    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/products/query-show/$id");

    var reqHeader = {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
      "Content-Type": "application/json"
    };
    final response = await ApiRequest.get(url: url, headers: reqHeader);

    print('product reply ---> ${response.body}');

    return productQueryReplyResponseFromJson(response.body);
  }

  Future<CommonResponse> addProductQueryReplyResponse(postBody, id) async {
    String url = ("${AppConfig.BASE_URL_WITH_PREFIX}/products/query-reply/$id");

    var reqHeader = {
      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
      "Content-Type": "application/json",
      "Accept": "application/json"
    };
    final response =
        await ApiRequest.post(url: url, headers: reqHeader, body: postBody);

    return commonResponseFromJson(response.body);
  }
}
