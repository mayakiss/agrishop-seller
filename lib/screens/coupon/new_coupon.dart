import 'dart:convert';
import 'dart:ui';
import 'package:active_ecommerce_seller_app/custom/buttons.dart';
import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/custom/input_decorations.dart';
import 'package:active_ecommerce_seller_app/custom/loading.dart';
import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:active_ecommerce_seller_app/custom/multi_select.dart';
import 'package:active_ecommerce_seller_app/custom/my_app_bar.dart';
import 'package:active_ecommerce_seller_app/custom/my_widget.dart';
import 'package:active_ecommerce_seller_app/const/newCouponOptions.dart';
import 'package:active_ecommerce_seller_app/custom/submitButton.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/main_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/coupon_repository.dart';
import 'package:active_ecommerce_seller_app/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:validators/validators.dart';

class NewCoupon extends StatefulWidget {
  NewCoupon({Key? key}) : super(key: key);

  @override
  State<NewCoupon> createState() => _NewCouponState();
}

class _NewCouponState extends State<NewCoupon> {
  late BuildContext loadingContext;

  List<CouponInformationOptions> _couponInformationList =
      CouponInformationOptions().getList();

  List<CouponDiscountOptions> _couponDiscountTypeList =
      CouponDiscountOptions().getList();
  GlobalKey key = GlobalKey();

  List<SelectProduct> _searchProductList = [];
  List<SelectProduct> _selectedProducts = [];
  List<dynamic> _errors = [];

  CouponInformationOptions? _couponInformation;

  TextEditingController _couponCodeEditController = TextEditingController();
  TextEditingController _discountAmountEditController = TextEditingController();
  TextEditingController _minimumShoppingEditController =
      TextEditingController();
  TextEditingController _maximumDiscountAmountEditController =
      TextEditingController();

  String? _couponProductText;
  String _seachName = "t";
  String _errorMessage = "";
  String _couponCode = "";
  String _discountAmount = "";
  String _minimumShoppingAmount = "";
  String _maximumDiscountAmount = "";
  int count = 0;
  bool hasError = true;

  CouponDiscountOptions? _couponDiscountTypeText;

  String _statAndEndTime =
      DateFormat('MM/d/y').format(DateTime.now()).toString() +
          " - " +
          DateFormat('MM/d/y').format(DateTime.now()).toString();

  _sendCreateCouponReq() async {
    _errors = [];
    var posBody;
    if (_couponInformation!.key == "product_base") {
      List productIds = [];
      _selectedProducts.forEach((element) {
        productIds.add(element.id);
      });

      posBody = jsonEncode({
        "type": "product_base",
        "code": _couponCode,
        "discount": int.parse(_discountAmount),
        "discount_type": _couponDiscountTypeText!.key,
        "product_ids": productIds,
        "date_range": _statAndEndTime
      });
    } else {
      posBody = jsonEncode({
        "type": "cart_base",
        "code": _couponCode,
        "discount": int.parse(_discountAmount),
        "discount_type": _couponDiscountTypeText!.key,
        "min_buy": _minimumShoppingAmount,
        "max_discount": _maximumDiscountAmount,
        "date_range": _statAndEndTime
      });
    }
    dialogShow();
    var res = await CouponRepository().createCoupon(posBody);
    Navigator.pop(loadingContext);
    if (res.result!) {
      ToastComponent.showDialog(res.message,
          bgColor: MyTheme.white,
          textStyle: TextStyle(color: MyTheme.black),
          gravity: Toast.center,
          duration: Toast.lengthLong);
      Navigator.pop(context);
    } else {
      _errors.addAll(res.message);
    }
  }

  resetData() {}

