import 'dart:convert';

import 'package:active_ecommerce_seller_app/custom/pos_widgets/pos_btn.dart';
import 'package:active_ecommerce_seller_app/custom/pos_widgets/pos_text_Price.dart';
import 'package:active_ecommerce_seller_app/data_model/seller-pos/pos_shipping_address_response.dart';
import 'package:active_ecommerce_seller_app/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_seller_app/repositories/pos_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:one_context/one_context.dart';
import 'package:toast/toast.dart';

import '../../const/dropdown_models.dart';
import '../../custom/buttons.dart';
import '../../custom/decorations.dart';
import '../../custom/device_info.dart';
import '../../custom/loading.dart';
import '../../custom/localization.dart';
import '../../custom/my_app_bar.dart';
import '../../custom/my_widget.dart';
import '../../custom/pos_widgets/pos_add_product_widget.dart';
import '../../custom/pos_widgets/pos_customer_info_row.dart';
import '../../custom/pos_widgets/pos_item_card.dart';
import '../../custom/pos_widgets/pos_product_list_widget.dart';
import '../../custom/pos_widgets/pos_ship_discount_dialog.dart';
import '../../custom/toast_component.dart';
import '../../data_model/city_response.dart';
import '../../data_model/country_response.dart';
import '../../data_model/product/category_response_model.dart';
import '../../data_model/product/category_view_model.dart';
import '../../data_model/seller-pos/pos_product_response.dart';
import '../../data_model/seller-pos/pos_user_cart_data_response.dart';
import '../../data_model/state_response.dart';
import '../../data_model/uploaded_file_list_response.dart';
import '../../helpers/main_helper.dart';
import '../../helpers/shared_value_helper.dart';
import '../../my_theme.dart';
import '../../repositories/address_repository.dart';
import '../../repositories/product_repository.dart';
import '../uploads/upload_file.dart';

class PosManager extends StatefulWidget {
  const PosManager({Key? key}) : super(key: key);

  @override
  State<PosManager> createState() => _PosManagerState();
}

class Product {
  final String name;

  Product(this.name);
}

class _PosManagerState extends State<PosManager> {
  final TextEditingController _shippingController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  //shipping address controllers
  final TextEditingController _shippingAddressController =
      TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // payment method controllers
  final TextEditingController _paymentMethodController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _transactionController = TextEditingController();

  // Initial Selected Value
  bool isSetCustomerInfo = false;
  List<Product> products = [];
  bool showAddAddressBtn = true;
  int? _selected_shipping_address;
  FileInfo? paymentProof;

// category
  CategoryModel? selectedCategory;
  List<CategoryModel> categories = [];

  //brand
  CommonDropDownItem? selectedBrand;
  List<CommonDropDownItem> brands = [];

  CommonDropDownItem? selectedCustomer;
  String? sessionUser;
  List<CommonDropDownItem> customers = [];
  List<PosShippingAddressList> shippingAddress = [];
  PosShippingAddressList? tmpShippingAddress;
  int? selectedProduct;
  String? tempUserdata;

  // selected products

  final List<PosProductData> _posProductList = [];
  UserCartData? posUserCartData;
  bool _isPosProductInit = false;
  bool _isUserCartData = false;
  bool _showMoreProductLoadingContainer = false;

  //############################
  /// This
  /// section
  /// is for
  /// shipping address

  City? _selected_city;
  Country? _selected_country;
  MyState? _selected_state;
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  Map walkCustomerPostValue = {};

  onSelectCountryDuringAdd(country, setModalState) {
    if (_selected_country != null && country.id == _selected_country!.id) {
      setModalState(() {
        _countryController.text = country.name;
      });
      return;
    }
    _selected_country = country;
    _selected_state = null;
    _selected_city = null;
    setState(() {});

    setModalState(() {
      _countryController.text = country.name;
      _stateController.text = "";
      _cityController.text = "";
    });
  }

  onSelectStateDuringAdd(state, setModalState) {
    if (_selected_state != null && state.id == _selected_state!.id) {
      setModalState(() {
        _stateController.text = state.name;
      });
      return;
    }
    _selected_state = state;
    _selected_city = null;
    setState(() {});
    setModalState(() {
      _stateController.text = state.name;
      _cityController.text = "";
    });
  }

  onSelectCityDuringAdd(city, setModalState) {
    if (_selected_city != null && city.id == _selected_city!.id) {
      setModalState(() {
        _cityController.text = city.name;
      });
      return;
    }
    _selected_city = city;
    setModalState(() {
      _cityController.text = city.name;
    });
  }

  onTapSelectProduct(index, setState) async {
    if (selectedProduct == null) {
      if (index != selectedProduct) {
        selectedProduct = index;
        setState(() {});
      }
    } else {
      selectedProduct = index;
      setState(() {});
    }
    // product stock id
    Map postValue = {};
    postValue.addAll({
      "stock_id": _posProductList[selectedProduct!].stockId,
      "userID": selectedCustomer != null ? selectedCustomer!.key : null,
      "temUserId":
          (selectedCustomer?.key?.isEmpty ?? true) ? tempUserdata : null,
    });

    var response = await PosRepository().posAddToCart(jsonEncode(postValue));

    if (response.success == 1) {
      // setting temp user data;
      tempUserdata = response.temUserId;
      setState(() {});

      ToastComponent.showDialog(response.message!,
          bgColor: MyTheme.white,
          duration: Toast.lengthLong,
          gravity: Toast.center);
    } else {
      ToastComponent.showDialog(response.message!,
          bgColor: MyTheme.white,
          duration: Toast.lengthLong,
          gravity: Toast.center);
    }

    getCartData();
  }

