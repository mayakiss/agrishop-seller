import 'package:active_ecommerce_seller_app/api_request.dart';
import 'package:active_ecommerce_seller_app/app_config.dart';
import 'package:active_ecommerce_seller_app/data_model/country_response.dart';

import '../data_model/city_response.dart';
import '../data_model/state_response.dart';

class AddressRepository {
  Future<dynamic> getCountryList({name = ""}) async {
    String url = ("${AppConfig.BASE_URL}/countries?name=$name");
    final response = await ApiRequest.get(
      url: url,
    );

    print(response.body);
    return countryResponseFromJson(response.body);
  }

  Future<dynamic> getStateListByCountry({country_id = 0, name = ""}) async {
    String url =
        ("${AppConfig.BASE_URL}/states-by-country/${country_id}?name=${name}");
    final response = await ApiRequest.get(url: url);
    return myStateResponseFromJson(response.body);
  }

  Future<dynamic> getCityListByState({state_id = 0, name = ""}) async {
    String url =
        ("${AppConfig.BASE_URL}/cities-by-state/${state_id}?name=${name}");
    final response = await ApiRequest.get(url: url);
    return cityResponseFromJson(response.body);
  }
}