  formValidation() {
    _errors = [];
    _couponCode = _couponCodeEditController.text;
    _discountAmount = _discountAmountEditController.text;
    _minimumShoppingAmount = _minimumShoppingEditController.text;
    _maximumDiscountAmount = _maximumDiscountAmountEditController.text;
    if (_couponCode.isEmpty) {
      _errors
          .add(LangText(context: context).getLocal()!.coupon_code_is_empty_ucf);
    }
    if (_discountAmount.isEmpty || !isNumeric(_discountAmount)) {
      _errors.add(LangText(context: context)
          .getLocal()!
          .discount_amount_is_invalid_ucf);
    }
    if (_couponInformation!.key == "product_base") {
      if (_selectedProducts.isEmpty) {
        _errors.add(LangText(context: context)
            .getLocal()!
            .please_select_minimum_1_product_ucf);
      }
    } else if (_couponInformation!.key == "cart_base") {
      if (!isNumeric(_minimumShoppingAmount)) {
        _errors.add(LangText(context: context)
            .getLocal()!
            .invalid_minimum_shopping_ucf);
      } else if (!isNumeric(_maximumDiscountAmount)) {
        _errors.add(LangText(context: context)
            .getLocal()!
            .invalid_maximum_discount_ucf);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    //getSearchedProductList();
    _couponInformation = _couponInformationList.first;
    _couponDiscountTypeText = _couponDiscountTypeList.first;

    //_couponInformationList.addAll(CouponInformationOptions().getList());
    // TODO: implement initState

    //_couponInformation = "select";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: LangText(context: context).getLocal()!.add_new_coupon_ucf,
      ).show(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              buildCouponInformationContainer(context),
              SizedBox(
                height: 14,
              ),
              _couponInformation!.value != "Select"
                  ? buildShowBox(context)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildShowBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCouponCodeContainer(context),
        SizedBox(
          height: 14,
        ),
        _couponInformation!.value == "For Product"
            ? buildCouponProductContainer()
            : buildForOrderContainer(context),
        SizedBox(
          height: 14,
        ),
        buildCouponDateContainer(),
        SizedBox(
          height: 14,
        ),
        buildCouponDiscountContainer(),
        SizedBox(
          height: 14,
        ),
        buildCouponDiscountTextField(context),
        SizedBox(
          height: 14,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              _errors.length,
              (index) => Text(
                    _errors[index],
                    style: TextStyle(fontSize: 15, color: MyTheme.red),
                  )),
        ),
        SizedBox(
          height: 30,
        ),
        SubmitBtn.show(
            elevation: 5,
            radius: 6,
            width: DeviceInfo(context).getWidth(),
            backgroundColor: MyTheme.app_accent_color,
            alignment: Alignment.center,
            height: 48,
            padding: EdgeInsets.zero,
            onTap: () {
              formValidation();
              print(_errors.isEmpty);
              if (_errors.isEmpty) {
                _sendCreateCouponReq();
              }
            },
            child: Text(
              LangText(context: context).getLocal()!.save_ucf,
              style: TextStyle(fontSize: 17, color: MyTheme.white),
            )),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Column buildCouponDiscountContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.discount_ucf,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(height: 50, child: _buildCouponDiscountList()),
      ],
    );
  }

  Widget buildCouponCodeContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.add_your_coupon_code_ucf,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MyWidget.customCardView(
          backgroundColor: MyTheme.white,
          elevation: 5,
          width: DeviceInfo(context).getWidth(),
          height: 45,
          borderRadius: 10,
          child: TextField(
            controller: _couponCodeEditController,
            decoration: InputDecorations.buildInputDecoration_1(
                hint_text: getLocal(context).coupon_code_ucf,
                borderColor: MyTheme.noColor,
                hintTextColor: MyTheme.grey_153),
          ),
        ),
      ],
    );
  }

  Column buildCouponDiscountTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.amount_ucf,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MyWidget.customCardView(
          backgroundColor: MyTheme.white,
          elevation: 5,
          width: DeviceInfo(context).getWidth(),
          height: 45,
          borderRadius: 10,
          child: TextField(
            controller: _discountAmountEditController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecorations.buildInputDecoration_1(
                hint_text: getLocal(context).amount_ucf,
                borderColor: MyTheme.noColor,
                hintTextColor: MyTheme.grey_153),
          ),
        ),
      ],
    );
  }

  Column buildForOrderContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.minimum_shopping_ucf,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MyWidget.customCardView(
          backgroundColor: MyTheme.white,
          elevation: 5,
          width: DeviceInfo(context).getWidth(),
          height: 45,
          borderRadius: 10,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _minimumShoppingEditController,
            decoration: InputDecorations.buildInputDecoration_1(
                hint_text:
                    LangText(context: context).getLocal()!.minimum_shopping_ucf,
                borderColor: MyTheme.noColor,
                hintTextColor: MyTheme.light_grey),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          LangText(context: context).getLocal()!.maximum_discount_amount_ucf,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MyWidget.customCardView(
          backgroundColor: MyTheme.white,
          elevation: 5,
          width: DeviceInfo(context).getWidth(),
          height: 45,
          borderRadius: 10,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _maximumDiscountAmountEditController,
            decoration: InputDecorations.buildInputDecoration_1(
                hint_text: LangText(context: context)
                    .getLocal()!
                    .maximum_discount_amount_ucf,
                borderColor: MyTheme.noColor,
                hintTextColor: MyTheme.light_grey),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Column buildCouponInformationContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.coupon_information_adding,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(height: 50, child: _buildCouponInformationList()),
      ],
    );
  }

  Column buildCouponProductContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.product_ucf,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          child: Buttons(
              padding: EdgeInsets.zero,
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setSate) {
                        return Container(
                          height: 150,
                          width: 150,
                          child: AlertDialog(
                            //contentPadding: EdgeInsets.zero,
                            actionsPadding: EdgeInsets.zero,
                            contentPadding:
                                EdgeInsets.only(top: 24, right: 24, left: 24),
                            content: productsDialogBox(context, setSate),
                            actions: [
                              Buttons(
                                  onPressed: () {
                                    _selectedProducts = [];
                                    if (_searchProductList.isNotEmpty) {
                                      _searchProductList.forEach((element) {
                                        if (element.isSelect!) {
                                          _selectedProducts.add(element);
                                          print(element.id);
                                        }
                                      });
                                      setState(() {});
                                    }
                                    Navigator.pop(context, _selectedProducts);
                                  },
                                  child: Text(getLocal(context).ok)),
                            ],
                          ),
                        );
                      });
                    });
              },
              child: MyWidget.customCardView(
                  backgroundColor: MyTheme.white,
                  elevation: 5,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  width: DeviceInfo(context).getWidth(),
                  borderRadius: 10.0,
                  borderColor: MyTheme.light_grey,
                  height: 45,
                  child: Text(
                    LangText(context: context).getLocal()!.select_products_ucf,
                    style: TextStyle(color: MyTheme.grey_153),
                  ))),
          //_buildCouponProductList()
        ),
        SizedBox(
          height: 5,
        ),
        build_selectedProductstList()
      ],
    );
  }

  Container build_selectedProductstList() {
    return Container(
      child: Wrap(
        children: List.generate(
            _selectedProducts.length,
            (index) => Container(
                constraints: BoxConstraints(
                    maxWidth: (DeviceInfo(context).getWidth() - 50) / 3),
                margin: EdgeInsets.only(right: 5, bottom: 5),
                child: MyWidget.customCardView(
                  backgroundColor: MyTheme.white,
                  width: DeviceInfo(context).getWidth(),
                  height: 20,
                  alignment: Alignment.centerLeft,
                  borderRadius: 10,
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          constraints: BoxConstraints(maxWidth: 90),
                          child: Text(
                            _selectedProducts[index].name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          )),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          //   color: MyTheme.grey_153
                          // ),
                          child: InkWell(
                            child: Icon(Icons.highlight_remove,
                                size: 15, color: MyTheme.red),
                            onTap: () {
                              _searchProductList.removeWhere((element) {
                                if (element.id == _selectedProducts[index].id) {
                                  return true;
                                }
                                return false;
                              });
                              _selectedProducts.removeAt(index);
                              setState(() {});
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ))),
      ),
    );
  }

  Column buildCouponDateContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.date_ucf,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MyWidget.customCardView(
            backgroundColor: MyTheme.white,
            elevation: 5,
            borderRadius: 6.0,
            borderColor: MyTheme.light_grey,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            width: DeviceInfo(context).getWidth(),
            height: 50,
            child: InkWell(
              onTap: () async {
                // showDateDialog();
                DateTimeRange? time;
                time = await _buildCouponDate();
                setState(() {
                  _statAndEndTime = DateFormat('MM/d/y').format(time!.start) +
                      " - " +
                      DateFormat('MM/d/y').format(time.end);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(_statAndEndTime),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.calendar_today,
                      size: 12,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  // Widget showDateDialog(){
  //
  //   showDialog(context: context, builder: (context){
  //     return AlertDialog(
  //       content: DateRangePickerDialog(
  //
  //         initialDateRange:DateTimeRange(start:DateTime.now(),end: DateTime.now() ) ,
  //         saveText: "Select",
  //         initialEntryMode: DatePickerEntryMode.calendarOnly,
  //         firstDate:_start,lastDate: DateTime.utc(2050),)
  //     );
  //   });
  // }

  Future<DateTimeRange?> _buildCouponDate() async {
    DateTimeRange? p;
    p = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.utc(2050),
        builder: (context, child) {
          return Container(
            color: MyTheme.red,
            width: 500,
            height: 500,
            child: DateRangePickerDialog(
              initialDateRange:
                  DateTimeRange(start: DateTime.now(), end: DateTime.now()),
              saveText: getLocal(context).select_ucf,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              firstDate: DateTime.now(),
              lastDate: DateTime.utc(2050),
            ),
          );
        });

    return p;
  }

  Widget _buildCouponInformationList() {
    return MyWidget.customCardView(
      backgroundColor: MyTheme.white,
      elevation: 5,
      borderRadius: 6.0,
      borderColor: MyTheme.light_grey,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      width: DeviceInfo(context).getWidth(),
      child: DropdownButton<CouponInformationOptions>(
        isDense: true,
        underline: Container(),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            _couponInformation = value;
          });
        },
        icon: Icon(Icons.arrow_drop_down),
        value: _couponInformation,
        items: _couponInformationList
            .map((value) => DropdownMenuItem<CouponInformationOptions>(
                  child: Text(
                    value.value!,
                  ),
                  value: value,
                ))
            .toList(),
      ),
    );
  }

/*
  Widget _buildCouponProductList() {
    return MyWidget.customCardView(
      elevation: 5,
      borderRadius: 6.0,
      borderColor: MyTheme.light_grey,
      padding: EdgeInsets.symmetric(vertical: 14,horizontal: 14),
      width: DeviceInfo(context).getWidth(),
      child: SmartSelect<CouponProduct>.multiple(
        modalType: S2ModalType.bottomSheet,
          modalFilter:true ,
          title: "Choose Product",
          modalConfig:S2ModalConfig(title: "Search Product") ,
          choiceItems: List<S2Choice<CouponProduct>>.generate(_productList.length, (index) =>
              S2Choice<CouponProduct>(value: _productList[index], title:_productList[index].name),
          ),
          value: _chosenProduct,
        onChange: (onChange){
          setState(() {
            _chosenProduct = onChange.value;
          });
      },)
    );
  }*/

  Widget _buildCouponDiscountList() {
    return MyWidget.customCardView(
      backgroundColor: MyTheme.white,
      elevation: 5,
      borderRadius: 6.0,
      borderColor: MyTheme.light_grey,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      width: DeviceInfo(context).getWidth(),
      child: DropdownButton<CouponDiscountOptions>(
        isDense: true,
        underline: Container(),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            _couponDiscountTypeText = value;
          });
        },
        icon: Icon(Icons.arrow_drop_down),
        value: _couponDiscountTypeText,
        items: _couponDiscountTypeList
            .map((value) => DropdownMenuItem(
                  child: Text(
                    value.value!,
                  ),
                  value: value,
                ))
            .toList(),
      ),
    );
  }

  Widget productsDialogBox(BuildContext context, setState) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 290,
        maxHeight: 290,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: DeviceInfo(context).getWidth(),
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: getLocal(context).product_name_ucf,
                border: OutlineInputBorder(
                    gapPadding: 40.0, borderRadius: BorderRadius.circular(20)),
              ),
              onChanged: (string) {
                searchProduct(string, setState);
              },
            ),
          ),
          Container(
            height: 240,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _searchProductList.isNotEmpty
                    ? List.generate(
                        _searchProductList.length,
                        (index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: DeviceInfo(context).getWidth() / 2,
                                  child: Text(
                                    _searchProductList[index].name!,
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                  ),
                                ),
                                Checkbox(
                                    value: _searchProductList[index].isSelect,
                                    onChanged: (value) {
                                      setState(() {
                                        _searchProductList[index].isSelect =
                                            value;
                                        _selectedProducts = [];
                                        _searchProductList.forEach((element) {
                                          if (element.isSelect!) {
                                            _selectedProducts.add(element);
                                            print(element.id);
                                          }
                                        });
                                      });
                                    })
                              ],
                            ))
                    : List.generate(
                        1,
                        (index) =>
                            Text(getLocal(context).no_product_is_available)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchProduct(String value, setState) async {
    _searchProductList.removeWhere((element) {
      if (element.isSelect!) {
        return false;
      }
      return true;
    });

    var resPonse = await CouponRepository().searchProducts(value);

    resPonse.data!.forEach((element) {
      bool idHas = false;
      _searchProductList.forEach((element2) {
        if (element.id == element2.id) {
          idHas = true;
        }
      });
      if (!idHas) {
        _searchProductList.add(
            SelectProduct(id: element.id, name: element.name, isSelect: false));
      }
    });
    setState(() {});
  }

  dialogShow() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          loadingContext = context;
          return AlertDialog(
              content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text("${LangText(context: context).getLocal()!.please_wait_ucf}"),
            ],
          ));
        });
  }
}
