import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:one_context/one_context.dart';

class DeliveryStatus {
  String option_key;
  String name;

  DeliveryStatus(this.option_key, this.name);

  static List<DeliveryStatus> getDeliveryStatusList() {
    return <DeliveryStatus>[
      DeliveryStatus('', LangText(context: OneContext().context).getLocal()!.all_ucf),
      DeliveryStatus('pending', LangText(context: OneContext().context).getLocal()!.pending_ucf),
      DeliveryStatus('confirmed', LangText(context: OneContext().context).getLocal()!.confirmed_ucf),
      DeliveryStatus('picked_up', LangText(context: OneContext().context).getLocal()!.picked_up_ucf),
      DeliveryStatus('on_the_way', LangText(context: OneContext().context).getLocal()!.on_the_way_ucf),
      DeliveryStatus('delivered', LangText(context: OneContext().context).getLocal()!.delivered_ucf),
      DeliveryStatus('cancelled', LangText(context: OneContext().context).getLocal()!.cancel_ucf),
    ];
  }

    static List<DeliveryStatus> getDeliveryStatusListForUpdate() {
    return <DeliveryStatus>[
      DeliveryStatus('pending', LangText(context: OneContext().context).getLocal()!.pending_ucf),
      DeliveryStatus('confirmed', LangText(context: OneContext().context).getLocal()!.confirmed_ucf),
      DeliveryStatus('picked_up', LangText(context: OneContext().context).getLocal()!.picked_up_ucf),
      DeliveryStatus('on_the_way', LangText(context: OneContext().context).getLocal()!.on_the_way_ucf),
      DeliveryStatus('delivered', LangText(context: OneContext().context).getLocal()!.delivered_ucf),
      DeliveryStatus('cancelled', LangText(context: OneContext().context).getLocal()!.cancel_ucf),
    ];
  }

}