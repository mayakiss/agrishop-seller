var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "Copyright © " + this_year + "AgriShop"; //this shows in the splash screen
  static String app_name =
      "AgriShop Vendeur"; //this shows in the splash screen
  static String purchase_code =
      "62dcfc27-4224-4c90-a074-62d5b9b55f9f"; //enter your purchase code for the app from codecanyon
  static String system_key =
      "\$2y\$10\$DrdmSNO7ppbC4gqLzkgeKuEm697tMi7C9AoJorDdBwepQWeNyQbl6"; //enter your purchase code for the app from codecanyon

  static const bool HTTPS = true;
  // static const bool HTTPS = true;

  //Default language config
  static String default_language = "fr";
  static String mobile_app_code = "fr";
  static bool app_language_rtl = false;

  //configure this

  static const DOMAIN_PATH = "v2.agrishop.ne"; //localhost

  //do not configure these below
  static const String API_ENDPATH = "api/v2";
  static const String PUBLIC_FOLDER = "public";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String SELLER_PREFIX = "seller";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
  static const String BASE_URL_WITH_PREFIX = "${BASE_URL}/${SELLER_PREFIX}";
}
