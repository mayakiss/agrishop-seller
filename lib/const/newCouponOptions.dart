import 'package:one_context/one_context.dart';

import '../custom/localization.dart';

class CouponInformationOptions {
  String? value, key;
  CouponInformationOptions({this.value, this.key});
  List<CouponInformationOptions> getList() {
    List<CouponInformationOptions> list = [];
    list.add(CouponInformationOptions(
        value: LangText(context: OneContext().context).getLocal().select_ucf,
        key: ""));
    list.add(CouponInformationOptions(
        value:
            LangText(context: OneContext().context).getLocal().for_product_ucf,
        key: "product_base"));
    list.add(CouponInformationOptions(
        value: LangText(context: OneContext().context)
            .getLocal()
            .for_total_orders_ucf,
        key: "cart_base"));
    return list;
  }
}

class CouponDiscountOptions {
  String? value, key;
  CouponDiscountOptions({this.value, this.key});
  List<CouponDiscountOptions> getList() {
    List<CouponDiscountOptions> list = [];
    list.add(CouponDiscountOptions(
        value: LangText(context: OneContext().context).getLocal().amount_ucf,
        key: "amount"));
    list.add(CouponDiscountOptions(
        value:
            LangText(context: OneContext().context).getLocal().percentage_ucf,
        key: "percent"));
    return list;
  }
}