  Future<void> getCartData() async {
    Map postValue2 = {};
    postValue2.addAll({
      "userId": selectedCustomer?.key?.isNotEmpty ?? false
          ? selectedCustomer!.key
          : null,
      "tempUserId": selectedCustomer?.key?.isEmpty ?? false ? tempUserdata : '',
      "shippingCost": _shippingController.text,
      "discount": _discountController.text
    });

    var posUserCartDataList =
        await PosRepository().posUserCartData(jsonEncode(postValue2));
    posUserCartData = posUserCartDataList.data!;
    _isUserCartData = true;

    setState(() {});
  }

  updateUserData() async {
    Map postValue = {};
    if ((selectedCustomer?.key == sessionUser) && tempUserdata == null) {
      sessionUser = null;
    }
    if ((selectedCustomer?.key?.isNotEmpty ?? false) &&
        (sessionUser?.isNotEmpty ?? false)) {
      tempUserdata = null;
    }
    postValue.addAll({
      "userId": (selectedCustomer?.key?.isNotEmpty ?? false)
          ? selectedCustomer?.key
          : '',
      "sessionUserId": sessionUser,
      "sessionTemUserId": tempUserdata,
    });

    var updateUserResponse =
        await PosRepository().updateUser(jsonEncode(postValue));
    sessionUser = updateUserResponse.userId;
    tempUserdata = updateUserResponse.temUserId;
    getCartData();
  }

