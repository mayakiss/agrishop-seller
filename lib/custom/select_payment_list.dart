import 'package:one_context/one_context.dart';

import 'localization.dart';

class PaymentType {
  String key, value;
  PaymentType(this.key, this.value);
}

class PaymentOption {
  static List<PaymentType> getList() {
    List<PaymentType> list = [];
    list.add(PaymentType("select",
        LangText(context: OneContext().context).getLocal().select_ucf));
    list.add(PaymentType("offline",
        LangText(context: OneContext().context).getLocal().offline_ucf));
    list.add(PaymentType("online",
        LangText(context: OneContext().context).getLocal().online_ucf));
    return list;
  }
}
