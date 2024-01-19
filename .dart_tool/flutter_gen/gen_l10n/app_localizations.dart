import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @auction_product_ucf.
  ///
  /// In en, this message translates to:
  /// **'Auction Products'**
  String get auction_product_ucf;

  /// No description provided for @auction_order_ucf.
  ///
  /// In en, this message translates to:
  /// **'Auction Orders'**
  String get auction_order_ucf;

  /// No description provided for @auction_product_update_ucf.
  ///
  /// In en, this message translates to:
  /// **'Edit Auction Product'**
  String get auction_product_update_ucf;

  /// No description provided for @auction_start_date_ucf.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get auction_start_date_ucf;

  /// No description provided for @auction_end_date_ucf.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get auction_end_date_ucf;

  /// No description provided for @auction_total_bids_ucf.
  ///
  /// In en, this message translates to:
  /// **'Total Bids'**
  String get auction_total_bids_ucf;

  /// No description provided for @auction_price_ucf.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get auction_price_ucf;

  /// No description provided for @auction_view_bids_ucf.
  ///
  /// In en, this message translates to:
  /// **'View All Bids'**
  String get auction_view_bids_ucf;

  /// No description provided for @auction_all_bids_ucf.
  ///
  /// In en, this message translates to:
  /// **'All Bids'**
  String get auction_all_bids_ucf;

  /// No description provided for @auction_biding_price_date_range_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Bidding Price + Date Range'**
  String get auction_biding_price_date_range_ucf;

  /// No description provided for @auction_starting_bid_price_ucf.
  ///
  /// In en, this message translates to:
  /// **'Starting bidding price'**
  String get auction_starting_bid_price_ucf;

  /// No description provided for @auction_date_range_ucf.
  ///
  /// In en, this message translates to:
  /// **'Auction Date Range'**
  String get auction_date_range_ucf;

  /// No description provided for @auction_product_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Auction Product'**
  String get auction_product_screen_title;

  /// No description provided for @auction_will_end.
  ///
  /// In en, this message translates to:
  /// **'Auction Will End'**
  String get auction_will_end;

  /// No description provided for @starting_bid_ucf.
  ///
  /// In en, this message translates to:
  /// **'Starting Bid'**
  String get starting_bid_ucf;

  /// No description provided for @highest_bid_ucf.
  ///
  /// In en, this message translates to:
  /// **'Highest Bid'**
  String get highest_bid_ucf;

  /// No description provided for @place_bid_ucf.
  ///
  /// In en, this message translates to:
  /// **'Place Bid'**
  String get place_bid_ucf;

  /// No description provided for @change_bid_ucf.
  ///
  /// In en, this message translates to:
  /// **'Change Bid'**
  String get change_bid_ucf;

  /// No description provided for @are_you_sure_to_mark_this_as_delivered.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to mark this as delivered ?'**
  String get are_you_sure_to_mark_this_as_delivered;

  /// No description provided for @are_you_sure_to_mark_this_as_picked_up.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to mark this as picked up ?'**
  String get are_you_sure_to_mark_this_as_picked_up;

  /// No description provided for @are_you_sure_to_request_cancellation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to request cancellation ?'**
  String get are_you_sure_to_request_cancellation;

  /// No description provided for @enter_address_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter Address'**
  String get enter_address_ucf;

  /// No description provided for @back_to_shipping_info.
  ///
  /// In en, this message translates to:
  /// **'Back to shipping info'**
  String get back_to_shipping_info;

  /// No description provided for @select_a_city.
  ///
  /// In en, this message translates to:
  /// **'Select a city'**
  String get select_a_city;

  /// No description provided for @select_a_state.
  ///
  /// In en, this message translates to:
  /// **'Select a state'**
  String get select_a_state;

  /// No description provided for @select_a_country.
  ///
  /// In en, this message translates to:
  /// **'Select a country'**
  String get select_a_country;

  /// No description provided for @address_ucf.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address_ucf;

  /// No description provided for @city_ucf.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city_ucf;

  /// No description provided for @enter_city_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter City'**
  String get enter_city_ucf;

  /// No description provided for @postal_code_ucf.
  ///
  /// In en, this message translates to:
  /// **'Postal Code'**
  String get postal_code_ucf;

  /// No description provided for @enter_postal_code_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter Postal Code'**
  String get enter_postal_code_ucf;

  /// No description provided for @country_ucf.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country_ucf;

  /// No description provided for @enter_country_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter Country'**
  String get enter_country_ucf;

  /// No description provided for @state_ucf.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state_ucf;

  /// No description provided for @enter_state_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter State'**
  String get enter_state_ucf;

  /// No description provided for @phone_ucf.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone_ucf;

  /// No description provided for @enter_phone_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone'**
  String get enter_phone_ucf;

  /// No description provided for @are_you_sure_to_remove_this_address.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to remove this address ?'**
  String get are_you_sure_to_remove_this_address;

  /// No description provided for @addresses_of_user.
  ///
  /// In en, this message translates to:
  /// **'Addresses of user'**
  String get addresses_of_user;

  /// No description provided for @double_tap_on_an_address_to_make_it_default.
  ///
  /// In en, this message translates to:
  /// **'Double tap on an address to make it default'**
  String get double_tap_on_an_address_to_make_it_default;

  /// No description provided for @no_country_available.
  ///
  /// In en, this message translates to:
  /// **'No country available'**
  String get no_country_available;

  /// No description provided for @no_state_available.
  ///
  /// In en, this message translates to:
  /// **'No state available'**
  String get no_state_available;

  /// No description provided for @no_city_available.
  ///
  /// In en, this message translates to:
  /// **'No city available'**
  String get no_city_available;

  /// No description provided for @loading_countries_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading Countries ...'**
  String get loading_countries_ucf;

  /// No description provided for @loading_states_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading States ...'**
  String get loading_states_ucf;

  /// No description provided for @loading_cities_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading Cities ...'**
  String get loading_cities_ucf;

  /// No description provided for @select_a_country_first.
  ///
  /// In en, this message translates to:
  /// **'Select a country first'**
  String get select_a_country_first;

  /// No description provided for @select_a_state_first.
  ///
  /// In en, this message translates to:
  /// **'Select a state first'**
  String get select_a_state_first;

  /// No description provided for @edit_ucf.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit_ucf;

  /// No description provided for @delete_ucf.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete_ucf;

  /// No description provided for @add_location_ucf.
  ///
  /// In en, this message translates to:
  /// **'Add Location'**
  String get add_location_ucf;

  /// No description provided for @assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assigned;

  /// No description provided for @amount_to_Collect_ucf.
  ///
  /// In en, this message translates to:
  /// **'Amount to Collect'**
  String get amount_to_Collect_ucf;

  /// No description provided for @account_delete_ucf.
  ///
  /// In en, this message translates to:
  /// **'Account Delete'**
  String get account_delete_ucf;

  /// No description provided for @fetching_bkash_url.
  ///
  /// In en, this message translates to:
  /// **'Fetching bkash url ...'**
  String get fetching_bkash_url;

  /// No description provided for @pay_with_bkash.
  ///
  /// In en, this message translates to:
  /// **'Pay with Bkash'**
  String get pay_with_bkash;

  /// No description provided for @pay_with_instamojo.
  ///
  /// In en, this message translates to:
  /// **'Pay with Instamojo'**
  String get pay_with_instamojo;

  /// No description provided for @search_product_of_brand.
  ///
  /// In en, this message translates to:
  /// **'Search products of brand'**
  String get search_product_of_brand;

  /// No description provided for @do_you_want_to_delete_it.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete it?'**
  String get do_you_want_to_delete_it;

  /// No description provided for @you_need_to_log_in.
  ///
  /// In en, this message translates to:
  /// **'You need to log in'**
  String get you_need_to_log_in;

  /// No description provided for @please_choose_valid_info.
  ///
  /// In en, this message translates to:
  /// **'Please choose valid info'**
  String get please_choose_valid_info;

  /// No description provided for @nothing_to_pay.
  ///
  /// In en, this message translates to:
  /// **'Nothing to pay'**
  String get nothing_to_pay;

  /// No description provided for @see_details_all_lower.
  ///
  /// In en, this message translates to:
  /// **'see details'**
  String get see_details_all_lower;

  /// No description provided for @no_payment_method_is_added.
  ///
  /// In en, this message translates to:
  /// **'No payment method is added'**
  String get no_payment_method_is_added;

  /// No description provided for @please_choose_one_option_to_pay.
  ///
  /// In en, this message translates to:
  /// **'Please choose one option to pay'**
  String get please_choose_one_option_to_pay;

  /// No description provided for @no_data_is_available.
  ///
  /// In en, this message translates to:
  /// **'No data is available'**
  String get no_data_is_available;

  /// No description provided for @no_address_is_added.
  ///
  /// In en, this message translates to:
  /// **'No Addresses is added'**
  String get no_address_is_added;

  /// No description provided for @add_new_address.
  ///
  /// In en, this message translates to:
  /// **'Add New Address.'**
  String get add_new_address;

  /// No description provided for @loading_more_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading More Products ...'**
  String get loading_more_products_ucf;

  /// No description provided for @no_more_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Products'**
  String get no_more_products_ucf;

  /// No description provided for @no_more_queries_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Queries'**
  String get no_more_queries_ucf;

  /// No description provided for @no_queries_found_ucf.
  ///
  /// In en, this message translates to:
  /// **'No Queries Found'**
  String get no_queries_found_ucf;

  /// No description provided for @no_product_is_available.
  ///
  /// In en, this message translates to:
  /// **'No product is available'**
  String get no_product_is_available;

  /// No description provided for @loading_more_brands_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading More Brands ...'**
  String get loading_more_brands_ucf;

  /// No description provided for @no_more_brands_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Brands'**
  String get no_more_brands_ucf;

  /// No description provided for @no_brand_is_available.
  ///
  /// In en, this message translates to:
  /// **'No brand is available'**
  String get no_brand_is_available;

  /// No description provided for @loading_more_items_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading More Items ...'**
  String get loading_more_items_ucf;

  /// No description provided for @no_more_items_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Items'**
  String get no_more_items_ucf;

  /// No description provided for @no_item_is_available.
  ///
  /// In en, this message translates to:
  /// **'No item is available'**
  String get no_item_is_available;

  /// No description provided for @loading_more_shops_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading More Shops ...'**
  String get loading_more_shops_ucf;

  /// No description provided for @no_more_shops_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Shops'**
  String get no_more_shops_ucf;

  /// No description provided for @no_shop_is_available.
  ///
  /// In en, this message translates to:
  /// **'No shop is available'**
  String get no_shop_is_available;

  /// No description provided for @loading_more_histories_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading More Histories ...'**
  String get loading_more_histories_ucf;

  /// No description provided for @no_more_histories_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Histories'**
  String get no_more_histories_ucf;

  /// No description provided for @no_history_is_available.
  ///
  /// In en, this message translates to:
  /// **'No history is available'**
  String get no_history_is_available;

  /// No description provided for @loading_more_categories_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading More Categories ...'**
  String get loading_more_categories_ucf;

  /// No description provided for @no_more_categories_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Categories'**
  String get no_more_categories_ucf;

  /// No description provided for @no_category_is_available.
  ///
  /// In en, this message translates to:
  /// **'No category is available'**
  String get no_category_is_available;

  /// No description provided for @coming_soon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get coming_soon;

  /// No description provided for @close_all_capital.
  ///
  /// In en, this message translates to:
  /// **'CLOSE'**
  String get close_all_capital;

  /// No description provided for @close_all_lower.
  ///
  /// In en, this message translates to:
  /// **'close'**
  String get close_all_lower;

  /// No description provided for @close_ucf.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close_ucf;

  /// No description provided for @cancel_all_capital.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel_all_capital;

  /// No description provided for @cancel_all_lower.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get cancel_all_lower;

  /// No description provided for @cancel_ucf.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel_ucf;

  /// No description provided for @confirm_all_capital.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM'**
  String get confirm_all_capital;

  /// No description provided for @confirm_all_lower.
  ///
  /// In en, this message translates to:
  /// **'confirm'**
  String get confirm_all_lower;

  /// No description provided for @confirm_ucf.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm_ucf;

  /// No description provided for @update_all_capital.
  ///
  /// In en, this message translates to:
  /// **'UPDATE'**
  String get update_all_capital;

  /// No description provided for @update_all_lower.
  ///
  /// In en, this message translates to:
  /// **'update'**
  String get update_all_lower;

  /// No description provided for @update_ucf.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update_ucf;

  /// No description provided for @send_all_capital.
  ///
  /// In en, this message translates to:
  /// **'SEND'**
  String get send_all_capital;

  /// No description provided for @send_all_lower.
  ///
  /// In en, this message translates to:
  /// **'send'**
  String get send_all_lower;

  /// No description provided for @send_ucf.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send_ucf;

  /// No description provided for @clear_all_capital.
  ///
  /// In en, this message translates to:
  /// **'CLEAR'**
  String get clear_all_capital;

  /// No description provided for @clear_all_lower.
  ///
  /// In en, this message translates to:
  /// **'clear'**
  String get clear_all_lower;

  /// No description provided for @clear_ucf.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear_ucf;

  /// No description provided for @apply_all_capital.
  ///
  /// In en, this message translates to:
  /// **'APPLY'**
  String get apply_all_capital;

  /// No description provided for @apply_all_lower.
  ///
  /// In en, this message translates to:
  /// **'apply'**
  String get apply_all_lower;

  /// No description provided for @apply_ucf.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply_ucf;

  /// No description provided for @add_all_capital.
  ///
  /// In en, this message translates to:
  /// **'ADD'**
  String get add_all_capital;

  /// No description provided for @add_all_lower.
  ///
  /// In en, this message translates to:
  /// **'add'**
  String get add_all_lower;

  /// No description provided for @add_ucf.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add_ucf;

  /// No description provided for @copied_ucf.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied_ucf;

  /// No description provided for @proceed_ucf.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed_ucf;

  /// No description provided for @proceed_all_caps.
  ///
  /// In en, this message translates to:
  /// **'PROCEED'**
  String get proceed_all_caps;

  /// No description provided for @submit_ucf.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit_ucf;

  /// No description provided for @view_more_ucf.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get view_more_ucf;

  /// No description provided for @show_less_ucf.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get show_less_ucf;

  /// No description provided for @selected_ucf.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected_ucf;

  /// No description provided for @creating_order.
  ///
  /// In en, this message translates to:
  /// **'Creating order ...'**
  String get creating_order;

  /// No description provided for @payment_cancelled_ucf.
  ///
  /// In en, this message translates to:
  /// **'Payment Cancelled'**
  String get payment_cancelled_ucf;

  /// No description provided for @photo_permission_ucf.
  ///
  /// In en, this message translates to:
  /// **'Photo Permission'**
  String get photo_permission_ucf;

  /// No description provided for @this_app_needs_permission.
  ///
  /// In en, this message translates to:
  /// **'This app needs permission'**
  String get this_app_needs_permission;

  /// No description provided for @deny_ucf.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get deny_ucf;

  /// No description provided for @settings_ucf.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_ucf;

  /// No description provided for @go_to_your_application_settings_and_give_photo_permission.
  ///
  /// In en, this message translates to:
  /// **'Go to your application settings and give photo permission'**
  String get go_to_your_application_settings_and_give_photo_permission;

  /// No description provided for @no_file_is_chosen.
  ///
  /// In en, this message translates to:
  /// **'No file is chosen'**
  String get no_file_is_chosen;

  /// No description provided for @yes_ucf.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes_ucf;

  /// No description provided for @no_ucf.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no_ucf;

  /// No description provided for @date_ucf.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date_ucf;

  /// No description provided for @follow_ucf.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow_ucf;

  /// No description provided for @followed_ucf.
  ///
  /// In en, this message translates to:
  /// **'Followed'**
  String get followed_ucf;

  /// No description provided for @unfollow_ucf.
  ///
  /// In en, this message translates to:
  /// **'Unfollow this seller'**
  String get unfollow_ucf;

  /// No description provided for @continue_ucf.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_ucf;

  /// No description provided for @day_ucf.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day_ucf;

  /// No description provided for @days_ucf.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days_ucf;

  /// No description provided for @network_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Network Error'**
  String get network_error;

  /// No description provided for @get_locations.
  ///
  /// In en, this message translates to:
  /// **'Get locations'**
  String get get_locations;

  /// No description provided for @get_direction_ucf.
  ///
  /// In en, this message translates to:
  /// **'Get Direction'**
  String get get_direction_ucf;

  /// No description provided for @digital_product_screen_.
  ///
  /// In en, this message translates to:
  /// **'Digital Product'**
  String get digital_product_screen_;

  /// No description provided for @digital_product_ucf.
  ///
  /// In en, this message translates to:
  /// **'Digital Products'**
  String get digital_product_ucf;

  /// No description provided for @dashboard_ucf.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard_ucf;

  /// No description provided for @earnings_ucf.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings_ucf;

  /// No description provided for @not_logged_in_ucf.
  ///
  /// In en, this message translates to:
  /// **'Not Logged In'**
  String get not_logged_in_ucf;

  /// No description provided for @change_language_ucf.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language_ucf;

  /// No description provided for @home_ucf.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_ucf;

  /// No description provided for @profile_ucf.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile_ucf;

  /// No description provided for @orders_ucf.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders_ucf;

  /// No description provided for @my_wishlist_ucf.
  ///
  /// In en, this message translates to:
  /// **'My Wishlist'**
  String get my_wishlist_ucf;

  /// No description provided for @messages_ucf.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages_ucf;

  /// No description provided for @wallet_ucf.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet_ucf;

  /// No description provided for @login_ucf.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_ucf;

  /// No description provided for @logout_ucf.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout_ucf;

  /// No description provided for @mark_as_picked.
  ///
  /// In en, this message translates to:
  /// **'Mark as picked'**
  String get mark_as_picked;

  /// No description provided for @my_delivery_ucf.
  ///
  /// In en, this message translates to:
  /// **'My Delivery'**
  String get my_delivery_ucf;

  /// No description provided for @my_earnings_ucf.
  ///
  /// In en, this message translates to:
  /// **'My Earnings'**
  String get my_earnings_ucf;

  /// No description provided for @my_collection_ucf.
  ///
  /// In en, this message translates to:
  /// **'My Collection'**
  String get my_collection_ucf;

  /// No description provided for @do_you_want_close_the_app.
  ///
  /// In en, this message translates to:
  /// **'Do you want close the app?'**
  String get do_you_want_close_the_app;

  /// No description provided for @top_categories_ucf.
  ///
  /// In en, this message translates to:
  /// **'Top Categories'**
  String get top_categories_ucf;

  /// No description provided for @brands_ucf.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get brands_ucf;

  /// No description provided for @top_sellers_ucf.
  ///
  /// In en, this message translates to:
  /// **'Top Sellers'**
  String get top_sellers_ucf;

  /// No description provided for @todays_deal_ucf.
  ///
  /// In en, this message translates to:
  /// **'Todays Deal'**
  String get todays_deal_ucf;

  /// No description provided for @flash_deal_ucf.
  ///
  /// In en, this message translates to:
  /// **'Flash Deal'**
  String get flash_deal_ucf;

  /// No description provided for @featured_categories_ucf.
  ///
  /// In en, this message translates to:
  /// **'Featured Categories'**
  String get featured_categories_ucf;

  /// No description provided for @featured_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'Featured Products'**
  String get featured_products_ucf;

  /// No description provided for @all_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'All Products'**
  String get all_products_ucf;

  /// No description provided for @search_anything.
  ///
  /// In en, this message translates to:
  /// **'Search anything ...'**
  String get search_anything;

  /// No description provided for @no_carousel_image_found.
  ///
  /// In en, this message translates to:
  /// **'No carousel image found'**
  String get no_carousel_image_found;

  /// No description provided for @no_category_found.
  ///
  /// In en, this message translates to:
  /// **'No category found'**
  String get no_category_found;

  /// No description provided for @categories_ucf.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories_ucf;

  /// No description provided for @view_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'View Products'**
  String get view_products_ucf;

  /// No description provided for @view_subcategories_ucf.
  ///
  /// In en, this message translates to:
  /// **'View Sub-Categories'**
  String get view_subcategories_ucf;

  /// No description provided for @no_subcategories_available.
  ///
  /// In en, this message translates to:
  /// **'No sub categories available'**
  String get no_subcategories_available;

  /// No description provided for @all_products_of_ucf.
  ///
  /// In en, this message translates to:
  /// **'All Products of'**
  String get all_products_of_ucf;

  /// No description provided for @cannot_order_more_than.
  ///
  /// In en, this message translates to:
  /// **'Cannot order more than'**
  String get cannot_order_more_than;

  /// No description provided for @items_of_this_all_lower.
  ///
  /// In en, this message translates to:
  /// **'item(s) of this'**
  String get items_of_this_all_lower;

  /// No description provided for @are_you_sure_to_remove_this_item.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to remove this item ?'**
  String get are_you_sure_to_remove_this_item;

  /// No description provided for @cart_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get cart_is_empty;

  /// No description provided for @total_amount_ucf.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get total_amount_ucf;

  /// No description provided for @update_cart_ucf.
  ///
  /// In en, this message translates to:
  /// **'Update Cart'**
  String get update_cart_ucf;

  /// No description provided for @proceed_to_shipping_ucf.
  ///
  /// In en, this message translates to:
  /// **'Proceed To Shipping'**
  String get proceed_to_shipping_ucf;

  /// No description provided for @shopping_cart_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get shopping_cart_ucf;

  /// No description provided for @please_log_in_to_see_the_cart_items.
  ///
  /// In en, this message translates to:
  /// **'Please log in to see the cart items'**
  String get please_log_in_to_see_the_cart_items;

  /// No description provided for @cancel_request_is_already_send.
  ///
  /// In en, this message translates to:
  /// **'Cancel request is already send'**
  String get cancel_request_is_already_send;

  /// No description provided for @classified_ads_ucf.
  ///
  /// In en, this message translates to:
  /// **'Classified Ads'**
  String get classified_ads_ucf;

  /// No description provided for @currency_change_ucf.
  ///
  /// In en, this message translates to:
  /// **'Change Currency'**
  String get currency_change_ucf;

  /// No description provided for @collection_ucf.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collection_ucf;

  /// No description provided for @load_more_ucf.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get load_more_ucf;

  /// No description provided for @type_your_message_here.
  ///
  /// In en, this message translates to:
  /// **'Type your message here ...'**
  String get type_your_message_here;

  /// No description provided for @enter_coupon_code.
  ///
  /// In en, this message translates to:
  /// **'Enter coupon code'**
  String get enter_coupon_code;

  /// No description provided for @subtotal_all_capital.
  ///
  /// In en, this message translates to:
  /// **'SUB TOTAL'**
  String get subtotal_all_capital;

  /// No description provided for @tax_all_capital.
  ///
  /// In en, this message translates to:
  /// **'TAX'**
  String get tax_all_capital;

  /// No description provided for @shipping_cost_all_capital.
  ///
  /// In en, this message translates to:
  /// **'SHIPPING COST'**
  String get shipping_cost_all_capital;

  /// No description provided for @discount_all_capital.
  ///
  /// In en, this message translates to:
  /// **'DISCOUNT'**
  String get discount_all_capital;

  /// No description provided for @grand_total_all_capital.
  ///
  /// In en, this message translates to:
  /// **'GRAND TOTAL'**
  String get grand_total_all_capital;

  /// No description provided for @coupon_code_ucf.
  ///
  /// In en, this message translates to:
  /// **'Coupon Code'**
  String get coupon_code_ucf;

  /// No description provided for @apply_coupon_all_capital.
  ///
  /// In en, this message translates to:
  /// **'APPLY COUPON'**
  String get apply_coupon_all_capital;

  /// No description provided for @place_my_order_all_capital.
  ///
  /// In en, this message translates to:
  /// **'PLACE MY ORDER'**
  String get place_my_order_all_capital;

  /// No description provided for @buy_package_ucf.
  ///
  /// In en, this message translates to:
  /// **'Buy Package'**
  String get buy_package_ucf;

  /// No description provided for @remove_ucf.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove_ucf;

  /// No description provided for @checkout_ucf.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout_ucf;

  /// No description provided for @cancelled_delivery_ucf.
  ///
  /// In en, this message translates to:
  /// **'Cancelled Delivery'**
  String get cancelled_delivery_ucf;

  /// No description provided for @completed_delivery_ucf.
  ///
  /// In en, this message translates to:
  /// **'Completed Delivery'**
  String get completed_delivery_ucf;

  /// No description provided for @search_products_from.
  ///
  /// In en, this message translates to:
  /// **'Search products from'**
  String get search_products_from;

  /// No description provided for @no_language_is_added.
  ///
  /// In en, this message translates to:
  /// **'No language is Added'**
  String get no_language_is_added;

  /// No description provided for @points_converted_to_wallet.
  ///
  /// In en, this message translates to:
  /// **'Points converted to wallet'**
  String get points_converted_to_wallet;

  /// No description provided for @show_wallet_all_capital.
  ///
  /// In en, this message translates to:
  /// **'SHOW WALLET'**
  String get show_wallet_all_capital;

  /// No description provided for @earned_points_ucf.
  ///
  /// In en, this message translates to:
  /// **'Earned Points'**
  String get earned_points_ucf;

  /// No description provided for @converted_ucf.
  ///
  /// In en, this message translates to:
  /// **'Converted '**
  String get converted_ucf;

  /// No description provided for @done_all_capital.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get done_all_capital;

  /// No description provided for @convert_now_ucf.
  ///
  /// In en, this message translates to:
  /// **'Convert Now'**
  String get convert_now_ucf;

  /// No description provided for @my_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'My Products'**
  String get my_products_ucf;

  /// No description provided for @current_package_ucf.
  ///
  /// In en, this message translates to:
  /// **'Current Package'**
  String get current_package_ucf;

  /// No description provided for @upgrade_package_ucf.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Package'**
  String get upgrade_package_ucf;

  /// No description provided for @add_new_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'Add New Products'**
  String get add_new_products_ucf;

  /// No description provided for @please_turn_on_your_internet_connection.
  ///
  /// In en, this message translates to:
  /// **'Please turn on your internet connection'**
  String get please_turn_on_your_internet_connection;

  /// No description provided for @please_log_in_to_see_the_profile.
  ///
  /// In en, this message translates to:
  /// **'Please log in to see the profile'**
  String get please_log_in_to_see_the_profile;

  /// No description provided for @notification_ucf.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification_ucf;

  /// No description provided for @purchase_history_ucf.
  ///
  /// In en, this message translates to:
  /// **'Purchase History'**
  String get purchase_history_ucf;

  /// No description provided for @earning_points_history_ucf.
  ///
  /// In en, this message translates to:
  /// **'Earning Points History'**
  String get earning_points_history_ucf;

  /// No description provided for @refund_requests_ucf.
  ///
  /// In en, this message translates to:
  /// **'Refund Requests'**
  String get refund_requests_ucf;

  /// No description provided for @in_your_cart_all_lower.
  ///
  /// In en, this message translates to:
  /// **'in your cart'**
  String get in_your_cart_all_lower;

  /// No description provided for @in_your_wishlist_all_lower.
  ///
  /// In en, this message translates to:
  /// **'in your wishlist'**
  String get in_your_wishlist_all_lower;

  /// No description provided for @your_ordered_all_lower.
  ///
  /// In en, this message translates to:
  /// **'you ordered'**
  String get your_ordered_all_lower;

  /// No description provided for @language_ucf.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_ucf;

  /// No description provided for @currency_ucf.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency_ucf;

  /// No description provided for @my_orders_ucf.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders_ucf;

  /// No description provided for @downloads_ucf.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloads_ucf;

  /// No description provided for @coupons_ucf.
  ///
  /// In en, this message translates to:
  /// **'Coupons'**
  String get coupons_ucf;

  /// No description provided for @favorite_seller_ucf.
  ///
  /// In en, this message translates to:
  /// **'Favorite Seller'**
  String get favorite_seller_ucf;

  /// No description provided for @all_digital_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'All Digital Products'**
  String get all_digital_products_ucf;

  /// No description provided for @on_auction_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'On Auction Products'**
  String get on_auction_products_ucf;

  /// No description provided for @wholesale_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'Wholesale Products'**
  String get wholesale_products_ucf;

  /// No description provided for @browse_all_sellers_ucf.
  ///
  /// In en, this message translates to:
  /// **'Browse All Sellers'**
  String get browse_all_sellers_ucf;

  /// No description provided for @delete_my_account.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get delete_my_account;

  /// No description provided for @delete_account_warning_title.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete your account from our system?'**
  String get delete_account_warning_title;

  /// No description provided for @delete_account_warning_description.
  ///
  /// In en, this message translates to:
  /// **'Once your account is deleted from our system, you will lose your balance and other information from our system.'**
  String get delete_account_warning_description;

  /// No description provided for @blogs_ucf.
  ///
  /// In en, this message translates to:
  /// **'Blogs'**
  String get blogs_ucf;

  /// No description provided for @check_balance_ucf.
  ///
  /// In en, this message translates to:
  /// **'Check Balance'**
  String get check_balance_ucf;

  /// No description provided for @account_ucf.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account_ucf;

  /// No description provided for @auction_ucf.
  ///
  /// In en, this message translates to:
  /// **'Auction'**
  String get auction_ucf;

  /// No description provided for @classified_products.
  ///
  /// In en, this message translates to:
  /// **'Classified products'**
  String get classified_products;

  /// No description provided for @packages_ucf.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get packages_ucf;

  /// No description provided for @upload_limit_ucf.
  ///
  /// In en, this message translates to:
  /// **'Upload Limit'**
  String get upload_limit_ucf;

  /// No description provided for @pending_delivery_ucf.
  ///
  /// In en, this message translates to:
  /// **'Pending Delivery'**
  String get pending_delivery_ucf;

  /// No description provided for @flash_deal_has_ended.
  ///
  /// In en, this message translates to:
  /// **'Flash deal has ended'**
  String get flash_deal_has_ended;

  /// No description provided for @ended_ucf.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get ended_ucf;

  /// No description provided for @flash_deals_ucf.
  ///
  /// In en, this message translates to:
  /// **'Flash Deals'**
  String get flash_deals_ucf;

  /// No description provided for @top_selling_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'Top Selling Products'**
  String get top_selling_products_ucf;

  /// No description provided for @product_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product_ucf;

  /// No description provided for @products_ucf.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products_ucf;

  /// No description provided for @sellers_ucf.
  ///
  /// In en, this message translates to:
  /// **'Sellers'**
  String get sellers_ucf;

  /// No description provided for @you_can_use_filters_while_searching_for_products.
  ///
  /// In en, this message translates to:
  /// **'You can use filters while searching for products.'**
  String get you_can_use_filters_while_searching_for_products;

  /// No description provided for @filter_ucf.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter_ucf;

  /// No description provided for @sort_products_by_ucf.
  ///
  /// In en, this message translates to:
  /// **'Sort Products By'**
  String get sort_products_by_ucf;

  /// No description provided for @price_high_to_low.
  ///
  /// In en, this message translates to:
  /// **'Price high to low'**
  String get price_high_to_low;

  /// No description provided for @price_low_to_high.
  ///
  /// In en, this message translates to:
  /// **'Price low to high'**
  String get price_low_to_high;

  /// No description provided for @new_arrival_ucf.
  ///
  /// In en, this message translates to:
  /// **'New Arrival'**
  String get new_arrival_ucf;

  /// No description provided for @popularity_ucf.
  ///
  /// In en, this message translates to:
  /// **'Popularity'**
  String get popularity_ucf;

  /// No description provided for @top_rated_ucf.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get top_rated_ucf;

  /// No description provided for @maximum_ucf.
  ///
  /// In en, this message translates to:
  /// **'Maximum'**
  String get maximum_ucf;

  /// No description provided for @minimum_ucf.
  ///
  /// In en, this message translates to:
  /// **'Minimum'**
  String get minimum_ucf;

  /// No description provided for @price_range_ucf.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get price_range_ucf;

  /// No description provided for @search_here_ucf.
  ///
  /// In en, this message translates to:
  /// **'Search here ?'**
  String get search_here_ucf;

  /// No description provided for @no_suggestion_available.
  ///
  /// In en, this message translates to:
  /// **'No suggestion is available'**
  String get no_suggestion_available;

  /// No description provided for @searched_for_all_lower.
  ///
  /// In en, this message translates to:
  /// **'searched for'**
  String get searched_for_all_lower;

  /// No description provided for @times_all_lower.
  ///
  /// In en, this message translates to:
  /// **'time(s)'**
  String get times_all_lower;

  /// No description provided for @found_all_lower.
  ///
  /// In en, this message translates to:
  /// **'found'**
  String get found_all_lower;

  /// No description provided for @loading_suggestions.
  ///
  /// In en, this message translates to:
  /// **'Loading suggestions...'**
  String get loading_suggestions;

  /// No description provided for @sort_ucf.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort_ucf;

  /// No description provided for @default_ucf.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get default_ucf;

  /// No description provided for @you_can_use_sorting_while_searching_for_products.
  ///
  /// In en, this message translates to:
  /// **'You can use sorting while searching for products.'**
  String get you_can_use_sorting_while_searching_for_products;

  /// No description provided for @filter_screen_min_max_warning.
  ///
  /// In en, this message translates to:
  /// **'Min price cannot be larger than max price'**
  String get filter_screen_min_max_warning;

  /// No description provided for @followed_sellers_ucf.
  ///
  /// In en, this message translates to:
  /// **'Followed Sellers'**
  String get followed_sellers_ucf;

  /// No description provided for @copy_product_link_ucf.
  ///
  /// In en, this message translates to:
  /// **'Copy Product Link'**
  String get copy_product_link_ucf;

  /// No description provided for @share_options_ucf.
  ///
  /// In en, this message translates to:
  /// **'Share Options'**
  String get share_options_ucf;

  /// No description provided for @title_ucf.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title_ucf;

  /// No description provided for @enter_title_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter Title'**
  String get enter_title_ucf;

  /// No description provided for @message_ucf.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message_ucf;

  /// No description provided for @enter_message_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter Message'**
  String get enter_message_ucf;

  /// No description provided for @title_or_message_empty_warning.
  ///
  /// In en, this message translates to:
  /// **'Title or message cannot be empty'**
  String get title_or_message_empty_warning;

  /// No description provided for @could_not_create_conversation.
  ///
  /// In en, this message translates to:
  /// **'Could not create conversation'**
  String get could_not_create_conversation;

  /// No description provided for @added_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get added_to_cart;

  /// No description provided for @show_cart_all_capital.
  ///
  /// In en, this message translates to:
  /// **'SHOW CART'**
  String get show_cart_all_capital;

  /// No description provided for @description_ucf.
  ///
  /// In en, this message translates to:
  /// **'Description:'**
  String get description_ucf;

  /// No description provided for @type_your_reply_ucf.
  ///
  /// In en, this message translates to:
  /// **'Type Your Reply'**
  String get type_your_reply_ucf;

  /// No description provided for @brand_ucf.
  ///
  /// In en, this message translates to:
  /// **'Brand:'**
  String get brand_ucf;

  /// No description provided for @total_price_ucf.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get total_price_ucf;

  /// No description provided for @price_ucf.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price_ucf;

  /// No description provided for @color_ucf.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color_ucf;

  /// No description provided for @seller_ucf.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get seller_ucf;

  /// No description provided for @club_point_ucf.
  ///
  /// In en, this message translates to:
  /// **'Club Point'**
  String get club_point_ucf;

  /// No description provided for @quantity_ucf.
  ///
  /// In en, this message translates to:
  /// **'Quantity:'**
  String get quantity_ucf;

  /// No description provided for @video_not_available.
  ///
  /// In en, this message translates to:
  /// **'Video not available'**
  String get video_not_available;

  /// No description provided for @video_ucf.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video_ucf;

  /// No description provided for @reviews_ucf.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews_ucf;

  /// No description provided for @seller_policy_ucf.
  ///
  /// In en, this message translates to:
  /// **'Seller Policy'**
  String get seller_policy_ucf;

  /// No description provided for @return_policy_ucf.
  ///
  /// In en, this message translates to:
  /// **'Return Policy'**
  String get return_policy_ucf;

  /// No description provided for @support_policy_ucf.
  ///
  /// In en, this message translates to:
  /// **'Support Policy'**
  String get support_policy_ucf;

  /// No description provided for @products_you_may_also_like.
  ///
  /// In en, this message translates to:
  /// **'Products you may also like'**
  String get products_you_may_also_like;

  /// No description provided for @other_ads_of_ucf.
  ///
  /// In en, this message translates to:
  /// **'Other Ads of'**
  String get other_ads_of_ucf;

  /// No description provided for @top_selling_products_from_seller.
  ///
  /// In en, this message translates to:
  /// **'Top selling products from this seller'**
  String get top_selling_products_from_seller;

  /// No description provided for @chat_with_seller.
  ///
  /// In en, this message translates to:
  /// **'Chat with seller'**
  String get chat_with_seller;

  /// No description provided for @available_all_lower.
  ///
  /// In en, this message translates to:
  /// **'available'**
  String get available_all_lower;

  /// No description provided for @add_to_cart_ucf.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get add_to_cart_ucf;

  /// No description provided for @buy_now_ucf.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buy_now_ucf;

  /// No description provided for @no_top_selling_products_from_this_seller.
  ///
  /// In en, this message translates to:
  /// **'No top selling products from this seller'**
  String get no_top_selling_products_from_this_seller;

  /// No description provided for @no_related_product.
  ///
  /// In en, this message translates to:
  /// **'No related products'**
  String get no_related_product;

  /// No description provided for @on_the_way_ucf.
  ///
  /// In en, this message translates to:
  /// **'On The Way'**
  String get on_the_way_ucf;

  /// No description provided for @all_ucf.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all_ucf;

  /// No description provided for @all_payments_ucf.
  ///
  /// In en, this message translates to:
  /// **'All Payments'**
  String get all_payments_ucf;

  /// No description provided for @all_deliveries_ucf.
  ///
  /// In en, this message translates to:
  /// **'All Deliveries'**
  String get all_deliveries_ucf;

  /// No description provided for @paid_ucf.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid_ucf;

  /// No description provided for @unpaid_ucf.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid_ucf;

  /// No description provided for @confirmed_ucf.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed_ucf;

  /// No description provided for @on_delivery_ucf.
  ///
  /// In en, this message translates to:
  /// **'On Delivery'**
  String get on_delivery_ucf;

  /// No description provided for @delivered_ucf.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered_ucf;

  /// No description provided for @no_more_orders_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Orders'**
  String get no_more_orders_ucf;

  /// No description provided for @loading_more_orders_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading More order...'**
  String get loading_more_orders_ucf;

  /// No description provided for @payment_status_ucf.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get payment_status_ucf;

  /// No description provided for @delivery_status_ucf.
  ///
  /// In en, this message translates to:
  /// **'Delivery Status'**
  String get delivery_status_ucf;

  /// No description provided for @product_name_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get product_name_ucf;

  /// No description provided for @order_code_ucf.
  ///
  /// In en, this message translates to:
  /// **'Order Code'**
  String get order_code_ucf;

  /// No description provided for @reason_ucf.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason_ucf;

  /// No description provided for @reason_cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'Reason cannot be empty'**
  String get reason_cannot_be_empty;

  /// No description provided for @enter_reason_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter Reason'**
  String get enter_reason_ucf;

  /// No description provided for @show_request_list_ucf.
  ///
  /// In en, this message translates to:
  /// **'Show Request List'**
  String get show_request_list_ucf;

  /// No description provided for @ordered_product_ucf.
  ///
  /// In en, this message translates to:
  /// **'Ordered Product'**
  String get ordered_product_ucf;

  /// No description provided for @no_item_ordered.
  ///
  /// In en, this message translates to:
  /// **'No items are ordered'**
  String get no_item_ordered;

  /// No description provided for @sub_total_all_capital.
  ///
  /// In en, this message translates to:
  /// **'SUB TOTAL'**
  String get sub_total_all_capital;

  /// No description provided for @order_placed.
  ///
  /// In en, this message translates to:
  /// **'Order placed'**
  String get order_placed;

  /// No description provided for @shipping_method_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shipping Method'**
  String get shipping_method_ucf;

  /// No description provided for @order_date_ucf.
  ///
  /// In en, this message translates to:
  /// **'Order Date'**
  String get order_date_ucf;

  /// No description provided for @payment_method_ucf.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_method_ucf;

  /// No description provided for @shipping_address_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shipping_address_ucf;

  /// No description provided for @name_ucf.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name_ucf;

  /// No description provided for @email_ucf.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email_ucf;

  /// No description provided for @postal_code.
  ///
  /// In en, this message translates to:
  /// **'Postal code'**
  String get postal_code;

  /// No description provided for @item_all_lower.
  ///
  /// In en, this message translates to:
  /// **'item'**
  String get item_all_lower;

  /// No description provided for @ask_for_refund_ucf.
  ///
  /// In en, this message translates to:
  /// **'Ask For Refund'**
  String get ask_for_refund_ucf;

  /// No description provided for @refund_status_ucf.
  ///
  /// In en, this message translates to:
  /// **'Refund Status'**
  String get refund_status_ucf;

  /// No description provided for @order_details_ucf.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get order_details_ucf;

  /// No description provided for @make_offline_payment_ucf.
  ///
  /// In en, this message translates to:
  /// **'Make Offline Payment'**
  String get make_offline_payment_ucf;

  /// No description provided for @choose_an_address.
  ///
  /// In en, this message translates to:
  /// **'Choose an address'**
  String get choose_an_address;

  /// No description provided for @choose_delivery_ucf.
  ///
  /// In en, this message translates to:
  /// **'Choose Delivery'**
  String get choose_delivery_ucf;

  /// No description provided for @home_delivery_ucf.
  ///
  /// In en, this message translates to:
  /// **'Home Delivery'**
  String get home_delivery_ucf;

  /// No description provided for @choose_an_address_or_pickup_point.
  ///
  /// In en, this message translates to:
  /// **'Choose an address or pickup point'**
  String get choose_an_address_or_pickup_point;

  /// No description provided for @to_add_or_edit_addresses_go_to_address_page.
  ///
  /// In en, this message translates to:
  /// **'To add or edit addresses, Go to address page'**
  String get to_add_or_edit_addresses_go_to_address_page;

  /// No description provided for @shipping_cost_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shipping Cost'**
  String get shipping_cost_ucf;

  /// No description provided for @shipping_info.
  ///
  /// In en, this message translates to:
  /// **'Shipping Info'**
  String get shipping_info;

  /// No description provided for @carrier_points_is_unavailable_ucf.
  ///
  /// In en, this message translates to:
  /// **'Carrier Points Is Unavailable'**
  String get carrier_points_is_unavailable_ucf;

  /// No description provided for @carrier_ucf.
  ///
  /// In en, this message translates to:
  /// **'Carrier'**
  String get carrier_ucf;

  /// No description provided for @proceed_to_checkout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to checkout'**
  String get proceed_to_checkout;

  /// No description provided for @continue_to_delivery_info_ucf.
  ///
  /// In en, this message translates to:
  /// **'Continue to Delivery Info'**
  String get continue_to_delivery_info_ucf;

  /// No description provided for @pickup_point_is_unavailable_ucf.
  ///
  /// In en, this message translates to:
  /// **'Pickup Point Is Unavailable'**
  String get pickup_point_is_unavailable_ucf;

  /// No description provided for @pickup_point_ucf.
  ///
  /// In en, this message translates to:
  /// **'Pickup Point'**
  String get pickup_point_ucf;

  /// No description provided for @mark_as_delivered.
  ///
  /// In en, this message translates to:
  /// **'Mark as delivered'**
  String get mark_as_delivered;

  /// No description provided for @please_wait_ucf.
  ///
  /// In en, this message translates to:
  /// **'Please Wait...'**
  String get please_wait_ucf;

  /// No description provided for @remaining_uploads.
  ///
  /// In en, this message translates to:
  /// **'Remaining uploads'**
  String get remaining_uploads;

  /// No description provided for @amount_cannot_be_empty.
  ///
  /// In en, this message translates to:
  /// **'Amount cannot be empty'**
  String get amount_cannot_be_empty;

  /// No description provided for @my_wallet_ucf.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get my_wallet_ucf;

  /// No description provided for @no_recharges_yet.
  ///
  /// In en, this message translates to:
  /// **'No recharges yet'**
  String get no_recharges_yet;

  /// No description provided for @approval_status_ucf.
  ///
  /// In en, this message translates to:
  /// **'Approval Status'**
  String get approval_status_ucf;

  /// No description provided for @wallet_balance_ucf.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance'**
  String get wallet_balance_ucf;

  /// No description provided for @last_recharged.
  ///
  /// In en, this message translates to:
  /// **'Last recharged'**
  String get last_recharged;

  /// No description provided for @wallet_recharge_history_ucf.
  ///
  /// In en, this message translates to:
  /// **'Wallet Recharge History'**
  String get wallet_recharge_history_ucf;

  /// No description provided for @amount_ucf.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount_ucf;

  /// No description provided for @enter_amount_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enter_amount_ucf;

  /// No description provided for @wholesale_product.
  ///
  /// In en, this message translates to:
  /// **'Wholesale product'**
  String get wholesale_product;

  /// No description provided for @recharge_wallet_ucf.
  ///
  /// In en, this message translates to:
  /// **'Recharge Wallet'**
  String get recharge_wallet_ucf;

  /// No description provided for @please_log_in_to_see_the_wishlist_items.
  ///
  /// In en, this message translates to:
  /// **'Please log in to see the wishlist items'**
  String get please_log_in_to_see_the_wishlist_items;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get enter_email;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enter_phone_number;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enter_password;

  /// No description provided for @or_login_with_a_phone.
  ///
  /// In en, this message translates to:
  /// **'or, Login with a phone number'**
  String get or_login_with_a_phone;

  /// No description provided for @or_login_with_an_email.
  ///
  /// In en, this message translates to:
  /// **'or, Login with an email'**
  String get or_login_with_an_email;

  /// No description provided for @password_ucf.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_ucf;

  /// No description provided for @login_screen_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get login_screen_phone;

  /// No description provided for @login_screen_forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get login_screen_forgot_password;

  /// No description provided for @login_screen_log_in.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login_screen_log_in;

  /// No description provided for @login_screen_or_create_new_account.
  ///
  /// In en, this message translates to:
  /// **'or, create a new account ?'**
  String get login_screen_or_create_new_account;

  /// No description provided for @login_screen_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get login_screen_sign_up;

  /// No description provided for @login_screen_login_with.
  ///
  /// In en, this message translates to:
  /// **'Login with'**
  String get login_screen_login_with;

  /// No description provided for @location_not_available.
  ///
  /// In en, this message translates to:
  /// **'Location not available'**
  String get location_not_available;

  /// No description provided for @login_to.
  ///
  /// In en, this message translates to:
  /// **'Login to'**
  String get login_to;

  /// No description provided for @enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enter_your_name;

  /// No description provided for @confirm_your_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirm_your_password;

  /// No description provided for @password_must_contain_at_least_6_characters.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 6 characters'**
  String get password_must_contain_at_least_6_characters;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @join_ucf.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join_ucf;

  /// No description provided for @retype_password_ucf.
  ///
  /// In en, this message translates to:
  /// **'Retype Password'**
  String get retype_password_ucf;

  /// No description provided for @or_register_with_a_phone.
  ///
  /// In en, this message translates to:
  /// **'or, Register with a phone number'**
  String get or_register_with_a_phone;

  /// No description provided for @or_register_with_an_email.
  ///
  /// In en, this message translates to:
  /// **'or, Register with an email'**
  String get or_register_with_an_email;

  /// No description provided for @sign_up_ucf.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up_ucf;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an Account ?'**
  String get already_have_an_account;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get log_in;

  /// No description provided for @requested_for_cancellation.
  ///
  /// In en, this message translates to:
  /// **'Requested for cancellation'**
  String get requested_for_cancellation;

  /// No description provided for @forget_password_ucf.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forget_password_ucf;

  /// No description provided for @or_send_code_via_phone_number.
  ///
  /// In en, this message translates to:
  /// **'or, send code via phone number'**
  String get or_send_code_via_phone_number;

  /// No description provided for @or_send_code_via_email.
  ///
  /// In en, this message translates to:
  /// **'or, send code via email'**
  String get or_send_code_via_email;

  /// No description provided for @send_code_ucf.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get send_code_ucf;

  /// No description provided for @enter_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enter_verification_code;

  /// No description provided for @verify_your.
  ///
  /// In en, this message translates to:
  /// **'Verify your'**
  String get verify_your;

  /// No description provided for @email_account_ucf.
  ///
  /// In en, this message translates to:
  /// **'Email Account'**
  String get email_account_ucf;

  /// No description provided for @phone_number_ucf.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number_ucf;

  /// No description provided for @enter_the_verification_code_that_sent_to_your_email_recently.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code that sent to your email recently.'**
  String get enter_the_verification_code_that_sent_to_your_email_recently;

  /// No description provided for @enter_the_verification_code_that_sent_to_your_phone_recently.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code that sent to your phone recently.'**
  String get enter_the_verification_code_that_sent_to_your_phone_recently;

  /// No description provided for @resend_code_ucf.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resend_code_ucf;

  /// No description provided for @enter_the_code.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get enter_the_code;

  /// No description provided for @enter_the_code_sent.
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent'**
  String get enter_the_code_sent;

  /// No description provided for @congratulations_ucf.
  ///
  /// In en, this message translates to:
  /// **'Congratulations !!'**
  String get congratulations_ucf;

  /// No description provided for @you_have_successfully_changed_your_password.
  ///
  /// In en, this message translates to:
  /// **'You have successfully changed your password'**
  String get you_have_successfully_changed_your_password;

  /// No description provided for @password_changed_ucf.
  ///
  /// In en, this message translates to:
  /// **'Password Changed'**
  String get password_changed_ucf;

  /// No description provided for @back_to_Login_ucf.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get back_to_Login_ucf;

  /// No description provided for @cart_ucf.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart_ucf;

  /// No description provided for @fetching_nagad_url.
  ///
  /// In en, this message translates to:
  /// **'Fetching nagad url ...'**
  String get fetching_nagad_url;

  /// No description provided for @pay_with_nagad.
  ///
  /// In en, this message translates to:
  /// **'Pay with Nagad'**
  String get pay_with_nagad;

  /// No description provided for @pay_with_iyzico.
  ///
  /// In en, this message translates to:
  /// **'Pay with Iyzico'**
  String get pay_with_iyzico;

  /// No description provided for @if_you_are_finding_any_problem_while_logging_in.
  ///
  /// In en, this message translates to:
  /// **'If you are finding any problem while logging in please contact the admin'**
  String get if_you_are_finding_any_problem_while_logging_in;

  /// No description provided for @fetching_paypal_url.
  ///
  /// In en, this message translates to:
  /// **'Fetching paypal url ...'**
  String get fetching_paypal_url;

  /// No description provided for @pay_with_paypal.
  ///
  /// In en, this message translates to:
  /// **'Pay with Paypal'**
  String get pay_with_paypal;

  /// No description provided for @pay_with_paystack.
  ///
  /// In en, this message translates to:
  /// **'Pay with Paystack'**
  String get pay_with_paystack;

  /// No description provided for @pay_with_paytm.
  ///
  /// In en, this message translates to:
  /// **'Pay with Paytm'**
  String get pay_with_paytm;

  /// No description provided for @pay_with_razorpay.
  ///
  /// In en, this message translates to:
  /// **'Pay with Razorpay'**
  String get pay_with_razorpay;

  /// No description provided for @fetching_sslcommerz_url.
  ///
  /// In en, this message translates to:
  /// **'Fetching sslcommerz url ...'**
  String get fetching_sslcommerz_url;

  /// No description provided for @pay_with_sslcommerz.
  ///
  /// In en, this message translates to:
  /// **'Pay with Sslcommerz'**
  String get pay_with_sslcommerz;

  /// No description provided for @pay_with_stripe.
  ///
  /// In en, this message translates to:
  /// **'Pay with Stripe'**
  String get pay_with_stripe;

  /// No description provided for @your_delivery_location.
  ///
  /// In en, this message translates to:
  /// **'Your delivery location . . .'**
  String get your_delivery_location;

  /// No description provided for @calculating.
  ///
  /// In en, this message translates to:
  /// **'Calculating...'**
  String get calculating;

  /// No description provided for @pick_here.
  ///
  /// In en, this message translates to:
  /// **'Pick Here'**
  String get pick_here;

  /// No description provided for @amount_name_and_transaction_id_are_necessary.
  ///
  /// In en, this message translates to:
  /// **'Amount,Name and Transaction id are necessary'**
  String get amount_name_and_transaction_id_are_necessary;

  /// No description provided for @photo_proof_is_necessary.
  ///
  /// In en, this message translates to:
  /// **'Photo proof is necessary'**
  String get photo_proof_is_necessary;

  /// No description provided for @all_marked_fields_are_mandatory.
  ///
  /// In en, this message translates to:
  /// **'All * marked fields are mandatory'**
  String get all_marked_fields_are_mandatory;

  /// No description provided for @correctly_fill_up_the_necessary_information.
  ///
  /// In en, this message translates to:
  /// **'Correctly fill-up the necessary information. Later you cannot edit or re-submit the form'**
  String get correctly_fill_up_the_necessary_information;

  /// No description provided for @transaction_id_ucf.
  ///
  /// In en, this message translates to:
  /// **'Transaction Id'**
  String get transaction_id_ucf;

  /// No description provided for @photo_proof_ucf.
  ///
  /// In en, this message translates to:
  /// **'Photo Proof'**
  String get photo_proof_ucf;

  /// No description provided for @only_image_file_allowed.
  ///
  /// In en, this message translates to:
  /// **'only image file allowed'**
  String get only_image_file_allowed;

  /// No description provided for @offline_ucf.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline_ucf;

  /// No description provided for @type_your_review_here.
  ///
  /// In en, this message translates to:
  /// **'Type your review here ...'**
  String get type_your_review_here;

  /// No description provided for @no_more_reviews_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Reviews'**
  String get no_more_reviews_ucf;

  /// No description provided for @loading_more_reviews_ucf.
  ///
  /// In en, this message translates to:
  /// **'Loading More Reviews ...'**
  String get loading_more_reviews_ucf;

  /// No description provided for @no_reviews_yet_be_the_first.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet. Be the first one to review this product'**
  String get no_reviews_yet_be_the_first;

  /// No description provided for @you_need_to_login_to_give_a_review.
  ///
  /// In en, this message translates to:
  /// **'You need to login to give a review'**
  String get you_need_to_login_to_give_a_review;

  /// No description provided for @review_can_not_empty_warning.
  ///
  /// In en, this message translates to:
  /// **'Review cannot be empty'**
  String get review_can_not_empty_warning;

  /// No description provided for @at_least_one_star_must_be_given.
  ///
  /// In en, this message translates to:
  /// **'At least one star must be given'**
  String get at_least_one_star_must_be_given;

  /// No description provided for @password_changes_ucf.
  ///
  /// In en, this message translates to:
  /// **'Password Changes'**
  String get password_changes_ucf;

  /// No description provided for @basic_information_ucf.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basic_information_ucf;

  /// No description provided for @new_password_ucf.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password_ucf;

  /// No description provided for @update_profile_ucf.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get update_profile_ucf;

  /// No description provided for @update_password_ucf.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get update_password_ucf;

  /// No description provided for @edit_profile_ucf.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile_ucf;

  /// No description provided for @picked_ucf.
  ///
  /// In en, this message translates to:
  /// **'Picked'**
  String get picked_ucf;

  /// No description provided for @top_selling_ucf.
  ///
  /// In en, this message translates to:
  /// **'Top Selling'**
  String get top_selling_ucf;

  /// No description provided for @store_home_ucf.
  ///
  /// In en, this message translates to:
  /// **'Store Home'**
  String get store_home_ucf;

  /// No description provided for @new_arrivals_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'New Arrivals Products'**
  String get new_arrivals_products_ucf;

  /// No description provided for @no_featured_product_is_available_from_this_seller.
  ///
  /// In en, this message translates to:
  /// **'No featured product is available from this seller'**
  String get no_featured_product_is_available_from_this_seller;

  /// No description provided for @no_new_arrivals.
  ///
  /// In en, this message translates to:
  /// **'No new arrivals'**
  String get no_new_arrivals;

  /// No description provided for @view_all_products_prom_this_seller_all_capital.
  ///
  /// In en, this message translates to:
  /// **'View All Products From This Seller'**
  String get view_all_products_prom_this_seller_all_capital;

  /// No description provided for @search_products_of_shop.
  ///
  /// In en, this message translates to:
  /// **'Search products of shop'**
  String get search_products_of_shop;

  /// No description provided for @today_ucf.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today_ucf;

  /// No description provided for @total_collected_ucf.
  ///
  /// In en, this message translates to:
  /// **'Total Collected'**
  String get total_collected_ucf;

  /// No description provided for @yesterday_ucf.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday_ucf;

  /// No description provided for @your_app_is_now.
  ///
  /// In en, this message translates to:
  /// **'Your app is now'**
  String get your_app_is_now;

  /// No description provided for @you_are_currently_offline.
  ///
  /// In en, this message translates to:
  /// **'You are currently offline'**
  String get you_are_currently_offline;

  /// No description provided for @view_details_ucf.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get view_details_ucf;

  /// No description provided for @pending_ucf.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending_ucf;

  /// No description provided for @picked_up_ucf.
  ///
  /// In en, this message translates to:
  /// **'Picked Up'**
  String get picked_up_ucf;

  /// No description provided for @money_withdraw_ucf.
  ///
  /// In en, this message translates to:
  /// **'Money Withdraw '**
  String get money_withdraw_ucf;

  /// No description provided for @payment_history_ucf.
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get payment_history_ucf;

  /// No description provided for @add_new_coupon_ucf.
  ///
  /// In en, this message translates to:
  /// **'Add New Coupon'**
  String get add_new_coupon_ucf;

  /// No description provided for @warning_ucf.
  ///
  /// In en, this message translates to:
  /// **'Warning!'**
  String get warning_ucf;

  /// No description provided for @coupon_code_is_empty_ucf.
  ///
  /// In en, this message translates to:
  /// **'Coupon Code Is Empty'**
  String get coupon_code_is_empty_ucf;

  /// No description provided for @discount_amount_is_invalid_ucf.
  ///
  /// In en, this message translates to:
  /// **'Discount Amount Is Invalid'**
  String get discount_amount_is_invalid_ucf;

  /// No description provided for @please_select_minimum_1_product_ucf.
  ///
  /// In en, this message translates to:
  /// **'Please Select Minimum 1 Product'**
  String get please_select_minimum_1_product_ucf;

  /// No description provided for @invalid_minimum_shopping_ucf.
  ///
  /// In en, this message translates to:
  /// **'Invalid Minimum Shopping'**
  String get invalid_minimum_shopping_ucf;

  /// No description provided for @invalid_maximum_discount_ucf.
  ///
  /// In en, this message translates to:
  /// **'Invalid Maximum Discount'**
  String get invalid_maximum_discount_ucf;

  /// No description provided for @edit_coupon_ucf.
  ///
  /// In en, this message translates to:
  /// **'Edit Coupon'**
  String get edit_coupon_ucf;

  /// No description provided for @save_ucf.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save_ucf;

  /// No description provided for @discount_ucf.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount_ucf;

  /// No description provided for @add_your_coupon_code_ucf.
  ///
  /// In en, this message translates to:
  /// **'Add Your Coupon Code'**
  String get add_your_coupon_code_ucf;

  /// No description provided for @minimum_shopping_ucf.
  ///
  /// In en, this message translates to:
  /// **'Minimum Shopping'**
  String get minimum_shopping_ucf;

  /// No description provided for @maximum_discount_amount_ucf.
  ///
  /// In en, this message translates to:
  /// **'Maximum Discount Amount'**
  String get maximum_discount_amount_ucf;

  /// No description provided for @coupon_information_adding.
  ///
  /// In en, this message translates to:
  /// **'Coupon information adding'**
  String get coupon_information_adding;

  /// No description provided for @select_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'Select Products'**
  String get select_products_ucf;

  /// No description provided for @offline_payment_ucf.
  ///
  /// In en, this message translates to:
  /// **'Offline Payment'**
  String get offline_payment_ucf;

  /// No description provided for @youtube_ucf.
  ///
  /// In en, this message translates to:
  /// **'Youtube'**
  String get youtube_ucf;

  /// No description provided for @dailymotion_ucf.
  ///
  /// In en, this message translates to:
  /// **'Dailymotion'**
  String get dailymotion_ucf;

  /// No description provided for @vimeo_ucf.
  ///
  /// In en, this message translates to:
  /// **'Vimeo'**
  String get vimeo_ucf;

  /// No description provided for @save_n_unpublish_ucf.
  ///
  /// In en, this message translates to:
  /// **'Save & Unpublish'**
  String get save_n_unpublish_ucf;

  /// No description provided for @save_n_publish_ucf.
  ///
  /// In en, this message translates to:
  /// **'Save & Publish'**
  String get save_n_publish_ucf;

  /// No description provided for @product_information_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Information'**
  String get product_information_ucf;

  /// No description provided for @unit_ucf.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit_ucf;

  /// No description provided for @unit_eg_ucf.
  ///
  /// In en, this message translates to:
  /// **'Unit (e.g. KG, Pc etc)'**
  String get unit_eg_ucf;

  /// No description provided for @weight_in_kg_ucf.
  ///
  /// In en, this message translates to:
  /// **'Weight (In Kg)'**
  String get weight_in_kg_ucf;

  /// No description provided for @minimum_purchase_quantity_ucf.
  ///
  /// In en, this message translates to:
  /// **'Minimum Purchase Quantity'**
  String get minimum_purchase_quantity_ucf;

  /// No description provided for @tags_ucf.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags_ucf;

  /// No description provided for @type_and_hit_enter_to_add_a_tag_ucf.
  ///
  /// In en, this message translates to:
  /// **'Type and hit enter to add a tag'**
  String get type_and_hit_enter_to_add_a_tag_ucf;

  /// No description provided for @barcode_ucf.
  ///
  /// In en, this message translates to:
  /// **'Barcode'**
  String get barcode_ucf;

  /// No description provided for @refundable_ucf.
  ///
  /// In en, this message translates to:
  /// **'Refundable'**
  String get refundable_ucf;

  /// No description provided for @product_description_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Description'**
  String get product_description_ucf;

  /// No description provided for @cash_on_delivery_ucf.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cash_on_delivery_ucf;

  /// No description provided for @vat_n_tax_ucf.
  ///
  /// In en, this message translates to:
  /// **'Vat & Tax'**
  String get vat_n_tax_ucf;

  /// No description provided for @product_images_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Images'**
  String get product_images_ucf;

  /// No description provided for @thumbnail_image_300_ucf.
  ///
  /// In en, this message translates to:
  /// **'Thumbnail Image (300x300)'**
  String get thumbnail_image_300_ucf;

  /// No description provided for @thumbnail_image_300_des.
  ///
  /// In en, this message translates to:
  /// **'These images are visible in all products box. Use 300x300 size image. Keep some blank space around main object of your image as we had to crop some edge in different devices to make it responsive. '**
  String get thumbnail_image_300_des;

  /// No description provided for @product_videos_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Videos'**
  String get product_videos_ucf;

  /// No description provided for @video_provider_ucf.
  ///
  /// In en, this message translates to:
  /// **'Video Provider'**
  String get video_provider_ucf;

  /// No description provided for @video_link_ucf.
  ///
  /// In en, this message translates to:
  /// **'Video Link'**
  String get video_link_ucf;

  /// No description provided for @video_link_des.
  ///
  /// In en, this message translates to:
  /// **'Use proper link without extra parameter. Don\'t use short share link/embedded iframe code.'**
  String get video_link_des;

  /// No description provided for @pdf_description_ucf.
  ///
  /// In en, this message translates to:
  /// **'PDF Description'**
  String get pdf_description_ucf;

  /// No description provided for @pdf_specification_ucf.
  ///
  /// In en, this message translates to:
  /// **'PDF Specification'**
  String get pdf_specification_ucf;

  /// No description provided for @unit_price_ucf.
  ///
  /// In en, this message translates to:
  /// **'Unit Price'**
  String get unit_price_ucf;

  /// No description provided for @discount_date_range_ucf.
  ///
  /// In en, this message translates to:
  /// **'Discount Date Range'**
  String get discount_date_range_ucf;

  /// No description provided for @sku_all_capital.
  ///
  /// In en, this message translates to:
  /// **'SKU'**
  String get sku_all_capital;

  /// No description provided for @external_link_ucf.
  ///
  /// In en, this message translates to:
  /// **'External Link'**
  String get external_link_ucf;

  /// No description provided for @leave_it_blank_if_you_do_not_use_external_site_link.
  ///
  /// In en, this message translates to:
  /// **'Leave it blank if you do not use external site link'**
  String get leave_it_blank_if_you_do_not_use_external_site_link;

  /// No description provided for @external_link_button_text_ucf.
  ///
  /// In en, this message translates to:
  /// **'External Link Button Text'**
  String get external_link_button_text_ucf;

  /// No description provided for @low_stock_quantity_warning_ucf.
  ///
  /// In en, this message translates to:
  /// **'Low Stock Quantity Warning'**
  String get low_stock_quantity_warning_ucf;

  /// No description provided for @stock_visibility_state_ucf.
  ///
  /// In en, this message translates to:
  /// **'Stock Visibility State'**
  String get stock_visibility_state_ucf;

  /// No description provided for @product_variation_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Variation'**
  String get product_variation_ucf;

  /// No description provided for @colors_ucf.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors_ucf;

  /// No description provided for @attributes_ucf.
  ///
  /// In en, this message translates to:
  /// **'Attributes'**
  String get attributes_ucf;

  /// No description provided for @seo_all_capital.
  ///
  /// In en, this message translates to:
  /// **'SEO'**
  String get seo_all_capital;

  /// No description provided for @meta_title_ucf.
  ///
  /// In en, this message translates to:
  /// **'Meta Title'**
  String get meta_title_ucf;

  /// No description provided for @meta_image_ucf.
  ///
  /// In en, this message translates to:
  /// **'Meta Image'**
  String get meta_image_ucf;

  /// No description provided for @shipping_configuration_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shipping Configuration'**
  String get shipping_configuration_ucf;

  /// No description provided for @shipping_configuration_is_maintained_by_admin.
  ///
  /// In en, this message translates to:
  /// **'Shipping configuration is maintained by Admin.'**
  String get shipping_configuration_is_maintained_by_admin;

  /// No description provided for @estimate_shipping_time_ucf.
  ///
  /// In en, this message translates to:
  /// **'Estimate Shipping Time'**
  String get estimate_shipping_time_ucf;

  /// No description provided for @shipping_days_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shipping Days'**
  String get shipping_days_ucf;

  /// No description provided for @gallery_images_600.
  ///
  /// In en, this message translates to:
  /// **'Gallery Images (600x600)'**
  String get gallery_images_600;

  /// No description provided for @these_images_are_visible_in_product_details_page_gallery_600.
  ///
  /// In en, this message translates to:
  /// **'These images are visible in product details page gallery. Use 600x600 sizes images.'**
  String get these_images_are_visible_in_product_details_page_gallery_600;

  /// No description provided for @photo_ucf.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo_ucf;

  /// No description provided for @general_ucf.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general_ucf;

  /// No description provided for @media_ucf.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get media_ucf;

  /// No description provided for @price_n_stock_ucf.
  ///
  /// In en, this message translates to:
  /// **'Price & Stock'**
  String get price_n_stock_ucf;

  /// No description provided for @product_binding_and_date_ucf.
  ///
  /// In en, this message translates to:
  /// **'Price And Date'**
  String get product_binding_and_date_ucf;

  /// No description provided for @shipping_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping_ucf;

  /// No description provided for @add_new_product_ucf.
  ///
  /// In en, this message translates to:
  /// **'Add New Product'**
  String get add_new_product_ucf;

  /// No description provided for @product_reviews_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Reviews'**
  String get product_reviews_ucf;

  /// No description provided for @update_now_ucf.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get update_now_ucf;

  /// No description provided for @slug_ucf.
  ///
  /// In en, this message translates to:
  /// **'Slug'**
  String get slug_ucf;

  /// No description provided for @update_product_ucf.
  ///
  /// In en, this message translates to:
  /// **'Update Product'**
  String get update_product_ucf;

  /// No description provided for @shop_banner_image_is_required.
  ///
  /// In en, this message translates to:
  /// **'Shop banner image is required.'**
  String get shop_banner_image_is_required;

  /// No description provided for @banner_settings.
  ///
  /// In en, this message translates to:
  /// **'Banner settings'**
  String get banner_settings;

  /// No description provided for @banner_1500_x_450.
  ///
  /// In en, this message translates to:
  /// **'Banner (1500 x 450)'**
  String get banner_1500_x_450;

  /// No description provided for @banner_1500_x_450_des.
  ///
  /// In en, this message translates to:
  /// **'We had to limit height to maintain consistency. In some device both side of the banner might be cropped for height limitation.'**
  String get banner_1500_x_450_des;

  /// No description provided for @delivery_boy_pickup_point.
  ///
  /// In en, this message translates to:
  /// **'Delivery boy pickup point'**
  String get delivery_boy_pickup_point;

  /// No description provided for @longitude_ucf.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude_ucf;

  /// No description provided for @latitude_ucf.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude_ucf;

  /// No description provided for @update_location.
  ///
  /// In en, this message translates to:
  /// **'Update location'**
  String get update_location;

  /// No description provided for @calculating_ucf.
  ///
  /// In en, this message translates to:
  /// **'Calculating'**
  String get calculating_ucf;

  /// No description provided for @pick_here_ucf.
  ///
  /// In en, this message translates to:
  /// **'Pick Here'**
  String get pick_here_ucf;

  /// No description provided for @shop_name_is_required.
  ///
  /// In en, this message translates to:
  /// **'Shop name is required'**
  String get shop_name_is_required;

  /// No description provided for @shop_phone_is_required.
  ///
  /// In en, this message translates to:
  /// **'Shop phone is required'**
  String get shop_phone_is_required;

  /// No description provided for @shop_address_is_required.
  ///
  /// In en, this message translates to:
  /// **'Shop address is required'**
  String get shop_address_is_required;

  /// No description provided for @shop_title_is_required.
  ///
  /// In en, this message translates to:
  /// **'Shop title is required'**
  String get shop_title_is_required;

  /// No description provided for @shop_description_is_required.
  ///
  /// In en, this message translates to:
  /// **'Shop description is required'**
  String get shop_description_is_required;

  /// No description provided for @shop_logo_is_required.
  ///
  /// In en, this message translates to:
  /// **'Shop logo is required'**
  String get shop_logo_is_required;

  /// No description provided for @general_setting_ucf.
  ///
  /// In en, this message translates to:
  /// **'General Setting'**
  String get general_setting_ucf;

  /// No description provided for @shop_description.
  ///
  /// In en, this message translates to:
  /// **'Shop description'**
  String get shop_description;

  /// No description provided for @shop_title.
  ///
  /// In en, this message translates to:
  /// **'Shop title'**
  String get shop_title;

  /// No description provided for @shop_phone.
  ///
  /// In en, this message translates to:
  /// **'Shop phone'**
  String get shop_phone;

  /// No description provided for @shop_address.
  ///
  /// In en, this message translates to:
  /// **'Shop address'**
  String get shop_address;

  /// No description provided for @shop_name_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shop Name'**
  String get shop_name_ucf;

  /// No description provided for @shop_logo_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shop logo'**
  String get shop_logo_ucf;

  /// No description provided for @shop_settings_ucf.
  ///
  /// In en, this message translates to:
  /// **'Shop Settings'**
  String get shop_settings_ucf;

  /// No description provided for @social_media_link.
  ///
  /// In en, this message translates to:
  /// **'Social media link'**
  String get social_media_link;

  /// No description provided for @google_ucf.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google_ucf;

  /// No description provided for @twitter_ucf.
  ///
  /// In en, this message translates to:
  /// **'Twitter'**
  String get twitter_ucf;

  /// No description provided for @instagram_ucf.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram_ucf;

  /// No description provided for @facebook_ucf.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook_ucf;

  /// No description provided for @upload_file_ucf.
  ///
  /// In en, this message translates to:
  /// **'Upload File'**
  String get upload_file_ucf;

  /// No description provided for @commission_history_ucf.
  ///
  /// In en, this message translates to:
  /// **'Commission History'**
  String get commission_history_ucf;

  /// No description provided for @chat_list.
  ///
  /// In en, this message translates to:
  /// **'Chat list'**
  String get chat_list;

  /// No description provided for @admin_commission_ucf.
  ///
  /// In en, this message translates to:
  /// **'Admin Commission'**
  String get admin_commission_ucf;

  /// No description provided for @create_a_ticket.
  ///
  /// In en, this message translates to:
  /// **'Create a ticket'**
  String get create_a_ticket;

  /// No description provided for @subject_ucf.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject_ucf;

  /// No description provided for @provide_a_detailed_description.
  ///
  /// In en, this message translates to:
  /// **'Provide a detailed description'**
  String get provide_a_detailed_description;

  /// No description provided for @send_ticket.
  ///
  /// In en, this message translates to:
  /// **'Send ticket'**
  String get send_ticket;

  /// No description provided for @top_products_ucf.
  ///
  /// In en, this message translates to:
  /// **'Top Products'**
  String get top_products_ucf;

  /// No description provided for @your_categories_ucf.
  ///
  /// In en, this message translates to:
  /// **'Your Categories'**
  String get your_categories_ucf;

  /// No description provided for @sales_stat_ucf.
  ///
  /// In en, this message translates to:
  /// **'Sales Stat'**
  String get sales_stat_ucf;

  /// No description provided for @product_upload_limit_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Upload Limit: '**
  String get product_upload_limit_ucf;

  /// No description provided for @package_expires_at_ucf.
  ///
  /// In en, this message translates to:
  /// **'Package Expires at: '**
  String get package_expires_at_ucf;

  /// No description provided for @manage_n_organize_your_shop.
  ///
  /// In en, this message translates to:
  /// **'Manage & organize\nyour shop.'**
  String get manage_n_organize_your_shop;

  /// No description provided for @configure_your_payment_method.
  ///
  /// In en, this message translates to:
  /// **'Configure your payment\nmethod.'**
  String get configure_your_payment_method;

  /// No description provided for @configure_now_ucf.
  ///
  /// In en, this message translates to:
  /// **'Configure Now'**
  String get configure_now_ucf;

  /// No description provided for @go_to_settings.
  ///
  /// In en, this message translates to:
  /// **'Go to settings'**
  String get go_to_settings;

  /// No description provided for @payment_settings_ucf.
  ///
  /// In en, this message translates to:
  /// **'Payment Settings'**
  String get payment_settings_ucf;

  /// No description provided for @rating_ucf.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating_ucf;

  /// No description provided for @total_orders_ucf.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get total_orders_ucf;

  /// No description provided for @total_sales_ucf.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get total_sales_ucf;

  /// No description provided for @hi_welcome_to_all_lower.
  ///
  /// In en, this message translates to:
  /// **'hi, welcome to'**
  String get hi_welcome_to_all_lower;

  /// No description provided for @login_to_your_account_all_lower.
  ///
  /// In en, this message translates to:
  /// **'login to your account'**
  String get login_to_your_account_all_lower;

  /// No description provided for @in_case_of_any_difficulties_contact_with_admin.
  ///
  /// In en, this message translates to:
  /// **'In case of any difficulties, contact with admin.'**
  String get in_case_of_any_difficulties_contact_with_admin;

  /// No description provided for @pending_balance_ucf.
  ///
  /// In en, this message translates to:
  /// **'Pending Balance'**
  String get pending_balance_ucf;

  /// No description provided for @send_withdraw_request_ucf.
  ///
  /// In en, this message translates to:
  /// **'Send Withdraw Request'**
  String get send_withdraw_request_ucf;

  /// No description provided for @premium_package_for_seller_ucf.
  ///
  /// In en, this message translates to:
  /// **'Premium Package for Seller'**
  String get premium_package_for_seller_ucf;

  /// No description provided for @select_payment_type_ucf.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Type'**
  String get select_payment_type_ucf;

  /// No description provided for @select_payment_option_ucf.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Option'**
  String get select_payment_option_ucf;

  /// No description provided for @enter_phone_number_ucf.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enter_phone_number_ucf;

  /// No description provided for @we_will_send_you_a_OTP_code_if_the_mail_id_is_correct_ucf.
  ///
  /// In en, this message translates to:
  /// **'We will send you a OTP code if the mail id is correct.'**
  String get we_will_send_you_a_OTP_code_if_the_mail_id_is_correct_ucf;

  /// No description provided for @we_will_send_you_a_OTP_code_if_the_phone_no_is_correct_ucf.
  ///
  /// In en, this message translates to:
  /// **'We will send you a OTP code if the phone no is correct.'**
  String get we_will_send_you_a_OTP_code_if_the_phone_no_is_correct_ucf;

  /// No description provided for @reset_password_ucf.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password_ucf;

  /// No description provided for @bank_payment.
  ///
  /// In en, this message translates to:
  /// **'Bank payment'**
  String get bank_payment;

  /// No description provided for @cash_payment.
  ///
  /// In en, this message translates to:
  /// **'Cash payment'**
  String get cash_payment;

  /// No description provided for @bank_account_number.
  ///
  /// In en, this message translates to:
  /// **'Bank account number'**
  String get bank_account_number;

  /// No description provided for @bank_account_name.
  ///
  /// In en, this message translates to:
  /// **'Bank account name'**
  String get bank_account_name;

  /// No description provided for @bank_name_ucf.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bank_name_ucf;

  /// No description provided for @bank_routing_number_ucf.
  ///
  /// In en, this message translates to:
  /// **'Bank Routing Number'**
  String get bank_routing_number_ucf;

  /// No description provided for @no_more_refund_requests_ucf.
  ///
  /// In en, this message translates to:
  /// **'No More Refund Requests'**
  String get no_more_refund_requests_ucf;

  /// No description provided for @approved_ucf.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved_ucf;

  /// No description provided for @approve_ucf.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve_ucf;

  /// No description provided for @rejected_ucf.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected_ucf;

  /// No description provided for @reject_ucf.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject_ucf;

  /// No description provided for @support_tickets_ucf.
  ///
  /// In en, this message translates to:
  /// **'Support Tickets'**
  String get support_tickets_ucf;

  /// No description provided for @options_ucf.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options_ucf;

  /// No description provided for @amount_is_invalid.
  ///
  /// In en, this message translates to:
  /// **'Amount is invalid'**
  String get amount_is_invalid;

  /// No description provided for @message_is_invalid.
  ///
  /// In en, this message translates to:
  /// **'Message is invalid'**
  String get message_is_invalid;

  /// No description provided for @coupon_ucf.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get coupon_ucf;

  /// No description provided for @withdraw_ucf.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw_ucf;

  /// No description provided for @conversation_ucf.
  ///
  /// In en, this message translates to:
  /// **'Conversation'**
  String get conversation_ucf;

  /// No description provided for @wholesale_prices_ucf.
  ///
  /// In en, this message translates to:
  /// **'Wholesale Prices'**
  String get wholesale_prices_ucf;

  /// No description provided for @min_quantity_ucf.
  ///
  /// In en, this message translates to:
  /// **'Minimum Quantity'**
  String get min_quantity_ucf;

  /// No description provided for @max_quantity_ucf.
  ///
  /// In en, this message translates to:
  /// **'Maximum Quantity'**
  String get max_quantity_ucf;

  /// No description provided for @add_more_ucf.
  ///
  /// In en, this message translates to:
  /// **'Add More'**
  String get add_more_ucf;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @be_a_seller.
  ///
  /// In en, this message translates to:
  /// **'Be a seller'**
  String get be_a_seller;

  /// No description provided for @personal_info_ucf.
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personal_info_ucf;

  /// No description provided for @basic_info_ucf.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get basic_info_ucf;

  /// No description provided for @shop_name.
  ///
  /// In en, this message translates to:
  /// **'Shop Name'**
  String get shop_name;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @verify_now.
  ///
  /// In en, this message translates to:
  /// **'Verify Now'**
  String get verify_now;

  /// No description provided for @verify_your_account.
  ///
  /// In en, this message translates to:
  /// **'Verify your account'**
  String get verify_your_account;

  /// No description provided for @your_account_is_unverified.
  ///
  /// In en, this message translates to:
  /// **'Your account is unverified'**
  String get your_account_is_unverified;

  /// No description provided for @verification_form_ucf.
  ///
  /// In en, this message translates to:
  /// **'Verification Form'**
  String get verification_form_ucf;

  /// No description provided for @product_file_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product File'**
  String get product_file_ucf;

  /// No description provided for @purchase_price_ucf.
  ///
  /// In en, this message translates to:
  /// **'Purchase Price'**
  String get purchase_price_ucf;

  /// No description provided for @no_file_chosen_ucf.
  ///
  /// In en, this message translates to:
  /// **'No File Chosen'**
  String get no_file_chosen_ucf;

  /// No description provided for @product_queries_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Queries'**
  String get product_queries_ucf;

  /// No description provided for @product_queries_reply_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Query Reply'**
  String get product_queries_reply_ucf;

  /// No description provided for @product_name_required_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Name Required'**
  String get product_name_required_ucf;

  /// No description provided for @product_category_required_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Category Required'**
  String get product_category_required_ucf;

  /// No description provided for @starting_bidding_price_required_ucf.
  ///
  /// In en, this message translates to:
  /// **'Starting Bidding Price Required'**
  String get starting_bidding_price_required_ucf;

  /// No description provided for @pick_a_auction_end_and_start_date.
  ///
  /// In en, this message translates to:
  /// **'Pick a Auction end and start date'**
  String get pick_a_auction_end_and_start_date;

  /// No description provided for @start_date_ucf.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get start_date_ucf;

  /// No description provided for @end_date_ucf.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get end_date_ucf;

  /// No description provided for @choose_file.
  ///
  /// In en, this message translates to:
  /// **'Choose file'**
  String get choose_file;

  /// No description provided for @browse_ucf.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse_ucf;

  /// No description provided for @select_ucf.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select_ucf;

  /// No description provided for @published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get published;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// No description provided for @duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @unpublished.
  ///
  /// In en, this message translates to:
  /// **'Unpublished'**
  String get unpublished;

  /// No description provided for @unfeatured.
  ///
  /// In en, this message translates to:
  /// **'Unfeatured'**
  String get unfeatured;

  /// No description provided for @insert_link_with_https.
  ///
  /// In en, this message translates to:
  /// **'Insert link with https'**
  String get insert_link_with_https;

  /// No description provided for @verification_code.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verification_code;

  /// No description provided for @confirm_password_ucf.
  ///
  /// In en, this message translates to:
  /// **'\'Confirm Password'**
  String get confirm_password_ucf;

  /// No description provided for @refund_reason_ucf.
  ///
  /// In en, this message translates to:
  /// **'Refund Reason'**
  String get refund_reason_ucf;

  /// No description provided for @seller_approval_ucf.
  ///
  /// In en, this message translates to:
  /// **'Seller Approval'**
  String get seller_approval_ucf;

  /// No description provided for @walk_in_customer.
  ///
  /// In en, this message translates to:
  /// **'Walk In Customer'**
  String get walk_in_customer;

  /// No description provided for @customer_info_ucf.
  ///
  /// In en, this message translates to:
  /// **'Customer info'**
  String get customer_info_ucf;

  /// No description provided for @select_category_ucf.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get select_category_ucf;

  /// No description provided for @select_brand_ucf.
  ///
  /// In en, this message translates to:
  /// **'Select Brand'**
  String get select_brand_ucf;

  /// No description provided for @search_by_product_name_barcode.
  ///
  /// In en, this message translates to:
  /// **'Search by product name/barcode'**
  String get search_by_product_name_barcode;

  /// No description provided for @online_ucf.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online_ucf;

  /// No description provided for @for_product_ucf.
  ///
  /// In en, this message translates to:
  /// **'For Product'**
  String get for_product_ucf;

  /// No description provided for @for_total_orders_ucf.
  ///
  /// In en, this message translates to:
  /// **'For Total Orders'**
  String get for_total_orders_ucf;

  /// No description provided for @percentage_ucf.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get percentage_ucf;

  /// No description provided for @verified_ucf.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified_ucf;

  /// No description provided for @unverified_ucf.
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified_ucf;

  /// No description provided for @flat_ucf.
  ///
  /// In en, this message translates to:
  /// **'Flat'**
  String get flat_ucf;

  /// No description provided for @percent_ucf.
  ///
  /// In en, this message translates to:
  /// **'Percent'**
  String get percent_ucf;

  /// No description provided for @free_shipping_ucf.
  ///
  /// In en, this message translates to:
  /// **'Free Shipping'**
  String get free_shipping_ucf;

  /// No description provided for @flat_rate_ucf.
  ///
  /// In en, this message translates to:
  /// **'Flat Rate'**
  String get flat_rate_ucf;

  /// No description provided for @type_hit_submit.
  ///
  /// In en, this message translates to:
  /// **'Type and hit submit'**
  String get type_hit_submit;

  /// No description provided for @show_stock_qty_ucf.
  ///
  /// In en, this message translates to:
  /// **'Show Stock Quantity'**
  String get show_stock_qty_ucf;

  /// No description provided for @show_stock_with_text_only_ucf.
  ///
  /// In en, this message translates to:
  /// **'Show Stock With Text Only'**
  String get show_stock_with_text_only_ucf;

  /// No description provided for @hide_stock_ucf.
  ///
  /// In en, this message translates to:
  /// **'Hide Stock'**
  String get hide_stock_ucf;

  /// No description provided for @product_unit_required_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Unit Required'**
  String get product_unit_required_ucf;

  /// No description provided for @starting_binding_price_required_ucf.
  ///
  /// In en, this message translates to:
  /// **'Starting Binding Price Required'**
  String get starting_binding_price_required_ucf;

  /// No description provided for @product_purchase_price_required_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Purchase Price Required'**
  String get product_purchase_price_required_ucf;

  /// No description provided for @product_discount_required_ucf.
  ///
  /// In en, this message translates to:
  /// **'Product Discount Required'**
  String get product_discount_required_ucf;

  /// No description provided for @write_message.
  ///
  /// In en, this message translates to:
  /// **'Write message...'**
  String get write_message;

  /// No description provided for @download_ucf.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download_ucf;

  /// No description provided for @file_has_download.
  ///
  /// In en, this message translates to:
  /// **'File has downloaded successfully.'**
  String get file_has_download;

  /// No description provided for @select_date.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get select_date;

  /// No description provided for @sellerexample.
  ///
  /// In en, this message translates to:
  /// **'seller@example.com'**
  String get sellerexample;

  /// No description provided for @elmira_wisozk.
  ///
  /// In en, this message translates to:
  /// **'Elmira Wisozk'**
  String get elmira_wisozk;

  /// No description provided for @plains_commerce_bank.
  ///
  /// In en, this message translates to:
  /// **'Plains Commerce Bank'**
  String get plains_commerce_bank;

  /// No description provided for @fetching_flutterwave_url.
  ///
  /// In en, this message translates to:
  /// **'Fetching Flutterwave url ...'**
  String get fetching_flutterwave_url;

  /// No description provided for @pay_with_flutterwave.
  ///
  /// In en, this message translates to:
  /// **'Pay with Flutterwave'**
  String get pay_with_flutterwave;

  /// No description provided for @publish_ucf.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish_ucf;

  /// No description provided for @unpublish_ucf.
  ///
  /// In en, this message translates to:
  /// **'UnPublish'**
  String get unpublish_ucf;

  /// No description provided for @provide_reason.
  ///
  /// In en, this message translates to:
  /// **'Please provide reason.'**
  String get provide_reason;

  /// No description provided for @type_reason.
  ///
  /// In en, this message translates to:
  /// **'Type reason'**
  String get type_reason;

  /// No description provided for @please_pick_place.
  ///
  /// In en, this message translates to:
  /// **'Please Pick a Place'**
  String get please_pick_place;

  /// No description provided for @there_are_variations.
  ///
  /// In en, this message translates to:
  /// **'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable'**
  String get there_are_variations;

  /// No description provided for @demo_store_ucf.
  ///
  /// In en, this message translates to:
  /// **'Filon Asset Store'**
  String get demo_store_ucf;

  /// No description provided for @demo_address.
  ///
  /// In en, this message translates to:
  /// **'1348 Fancher Drive Dallas, TX 75225'**
  String get demo_address;

  /// No description provided for @sort_newest_ucf.
  ///
  /// In en, this message translates to:
  /// **'Sort By Newest'**
  String get sort_newest_ucf;

  /// No description provided for @sort_oldest_ucf.
  ///
  /// In en, this message translates to:
  /// **'Sort By Oldest'**
  String get sort_oldest_ucf;

  /// No description provided for @sort_smallest_ucf.
  ///
  /// In en, this message translates to:
  /// **'Sort By Smallest'**
  String get sort_smallest_ucf;

  /// No description provided for @sort_largest_ucf.
  ///
  /// In en, this message translates to:
  /// **'Sort By Largest'**
  String get sort_largest_ucf;

  /// No description provided for @search_ucf.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_ucf;

  /// No description provided for @product_minimum_qty_required.
  ///
  /// In en, this message translates to:
  /// **'Product Minimum Quantity Required'**
  String get product_minimum_qty_required;

  /// No description provided for @name_required.
  ///
  /// In en, this message translates to:
  /// **'Name  Required'**
  String get name_required;

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Email  Required'**
  String get email_required;

  /// No description provided for @address_required.
  ///
  /// In en, this message translates to:
  /// **'Address  Required'**
  String get address_required;

  /// No description provided for @country_required.
  ///
  /// In en, this message translates to:
  /// **'Country Name  Required'**
  String get country_required;

  /// No description provided for @state_required.
  ///
  /// In en, this message translates to:
  /// **'State Name  Required'**
  String get state_required;

  /// No description provided for @city_required.
  ///
  /// In en, this message translates to:
  /// **'City Name  Required'**
  String get city_required;

  /// No description provided for @postal_code_required.
  ///
  /// In en, this message translates to:
  /// **'Postal Code  Required'**
  String get postal_code_required;

  /// No description provided for @phone_number_required.
  ///
  /// In en, this message translates to:
  /// **'Phone Number  Required'**
  String get phone_number_required;

  /// No description provided for @pos_manager.
  ///
  /// In en, this message translates to:
  /// **'Pos Manager'**
  String get pos_manager;

  /// No description provided for @sub_total.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get sub_total;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @place_order.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get place_order;

  /// No description provided for @no_customer_info.
  ///
  /// In en, this message translates to:
  /// **'No customer information selected.'**
  String get no_customer_info;

  /// No description provided for @confirm_with_cash.
  ///
  /// In en, this message translates to:
  /// **'Confirm with Cash'**
  String get confirm_with_cash;

  /// No description provided for @order_summery.
  ///
  /// In en, this message translates to:
  /// **'Order Summery'**
  String get order_summery;

  /// No description provided for @offline_payment_info.
  ///
  /// In en, this message translates to:
  /// **'Offline Payment Info'**
  String get offline_payment_info;

  /// No description provided for @payment_proof.
  ///
  /// In en, this message translates to:
  /// **'Payment Proof'**
  String get payment_proof;

  /// No description provided for @back_ucf.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back_ucf;

  /// No description provided for @a.
  ///
  /// In en, this message translates to:
  /// **''**
  String get a;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
