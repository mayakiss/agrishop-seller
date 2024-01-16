import 'package:active_ecommerce_seller_app/data_model/business_setting_response.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';

import '../repositories/business_setting_repository.dart';

class BusinessSettingHelper {
  setBusinessSettingData() async {
    List<BusinessSettingListResponse> businessLists =
        await BusinessSettingRepository().getBusinessSettingList();

    businessLists.forEach((element) {
      switch (element.type) {
        case 'conversation_system':
          {
            if (element.value.toString() == "1") {
              conversation_activation.$ = true;
            } else {
              conversation_activation.$ = false;
            }
          }
          break;
        case 'product_query_activation':
          {
            if (element.value.toString() == "1") {
              product_query_activation.$ = true;
            } else {
              product_query_activation.$ = false;
            }
          }
          break;
        case 'coupon_system':
          {
            if (element.value.toString() == "1") {
              coupon_activation.$ = true;
            } else {
              coupon_activation.$ = false;
            }
          }
          break;
        case 'product_manage_by_admin':
          {
            if (element.value.toString() == "1") {
              seller_product_manage_admin.$ = true;
            } else {
              seller_product_manage_admin.$ = false;
            }
          }
          break;
        case 'shipping_type':
          {
            if (element.value.toString() == "product_wise_shipping") {
              shipping_type.$ = true;
            } else {
              shipping_type.$ = false;
            }
          }
          break;
        // case 'google_recaptcha':
        //   {
        //     print(element.type.toString());
        //     print(element.value.toString());
        //     if (element.value.toString() == "1") {
        //       google_recaptcha.$ = true;
        //     } else {
        //       google_recaptcha.$ = false;
        //     }
        //   }
        //   break;
        case 'pos_activation_for_seller':
          {
            if (element.value.toString() == "1") {
              pos_manager_activation.$ = true;
            } else {
              pos_manager_activation.$ = false;
            }
          }
          break;
        default:
          {}
          break;
      }
    });
  }
}
