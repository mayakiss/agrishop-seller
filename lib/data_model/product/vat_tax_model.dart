
import 'package:active_ecommerce_seller_app/const/dropdown_models.dart';
import 'package:flutter/material.dart';

class VatTaxModel{
  String id ,name;
  VatTaxModel(this.id, this.name);
}
class VatTaxViewModel{
  VatTaxModel vatTaxModel;
  TextEditingController amount= TextEditingController(text: "0");
  List<CommonDropDownItem> items;
  CommonDropDownItem? selectedItem;
  VatTaxViewModel(this.vatTaxModel, this.items,{CommonDropDownItem? selectedItem,String? amount}) {
    this.selectedItem= selectedItem ?? items.first;
    this.amount.text=amount??"0";
  }
}