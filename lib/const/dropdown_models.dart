import 'package:active_ecommerce_seller_app/data_model/language_list_response.dart';

class CommonDropDownItem {
  String? key, value;

  CommonDropDownItem(this.key, this.value);
}

class ColorModel {
  String? key, value, name;

  ColorModel(this.key, this.value);
}

class LanguageDropModel {
  String key, value;
  Language language;

  LanguageDropModel(this.key, this.value, this.language);
}