  bool requiredFieldVerification() {
    if (selectedCustomer?.key?.isEmpty ?? true) {
      if (_nameController.text.trim().toString().isEmpty) {
        ToastComponent.showDialog(
            LangText(context: context).getLocal()!.name_required,
            gravity: Toast.center);
        return false;
      } else if (_emailController.text.trim().toString().isEmpty) {
        ToastComponent.showDialog(
            LangText(context: context).getLocal()!.email_required,
            gravity: Toast.center);
        return false;
      }
    }

    if (_shippingAddressController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal()!.address_required,
          gravity: Toast.center);
      return false;
    } else if (_countryController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal()!.country_required,
          gravity: Toast.center);
      return false;
    } else if (_stateController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal()!.state_required,
          gravity: Toast.center);
      return false;
    } else if (_cityController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal()!.city_required,
          gravity: Toast.center);
      return false;
    } else if (_postalCodeController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal()!.postal_code_required,
          gravity: Toast.center);
      return false;
    } else if (_phoneController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal()!.phone_number_required,
          gravity: Toast.center);
      return false;
    }
    return true;
  }

  createShippingAddressForWalkInCustomer(setState) async {
    if (!requiredFieldVerification()) {
      return;
    }
    walkCustomerPostValue.addAll({
      "user_id": tempUserdata,
      "address": _shippingAddressController.text,
      "email": _emailController.text,
      "name": _nameController.text,
      "country_id": _selected_country!.id.toString(),
      "state_id": _selected_state!.id.toString(),
      "city_id": _selected_city!.id.toString(),
      "postal_code": _postalCodeController.text,
      "phone": _phoneController.text,
    });

    // print(walkCustomerPostValue);
  }

  submitCreateShippingAddress(setState, context) async {
    if (!requiredFieldVerification()) {
      return;
    }

    if (selectedCustomer?.key?.isEmpty ?? false) {
      tmpShippingAddress = PosShippingAddressList(
          name: _nameController.text,
          email: _emailController.text,
          address: _shippingAddressController.text,
          countryName: _selected_country?.name ?? "",
          stateName: _selected_state?.name ?? "",
          cityName: _selected_city?.name ?? "",
          postalCode: _postalCodeController.text,
          phone: _phoneController.text);
      Navigator.pop(OneContext().context!);
      return;
    }

    Map postValue = {};
    postValue.addAll({
      "user_id": selectedCustomer!.key.toString(),
      "address": _shippingAddressController.text,
      "country_id": _selected_country!.id.toString(),
      "state_id": _selected_state!.id.toString(),
      "city_id": _selected_city!.id.toString(),
      "postal_code": _postalCodeController.text,
      "phone": _phoneController.text,
    });

    Loading.setInstance(context);
    Loading().show();

    var response =
        await PosRepository().createShippingAddress(jsonEncode(postValue));

    Loading().hide();

    if (response.result!) {
      await getShippingAddress();
      ToastComponent.showDialog(response.message!,
          bgColor: MyTheme.white,
          duration: Toast.lengthLong,
          gravity: Toast.center);
      // clear data
      resetForm(setState);
    } else {
      ToastComponent.showDialog(response.message!,
          bgColor: MyTheme.white,
          duration: Toast.lengthLong,
          gravity: Toast.center);
    }
  }

  resetForm(setState) {
    showAddAddressBtn = true;
    setState(() {});
    _shippingAddressController.clear();
    _selected_country = null;
    _selected_state = null;
    _selected_city = null;
    _postalCodeController.clear();
    _phoneController.clear();

    // shippingAddress = [];
    // getShippingAddress(id: selectedCustomer!.key);
    // Navigator.pop(context);
  }

  getShippingAddress() async {
    shippingAddress.clear();
    var shippingAddressResponse =
        await PosRepository().getShippingAddress(id: selectedCustomer!.key);
    shippingAddress.addAll(shippingAddressResponse.data!);
    setState(() {});
  }

  selectProduct() {
    return OneContext().showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LangText(context: context).getLocal()!.select_products_ucf,
                style: const TextStyle(
                    fontSize: 16, color: MyTheme.app_accent_color),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  'assets/icon/cross.png',
                  width: 16,
                  height: 16,
                ),
              )
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              if (!_isPosProductInit) {
                getPosProduct(setState);
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    buildSearchBox(setState),
                    itemSpacer(height: 10.0),
                    buildSelectCategoryBrand(setState),
                    itemSpacer(height: 10.0),
                    SizedBox(
                      height: 533,
                      width: 400,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemCount:
                            _isPosProductInit ? _posProductList.length : 30,
                        itemBuilder: (BuildContext context, int index) {
                          return _isPosProductInit
                              ? GestureDetector(
                                  onTap: () {
                                    onTapSelectProduct(index, setState);
                                  },
                                  child: Stack(children: [
                                    PosItemCard(
                                      name: _posProductList[index].name,
                                      thumbnailImage:
                                          _posProductList[index].thumbnailImage,
                                      price: _posProductList[index].price,
                                      qty: _posProductList[index].qty,
                                    ),
                                    Positioned(
                                      right: 16,
                                      top: 16,
                                      child: buildCheckContainer(
                                        selectedProduct == index,
                                      ),
                                    )
                                  ]),
                                )
                              : ShimmerHelper().buildBoxShimmer();
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  getCategories() async {
    var categoryResponse = await ProductRepository().getCategoryRes();
    categories.add(CategoryModel(
        levelText: LangText(context: context).getLocal()!.select_ucf, id: ""));
    categoryResponse.data!.forEach((element) {
      CategoryModel model = CategoryModel(
          id: element.id.toString(),
          level: element.level,
          levelText: element.name,
          parentLevel: element.parentId.toString());
      categories.add(model);
      if (element.child!.isNotEmpty) {
        setChildCategory(element.child!);
      }
    });
    if (categories.isNotEmpty) {
      selectedCategory = categories.first;
    }
    setState(() {});
  }

  setChildCategory(List<Category> child) {
    child.forEach((element) {
      CategoryModel model = CategoryModel(
          id: element.id.toString(),
          level: element.level,
          levelText: element.name,
          parentLevel: element.parentId.toString());
      if (element.level > 0) {
        model.setLevelText();
      }
      categories.add(model);
      if (element.child!.isNotEmpty) {
        setChildCategory(element.child!);
      }
    });
  }

  getBrands() async {
    var brandsRes = await ProductRepository().getBrandRes();
    brands.add(CommonDropDownItem(
        "", LangText(context: context).getLocal()!.select_ucf));
    brandsRes.data!.forEach((element) {
      brands.addAll([
        CommonDropDownItem("${element.id}", element.name),
      ]);
    });
    selectedBrand = brands.first;
    setState(() {});
  }

  getCustomers() async {
    var customerResponse = await PosRepository().getCustomers();
    customers.add(CommonDropDownItem("", getLocal(context).walk_in_customer));
    customerResponse.data!.forEach((element) {
      customers.add(CommonDropDownItem("${element.id}", element.name));
    });
    if (customers.isNotEmpty) {
      selectedCustomer = customers.first;
    }
    setState(() {});
  }

  getPosProduct(setState) async {
    // todo: for now category no need because of "category-1"
    var posProductResponse = await PosRepository().getPosProducts(
        category: selectedCategory?.id,
        brand: selectedBrand?.key ?? null,
        keyword: _searchController.text);
    if (posProductResponse.products!.data!.isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal()!.no_more_products_ucf,
          gravity: Toast.center,
          bgColor: MyTheme.white,
          textStyle: const TextStyle(color: Colors.black));
    }
    _posProductList.addAll(posProductResponse.products!.data!);
    _showMoreProductLoadingContainer = false;
    _isPosProductInit = true;
    setState(() {});
  }

  filterProduct(setState) {
    _posProductList.clear();
    getPosProduct(setState);
  }

  onSubmitPOS(paymentType) async {
    String? offline_trx_id,
        offline_payment_method,
        offline_payment_amount,
        offline_payment_proof;

    if (paymentType == "offline_payment") {
      offline_payment_amount = _amountController.text.trim().toString();
      offline_payment_method = _paymentMethodController.text.trim();
      offline_trx_id = _transactionController.text.trim();
      offline_payment_proof = (paymentProof?.id ?? 0).toString();
    }

    var shippingInfo = {
      "name": tmpShippingAddress?.name,
      "email": tmpShippingAddress?.email,
      "address": tmpShippingAddress?.address,
      "country": tmpShippingAddress?.countryName,
      "state": tmpShippingAddress?.stateName,
      "city": tmpShippingAddress?.cityName,
      "postal_code": tmpShippingAddress?.postalCode,
      "phone": tmpShippingAddress?.phone,
    };
    OneContextLoading.show();

    var response = await PosRepository().createPOS(
        discount: _discountController.text,
        userId: selectedCustomer?.key,
        tmpUserId: tempUserdata,
        paymentType: paymentType,
        shippingCost: posUserCartData?.shippingCost,
        offlinePaymentAmount: offline_payment_amount,
        offlinePaymentMethod: offline_payment_method,
        offlinePaymentProof: offline_payment_proof,
        offlineTrxId: offline_trx_id,
        shippingInfo: shippingInfo);

    Navigator.pop(OneContext().context!);
    OneContextLoading.hide();

    ToastComponent.showDialog(response.message);
    reFresh();
  }

  fetchAll() {
    getCartData();
    getCustomers();
    getCategories();
    getBrands();
  }

  reset() {
    customers.clear();
    tmpShippingAddress = null;
    products.clear();
    _selected_shipping_address = null;
    showAddAddressBtn = true;

    _nameController.clear();
    _emailController.clear();
    _shippingAddressController.clear();
    _selected_country = null;
    _selected_state = null;
    _selected_city = null;
    _postalCodeController.clear();
    _phoneController.clear();
    selectedProduct = null;
    _countryController.clear();
    _stateController.clear();
    _cityController.clear();
    _shippingController.clear();
    _discountController.clear();
  }

  reFresh() {
    reset();
    fetchAll();
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchAll();
    super.initState();
  }

  @override
  void dispose() {
    _shippingController.dispose();
    _discountController.dispose();
    _searchController.dispose();
    _shippingAddressController.dispose();
    _postalCodeController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _paymentMethodController.dispose();
    _amountController.dispose();
    _transactionController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          title: getLocal(context).pos_manager,
        ).show(),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return !_isUserCartData
        ? ShimmerHelper().buildPosShimmer()
        : Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyWidget.customCardView(
                      borderRadius: 6,
                      elevation: 5,
                      borderColor: MyTheme.light_grey,
                      backgroundColor: MyTheme.app_accent_color_extra_light,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      height: 36,
                      width: DeviceInfo(context).getWidth() * .7,
                      child: DropdownButton<CommonDropDownItem>(
                        menuMaxHeight: 300,
                        isDense: true,
                        underline: Container(),
                        isExpanded: true,
                        onChanged: (CommonDropDownItem? value) {
                          if (value != null) {
                            selectedCustomer = value;
                            shippingAddress = [];
                            getShippingAddress();
                            updateUserData();
                            setState(() {});
                          }
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                        value: selectedCustomer,
                        items: customers
                            .map(
                              (value) => DropdownMenuItem<CommonDropDownItem>(
                                value: value,
                                child: Text(
                                  value.value!,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setShippingAddress(),
                      child: MyWidget.customCardView(
                        borderRadius: 6,
                        elevation: 5,
                        borderColor: MyTheme.light_grey,
                        backgroundColor: MyTheme.app_accent_color_extra_light,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        height: 36,
                        width: DeviceInfo(context).getWidth() * .13,
                        child: Image.asset(
                          "assets/icon/car2.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              itemSpacer(),
              // product list view and add button

              if (posUserCartData!.cartData!.data!.isEmpty)
                PosAddProductWidget(
                  height: 245,
                  onTap: selectProduct,
                ),

              if (posUserCartData!.cartData!.data!.isNotEmpty)
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(4),
                      itemCount: posUserCartData!.cartData!.data!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          itemSpacer(height: 10.0),
                      itemBuilder: (BuildContext context, int index) {
                        return PosProductListWidget(
                          deleteCart: () async {
                            getCartData();
                          },
                          updateCart: () async {
                            getCartData();
                          },
                          productName: posUserCartData!
                              .cartData!.data![index].productName,
                          price: posUserCartData!.cartData!.data![index].price
                              .toString(),
                          cartId: posUserCartData!.cartData!.data![index].id!,
                          stock: posUserCartData!
                              .cartData!.data![index].stockQty
                              .toString(),
                          cartQty: posUserCartData!
                              .cartData!.data![index].cartQuantity
                              .toString(),
                          minQty: posUserCartData!
                                  .cartData!.data![index].minPurchaseQty ??
                              1,
                        );
                      },
                    ),
                  ),
                ),
              if (posUserCartData!.cartData!.data!.isEmpty) const Spacer(),
              if (posUserCartData!.cartData!.data!.isNotEmpty)
                PosAddProductWidget(
                  height: 70,
                  onTap: selectProduct,
                ),
              itemSpacer(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 127.0,
                  child: Column(
                    children: [
                      PosTextPrice(
                          title: getLocal(context).sub_total,
                          price: posUserCartData!.subtotal.toString()),
                      itemSpacer(height: 5.0),
                      PosTextPrice(
                          title: getLocal(context).tax,
                          price: posUserCartData!.tax.toString()),
                      itemSpacer(height: 5.0),
                      PosTextPrice(
                          title: getLocal(context).shipping_cost_ucf,
                          price: posUserCartData!.shippingCost_str.toString()),
                      itemSpacer(height: 5.0),
                      PosTextPrice(
                          title: getLocal(context).discount_ucf,
                          price: posUserCartData!.discount.toString()),
                      itemSpacer(),
                      itemDivider(),
                      itemSpacer(height: 8.0),
                      PosTextPrice(
                          title: getLocal(context).total,
                          price: posUserCartData!.total.toString()),
                    ],
                  ),
                ),
              ),
              itemSpacer(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20.0, left: 20.0, bottom: 17.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        PosBtn(
                          text: getLocal(context).shipping,
                          icon: Icons.keyboard_arrow_up,
                          color: MyTheme.app_accent_color_extra_light,
                          onTap: shipping,
                        ),
                        itemSpacer(width: 10.0),
                        PosBtn(
                            text: getLocal(context).discount_ucf,
                            icon: Icons.keyboard_arrow_up,
                            color: MyTheme.app_accent_color_extra_light,
                            onTap: discount)
                      ],
                    ),
                    PosBtn(
                        text: getLocal(context).place_order,
                        color: MyTheme.app_accent_color,
                        textColor: MyTheme.white,
                        fontWeight: FontWeight.bold,
                        onTap: orderSummery)
                  ],
                ),
              )
            ],
          );
  }

  itemSpacer({height = 10.0, width = 0.0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  itemDivider() {
    return const Divider(
      height: 3,
      color: MyTheme.grey_153,
    );
  }

  Widget buildSelectCategoryBrand(setState) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  getLocal(context).select_category_ucf,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.font_grey),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  getLocal(context).select_brand_ucf,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.font_grey),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 46,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: MDecoration.decoration1(),
                      child: DropdownButton<CategoryModel>(
                        menuMaxHeight: 300,
                        isDense: true,
                        underline: Container(),
                        isExpanded: true,
                        onChanged: (CategoryModel? value) {
                          selectedCategory = value;
                          setState(() {});
                          filterProduct(setState);
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                        value: selectedCategory,
                        items: categories
                            .map(
                              (value) => DropdownMenuItem<CategoryModel>(
                                value: value,
                                child: Text(
                                  value.levelText!,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )),
                itemSpacer(width: 8.0),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 46,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    decoration: MDecoration.decoration1(),
                    child: DropdownButton<CommonDropDownItem>(
                      menuMaxHeight: 300,
                      isDense: true,
                      underline: Container(),
                      isExpanded: true,
                      onChanged: (CommonDropDownItem? value) {
                        selectedBrand = value;
                        setState(() {});
                        filterProduct(setState);
                      },
                      icon: const Icon(Icons.arrow_drop_down),
                      value: selectedBrand,
                      items: brands
                          .map(
                            (value) => DropdownMenuItem<CommonDropDownItem>(
                              value: value,
                              child: Text(
                                value.value!,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBox(setState) {
    return buildCommonTypeAheadDecoration(
      child: TextField(
        controller: _searchController,
        decoration: buildAddressInputDecoration(
          context,
          getLocal(context).search_by_product_name_barcode,
        ),
        onEditingComplete: () async {
          filterProduct(setState);
          // await PosRepository().getPosProducts(keyword: _searchController.text);
        },
        onChanged: (text) {
          if (text != null && text.trim().isNotEmpty) {
            filterProduct(setState);
          }
        },
      ),
    );
  }

  buildOrderSummery() {
    var cartData = posUserCartData?.cartData?.data;
    _amountController.text = posUserCartData!.total!;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if not products in the list
          if (false)
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: const Text(
                'No Product found!',
                style: TextStyle(
                  fontSize: 14,
                  color: MyTheme.font_grey,
                ),
              ),
            ),
          // if  products in the list

          if (true)
            SizedBox(
              height: 180,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      itemSpacer(height: 10.0),
                  itemCount: cartData?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return MyWidget.customCardView(
                      backgroundColor: MyTheme.white,
                      height: 70,
                      borderColor: MyTheme.light_grey,
                      borderRadius: 6,
                      child: Row(
                        children: [
                          MyWidget.imageWithPlaceholder(
                            width: 84.0,
                            height: 70.0,
                            fit: BoxFit.cover,
                            url: "imageUrl",
                            radius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartData?[index].productName ?? "",
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: MyTheme.app_accent_color,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cartData?[index].price.toString() ?? "",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: MyTheme.app_accent_color,
                                        ),
                                      ),
                                      Text(
                                        (cartData?[index].cartQuantity ?? 0)
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: MyTheme.app_accent_color,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          itemSpacer(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: MyTheme.textfield_grey, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getLocal(context).customer_info_ucf,
                  style: const TextStyle(
                    fontSize: 14,
                    color: MyTheme.font_grey,
                  ),
                ),
                const Divider(),
                SizedBox(
                  width: double.infinity,
                  child: isSetCustomerInfo
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: Text(
                            getLocal(context).no_customer_info,
                            style: const TextStyle(
                              fontSize: 12,
                              color: MyTheme.font_grey,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Column(
                              children: [
                                PosCustomerInfoRow(
                                    title: getLocal(context).name_ucf,
                                    content: tmpShippingAddress?.name),
                                itemSpacer(height: 3.0),
                                PosCustomerInfoRow(
                                    title: getLocal(context).email_ucf,
                                    content: tmpShippingAddress?.email),
                                itemSpacer(height: 3.0),
                                PosCustomerInfoRow(
                                    title: getLocal(context).phone_ucf,
                                    content: tmpShippingAddress?.phone),
                                itemSpacer(height: 3.0),
                                PosCustomerInfoRow(
                                    title: getLocal(context).address_ucf,
                                    content: tmpShippingAddress?.address),
                                itemSpacer(height: 3.0),
                                PosCustomerInfoRow(
                                    title: getLocal(context).country_ucf,
                                    content: tmpShippingAddress?.countryName),
                                itemSpacer(height: 3.0),
                                PosCustomerInfoRow(
                                    title: getLocal(context).state_ucf,
                                    content: tmpShippingAddress?.stateName),
                                itemSpacer(height: 3.0),
                                PosCustomerInfoRow(
                                    title: getLocal(context).city_ucf,
                                    content: tmpShippingAddress?.cityName),
                                itemSpacer(height: 3.0),
                                PosCustomerInfoRow(
                                    title: getLocal(context).postal_code_ucf,
                                    content: tmpShippingAddress?.postalCode),
                                itemSpacer(height: 3.0),
                              ],
                            )
                          ],
                        ),
                ),
              ],
            ),
          ),
          itemSpacer(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 110.0,
            child: Column(
              children: [
                PosTextPrice(
                    title: getLocal(context).sub_total_all_capital,
                    price: posUserCartData?.subtotal),
                itemSpacer(height: 3.0),
                PosTextPrice(
                    title: getLocal(context).tax_all_capital,
                    price: posUserCartData?.tax),
                itemSpacer(height: 3.0),
                PosTextPrice(
                    title: getLocal(context).shipping_cost_all_capital,
                    price: posUserCartData!.shippingCost_str),
                itemSpacer(height: 3.0),
                PosTextPrice(
                    title: getLocal(context).discount_all_capital,
                    price: posUserCartData?.discount),
                itemSpacer(),
                itemDivider(),
                itemSpacer(height: 5.0),
                PosTextPrice(
                    title: getLocal(context).total_amount_ucf,
                    price: posUserCartData?.total),
              ],
            ),
          ),
          itemSpacer(height: 5.0),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (offline_payment_addon.$)
                GestureDetector(
                  onTap: offlinePayment,
                  child: PosBtn(
                    text: getLocal(context).offline_payment_ucf,
                    color: MyTheme.app_accent_color,
                    textColor: MyTheme.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              itemSpacer(height: 5.0),
              PosBtn(
                text: getLocal(context).cash_on_delivery_ucf,
                color: MyTheme.app_accent_color,
                textColor: MyTheme.white,
                fontWeight: FontWeight.bold,
                onTap: () {
                  onSubmitPOS("cash_on_delivery");
                },
              ),
              itemSpacer(height: 5.0),
              PosBtn(
                onTap: () {
                  onSubmitPOS("cash");
                },
                text: getLocal(context).confirm_with_cash,
                color: MyTheme.app_accent_color,
                textColor: MyTheme.white,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ],
      ),
    );
  }

  shipping() {
    return OneContext().showDialog(
      builder: (BuildContext context) {
        return PosShipDiscountDialog(
          controller: _shippingController,
          title: getLocal(context).shipping,
          callback: getCartData,
        );
      },
    );
  }

  discount() {
    return OneContext().showDialog(
      builder: (BuildContext context) {
        return PosShipDiscountDialog(
          controller: _discountController,
          title: getLocal(context).discount_ucf,
          callback: getCartData,
        );
      },
    );
  }

  orderSummery() {
    return OneContext().showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10.0),
          contentPadding: const EdgeInsets.all(20.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getLocal(context).order_summery,
                style: const TextStyle(
                    fontSize: 16, color: MyTheme.app_accent_color),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  'assets/icon/cross.png',
                  width: 16,
                  height: 16,
                ),
              )
            ],
          ),
          content: SizedBox(
            width: DeviceInfo(context).getWidth(),
            child: buildOrderSummery(),
          ),
        );
      },
    );
  }

  offlinePayment() {
    return OneContext().showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
            insetPadding: const EdgeInsets.all(10.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getLocal(context).offline_payment_info,
                  style: const TextStyle(
                      fontSize: 16, color: MyTheme.app_accent_color),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    'assets/icon/cross.png',
                    width: 16,
                    height: 16,
                  ),
                )
              ],
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildCommonSingleField(
                        getLocal(context).payment_method_ucf,
                        buildCommonTypeAheadDecoration(
                          child: TextField(
                            controller: _paymentMethodController,
                            decoration: buildAddressInputDecoration(
                                context, getLocal(context).name_ucf),
                          ),
                        ),
                        isMandatory: false,
                      ),
                      itemSpacer(),
                      buildCommonSingleField(
                        getLocal(context).amount_ucf,
                        buildCommonTypeAheadDecoration(
                          child: TextField(
                            readOnly: true,
                            controller: _amountController,
                            decoration: buildAddressInputDecoration(
                                context, getLocal(context).amount_ucf),
                          ),
                        ),
                        isMandatory: false,
                      ),
                      itemSpacer(),
                      buildCommonSingleField(
                        getLocal(context).transaction_id_ucf,
                        buildCommonTypeAheadDecoration(
                          child: TextField(
                            controller: _transactionController,
                            decoration: buildAddressInputDecoration(
                                context, getLocal(context).transaction_id_ucf),
                          ),
                        ),
                        isMandatory: false,
                      ),
                      itemSpacer(),
                      buildCommonSingleField(
                        getLocal(context).payment_proof,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Buttons(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                // XFile chooseFile = await pickSingleImage();
                                List<FileInfo> chooseFile =
                                    await (Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UploadFile(
                                                  fileType: "image",
                                                  canSelect: true,
                                                ))));

                                if (chooseFile.isNotEmpty) {
                                  paymentProof = chooseFile.first;
                                  setState(() {});
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              child: MyWidget().myContainer(
                                width: DeviceInfo(context).getWidth(),
                                height: 36,
                                borderRadius: 6.0,
                                borderColor: MyTheme.light_grey,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 14.0),
                                      child: Text(
                                        getLocal(context).choose_file,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: MyTheme.grey_153),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 46,
                                      width: 80,
                                      color: MyTheme.light_grey,
                                      child: Text(
                                        getLocal(context).browse_ucf,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: MyTheme.grey_153),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (paymentProof != null)
                              Stack(
                                fit: StackFit.passthrough,
                                clipBehavior: Clip.antiAlias,
                                alignment: Alignment.bottomCenter,
                                children: [
                                  const SizedBox(
                                    height: 60,
                                    width: 70,
                                  ),
                                  MyWidget.imageWithPlaceholder(
                                      border: Border.all(
                                          width: 0.5,
                                          color: MyTheme.light_grey),
                                      radius: BorderRadius.circular(5),
                                      height: 50.0,
                                      width: 50.0,
                                      url: paymentProof!.url),
                                  Positioned(
                                    top: 3,
                                    right: 2,
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: MyTheme.light_grey),
                                      child: InkWell(
                                        onTap: () {
                                          paymentProof = null;
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 12,
                                          color: MyTheme.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            itemSpacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PosBtn(
                                  text: getLocal(context).close_ucf,
                                  color: MyTheme.app_accent_color,
                                  textColor: MyTheme.white,
                                  fontWeight: FontWeight.bold,
                                  onTap: () => Navigator.pop(context),
                                ),
                                itemSpacer(width: 10.0),
                                PosBtn(
                                  onTap: () {
                                    ///Offline Make
                                    if (paymentProof != null &&
                                        _paymentMethodController
                                            .text.isNotEmpty &&
                                        _amountController.text.isNotEmpty &&
                                        _transactionController
                                            .text.isNotEmpty) {
                                      onSubmitPOS("offline_payment");
                                    }
                                  },
                                  text: getLocal(context).confirm_ucf,
                                  color: MyTheme.app_accent_color,
                                  textColor: MyTheme.white,
                                  fontWeight: FontWeight.bold,
                                )
                              ],
                            ),
                          ],
                        ),
                        isMandatory: false,
                      ),
                    ],
                  ),
                );
              },
            ));
      },
    );
  }

  setShippingAddress() {
    return OneContext().showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(10.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getLocal(context).shipping_address_ucf,
                style: const TextStyle(
                    fontSize: 16, color: MyTheme.app_accent_color),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  'assets/icon/cross.png',
                  width: 16,
                  height: 16,
                ),
              )
            ],
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //List of address section
                    (selectedCustomer?.key?.isNotEmpty ?? false)
                        ? Container(
                            padding: const EdgeInsets.all(5.0),
                            width: DeviceInfo(context).getWidth(),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              children: List.generate(
                                  shippingAddress.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          _selected_shipping_address = index;
                                          tmpShippingAddress =
                                              PosShippingAddressList(
                                            id: shippingAddress[index].id,
                                            userId: selectedCustomer != null
                                                ? int.parse(
                                                    selectedCustomer?.key ??
                                                        "0")
                                                : null,
                                            name: selectedCustomer?.value,
                                            address:
                                                shippingAddress[index].address,
                                            countryName: shippingAddress[index]
                                                .countryName,
                                            stateName: shippingAddress[index]
                                                .stateName,
                                            cityName:
                                                shippingAddress[index].cityName,
                                            postalCode: shippingAddress[index]
                                                .postalCode,
                                            phone: shippingAddress[index].phone,
                                          );
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 8.0),
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border:
                                                _selected_shipping_address ==
                                                        index
                                                    ? Border.all(
                                                        color: MyTheme
                                                            .app_accent_color,
                                                        width: 2.0)
                                                    : Border.all(
                                                        color:
                                                            MyTheme.light_grey,
                                                        width: 1.0),
                                          ),
                                          width: DeviceInfo(context).getWidth(),
                                          child: Column(
                                            children: [
                                              PosCustomerInfoRow(
                                                title: getLocal(context)
                                                    .address_ucf,
                                                content: shippingAddress[index]
                                                    .address,
                                              ),
                                              itemSpacer(height: 3.0),
                                              PosCustomerInfoRow(
                                                title: getLocal(context)
                                                    .postal_code_ucf,
                                                content: shippingAddress[index]
                                                    .postalCode,
                                              ),
                                              itemSpacer(height: 3.0),
                                              PosCustomerInfoRow(
                                                title:
                                                    getLocal(context).city_ucf,
                                                content: shippingAddress[index]
                                                    .cityName,
                                              ),
                                              itemSpacer(height: 3.0),
                                              PosCustomerInfoRow(
                                                title:
                                                    getLocal(context).state_ucf,
                                                content: shippingAddress[index]
                                                    .stateName,
                                              ),
                                              itemSpacer(height: 3.0),
                                              PosCustomerInfoRow(
                                                title: getLocal(context)
                                                    .country_ucf,
                                                content: shippingAddress[index]
                                                    .countryName,
                                              ),
                                              itemSpacer(height: 3.0),
                                              PosCustomerInfoRow(
                                                title: getLocal(context)
                                                    .login_screen_phone,
                                                content: shippingAddress[index]
                                                    .phone,
                                              ),
                                              itemSpacer(height: 3.0),
                                            ],
                                          ),
                                        ),
                                      )),
                            ),
                          )
                        : const SizedBox.shrink(),
                    itemSpacer(),
                    showAddAddressBtn &&
                            (selectedCustomer?.key?.isNotEmpty ?? false)
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                showAddAddressBtn = false;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: DeviceInfo(context).getWidth(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: MyTheme.textfield_grey, width: 1),
                              ),
                              child: Text(
                                getLocal(context).add_new_address,
                                style: TextStyle(
                                    fontSize: 13, color: MyTheme.medium_grey),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: DeviceInfo(context).getWidth(),
                            child:
                                shippingAddressForm(setState, selectedCustomer),
                          ),
                    itemSpacer(height: 20.0),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  shippingAddressForm(setState, selectedCustomer) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (selectedCustomer.key.isEmpty)
          Column(
            children: [
              buildCommonSingleField(
                getLocal(context).name_ucf,
                buildCommonTypeAheadDecoration(
                  child: TextField(
                    controller: _nameController,
                    decoration: buildAddressInputDecoration(
                        context, getLocal(context).name_ucf),
                  ),
                ),
                isMandatory: true,
              ),
              itemSpacer(),
              buildCommonSingleField(
                getLocal(context).email_ucf,
                buildCommonTypeAheadDecoration(
                  child: TextField(
                    controller: _emailController,
                    decoration: buildAddressInputDecoration(
                        context, getLocal(context).email_ucf),
                  ),
                ),
                isMandatory: true,
              ),
              itemSpacer(),
            ],
          ),
        buildCommonSingleField(
          getLocal(context).address_ucf,
          buildCommonTypeAheadDecoration(
            child: TextField(
              controller: _shippingAddressController,
              decoration: buildAddressInputDecoration(
                  context, getLocal(context).address_ucf),
            ),
          ),
          isMandatory: true,
        ),
        itemSpacer(),
        buildCommonSingleField(
          getLocal(context).country_ucf,
          buildCommonTypeAheadDecoration(
              child: TypeAheadField(
            suggestionsCallback: (name) async {
              var countryResponse =
                  await AddressRepository().getCountryList(name: name);
              return countryResponse.countries;
            },
            loadingBuilder: (context) {
              return SizedBox(
                height: 50,
                child: Center(
                    child: Text(getLocal(context).loading_countries_ucf,
                        style: TextStyle(color: MyTheme.medium_grey))),
              );
            },
            itemBuilder: (context, dynamic country) {
              return ListTile(
                dense: true,
                title: Text(
                  country.name,
                  style: TextStyle(color: MyTheme.medium_grey),
                ),
              );
            },
            noItemsFoundBuilder: (context) {
              return SizedBox(
                height: 50,
                child: Center(
                    child: Text(getLocal(context).no_country_available,
                        style: TextStyle(color: MyTheme.medium_grey))),
              );
            },
            onSuggestionSelected: (dynamic country) {
              onSelectCountryDuringAdd(country, setState);
            },
            textFieldConfiguration: TextFieldConfiguration(
              onTap: () {},
              controller: _countryController,
              onSubmitted: (txt) {},
              decoration: buildAddressInputDecoration(
                context,
                getLocal(context).enter_country_ucf,
              ),
            ),
          )),
          isMandatory: true,
        ),
        itemSpacer(),
        buildCommonSingleField(
          getLocal(context).state_ucf,
          buildCommonTypeAheadDecoration(
            child: TypeAheadField(
              suggestionsCallback: (name) async {
                if (_selected_country == null) {
                  var stateResponse = await AddressRepository()
                      .getStateListByCountry(); // blank response
                  return stateResponse.states;
                }
                var stateResponse = await AddressRepository()
                    .getStateListByCountry(
                        country_id: _selected_country!.id, name: name);
                return stateResponse.states;
              },
              loadingBuilder: (context) {
                return SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(getLocal(context).loading_states_ucf,
                          style: TextStyle(color: MyTheme.medium_grey))),
                );
              },
              itemBuilder: (context, dynamic state) {
                return ListTile(
                  dense: true,
                  title: Text(
                    state.name,
                    style: const TextStyle(color: MyTheme.font_grey),
                  ),
                );
              },
              noItemsFoundBuilder: (context) {
                return SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(getLocal(context).no_state_available,
                          style: TextStyle(color: MyTheme.medium_grey))),
                );
              },
              onSuggestionSelected: (dynamic state) {
                onSelectStateDuringAdd(state, setState);
              },
              textFieldConfiguration: TextFieldConfiguration(
                onTap: () {},
                controller: _stateController,
                onSubmitted: (txt) {},
                decoration: buildAddressInputDecoration(
                    context, getLocal(context).enter_state_ucf),
              ),
            ),
          ),
          isMandatory: true,
        ),
        itemSpacer(),
        buildCommonSingleField(
          getLocal(context).city_ucf,
          buildCommonTypeAheadDecoration(
            child: TypeAheadField(
              suggestionsCallback: (name) async {
                if (_selected_state == null) {
                  var cityResponse = await AddressRepository()
                      .getCityListByState(); // blank response
                  return cityResponse.cities;
                }
                var cityResponse = await AddressRepository().getCityListByState(
                    state_id: _selected_state!.id, name: name);
                return cityResponse.cities;
              },
              loadingBuilder: (context) {
                return SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(getLocal(context).loading_cities_ucf,
                          style: TextStyle(color: MyTheme.medium_grey))),
                );
              },
              itemBuilder: (context, dynamic city) {
                //print(suggestion.toString());
                return ListTile(
                  dense: true,
                  title: Text(
                    city.name,
                    style: const TextStyle(color: MyTheme.font_grey),
                  ),
                );
              },
              noItemsFoundBuilder: (context) {
                return SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(getLocal(context).no_city_available,
                          style: TextStyle(color: MyTheme.medium_grey))),
                );
              },
              onSuggestionSelected: (dynamic city) {
                onSelectCityDuringAdd(city, setState);
              },
              textFieldConfiguration: TextFieldConfiguration(
                onTap: () {},
                //autofocus: true,
                controller: _cityController,
                onSubmitted: (txt) {
                  // keep blank
                },
                decoration: buildAddressInputDecoration(
                    context, getLocal(context).enter_city_ucf),
              ),
            ),
          ),
          isMandatory: true,
        ),
        itemSpacer(),
        buildCommonSingleField(
          getLocal(context).postal_code_ucf,
          buildCommonTypeAheadDecoration(
            child: TextField(
              controller: _postalCodeController,
              keyboardType: TextInputType.number,
              decoration: buildAddressInputDecoration(
                  context, getLocal(context).postal_code_ucf),
            ),
          ),
          isMandatory: true,
        ),
        itemSpacer(),
        buildCommonSingleField(
          getLocal(context).phone_ucf,
          buildCommonTypeAheadDecoration(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: buildAddressInputDecoration(
                  context, getLocal(context).phone_ucf),
            ),
          ),
          isMandatory: true,
        ),
        itemSpacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (selectedCustomer?.key?.isNotEmpty ?? false)
              PosBtn(
                  text: getLocal(context).back_ucf,
                  textColor: MyTheme.black,
                  onTap: () {
                    showAddAddressBtn = true;
                    setState(() {});
                  }),
            itemSpacer(width: 10.0),
            selectedCustomer.key.isNotEmpty
                ? PosBtn(
                    text: getLocal(context).save_ucf,
                    color: MyTheme.app_accent_color,
                    textColor: MyTheme.white,
                    fontWeight: FontWeight.bold,
                    onTap: () {
                      if (selectedCustomer != null) {
                        submitCreateShippingAddress(setState, context);
                      }
                    })
                : PosBtn(
                    text: getLocal(context).confirm_ucf,
                    color: MyTheme.app_accent_color,
                    textColor: MyTheme.white,
                    fontWeight: FontWeight.bold,
                    onTap: () {
                      submitCreateShippingAddress(setState, context);
                    }),
          ],
        )
      ],
    );
  }

  buildCommonSingleField(title, Widget child, {isMandatory = false}) {
    return Column(
      children: [
        Row(
          children: [
            buildFieldTitle(title),
            if (isMandatory)
              Text(
                " *",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.red),
              ),
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        child,
      ],
    );
  }

  buildCommonTypeAheadDecoration({Widget? child}) {
    return Card(
      elevation: 5,
      child: Container(
        height: 36,
        width: DeviceInfo(context).getWidth(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: MyTheme.white,
              offset: const Offset(0, 6),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  Text buildFieldTitle(title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: MyTheme.font_grey),
    );
  }

  InputDecoration buildAddressInputDecoration(BuildContext context, hintText) {
    return InputDecoration(
        fillColor: MyTheme.white,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12.0, color: MyTheme.grey_153),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme.noColor, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: MyTheme.app_accent_color.withOpacity(0.5), width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 16.0));
  }

  Widget buildCheckContainer(bool check) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: check ? 1 : 0,
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), color: Colors.green),
        child: const Padding(
          padding: EdgeInsets.all(3),
          child: Icon(Icons.check, color: Colors.white, size: 10),
        ),
      ),
    );
  }
}
