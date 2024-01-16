import 'package:active_ecommerce_seller_app/const/dropdown_models.dart';

class AttributesModel {
  CommonDropDownItem name;
  List<CommonDropDownItem> attributeItems = [];
  List<CommonDropDownItem> selectedAttributeItems;
  CommonDropDownItem? selectedAttributeItem;

  AttributesModel(this.name, this.attributeItems, this.selectedAttributeItems,
      this.selectedAttributeItem);
}