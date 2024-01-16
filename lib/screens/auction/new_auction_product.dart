import 'dart:async';
import 'dart:convert';

import 'package:active_ecommerce_seller_app/const/app_style.dart';
import 'package:active_ecommerce_seller_app/const/dropdown_models.dart';
import 'package:active_ecommerce_seller_app/custom/aiz_summer_note.dart';
import 'package:active_ecommerce_seller_app/custom/buttons.dart';
import 'package:active_ecommerce_seller_app/custom/common_style.dart';
import 'package:active_ecommerce_seller_app/custom/date_and_time_picker.dart';
import 'package:active_ecommerce_seller_app/custom/decorations.dart';
import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/custom/input_decorations.dart';
import 'package:active_ecommerce_seller_app/custom/loading.dart';
import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:active_ecommerce_seller_app/custom/multi_category_section.dart';
import 'package:active_ecommerce_seller_app/custom/my_widget.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/data_model/product/attribut_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/category_view_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/custom_radio_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/vat_tax_model.dart';
import 'package:active_ecommerce_seller_app/data_model/uploaded_file_list_response.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/product_repository.dart';
import 'package:active_ecommerce_seller_app/screens/uploads/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:one_context/one_context.dart';
import 'package:toast/toast.dart';

import '../../data_model/product/category_response_model.dart';

class NewAuctionProduct extends StatefulWidget {
  const NewAuctionProduct({Key? key}) : super(key: key);

  @override
  State<NewAuctionProduct> createState() => _NewAuctionProductState();
}

class _NewAuctionProductState extends State<NewAuctionProduct> {
  // double variables

  String _statAndEndTime = "Select Date";

  double mHeight = 0.0, mWidht = 0.0;
  int _selectedTabIndex = 0;
  bool isCashOnDelivery = false;

  // bool isProductQuantityMultiply = false;

  bool isCategoryInit = false;
  List<CategoryModel> categories = [];
  List<CommonDropDownItem> brands = [];
  List<VatTaxViewModel> vatTaxList = [];
  List<CommonDropDownItem> videoType = [];
  List<CommonDropDownItem> addToFlashType = [];
  List<CommonDropDownItem> discountTypeList = [];

  List<CustomRadioModel> shippingConfigurationList = [];
  List<CustomRadioModel> stockVisibilityStateList = [];
  late CustomRadioModel selectedShippingConfiguration;
  late CustomRadioModel selectedstockVisibilityState;

  CommonDropDownItem? selectedBrand;

  CommonDropDownItem? selectedVideoType;
  CommonDropDownItem? selectedAddToFlashType;
  CommonDropDownItem? selectedFlashDiscountType;
  late CommonDropDownItem selectedProductDiscountType;
  CommonDropDownItem? selectedColor;
  AttributesModel? selectedAttribute;

  //Product value
  List categoryIds = [];
  String? productName,
      categoryId,
      brandId,
      unit,
      weight,
      minQuantity,
      barcode,
      photos,
      startingBid,
      thumbnailImg,
      videoProvider,
      earnPoint,
      videoLink,
      colorsActive,
      unitPrice,
      dateRange,
      discount,
      discountType,
      currentStock,
      sku,
      externalLink,
      externalLinkBtn,
      description,
      pdf,
      metaTitle,
      metaDescription,
      metaImg,
      shippingType,
      flatShippingCost,
      lowStockQuantity,
      stockVisibilityState,
      cashOnDelivery,
      estShippingDays,
      button;
  var tagMap = [];
  List<String?>? tags = [],
      colors,
      choiceAttributes,
      choiceNo,
      choice,
      choiceOptions2,
      choiceOptions1,
      taxId,
      tax,
      taxType;

  Map choice_options = Map();

  ImagePicker pickImage = ImagePicker();

  List<FileInfo> productGalleryImages = [];
  FileInfo? thumbnailImage;
  FileInfo? metaImage;
  FileInfo? pdfDes;

  // DateTime? endDateTime = DateTime.now();
  //
  // DateTimeRange dateTimeRange =
  //     DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateTime? startDate, endDate;

  //Edit text controller
  TextEditingController productNameEditTextController = TextEditingController();
  TextEditingController startingBindingPriceTextController =
      TextEditingController();
  TextEditingController weightEditTextController =
      TextEditingController(text: "0.0");
  TextEditingController minimumEditTextController =
      TextEditingController(text: "1");
  TextEditingController tagEditTextController = TextEditingController();
  TextEditingController taxEditTextController = TextEditingController();
  TextEditingController videoLinkEditTextController = TextEditingController();
  TextEditingController metaTitleEditTextController = TextEditingController();
  TextEditingController metaDescriptionEditTextController =
      TextEditingController();
  TextEditingController shippingDayEditTextController = TextEditingController();
  TextEditingController productDiscountEditTextController =
      TextEditingController(text: "0");
  TextEditingController flashDiscountEditTextController =
      TextEditingController();
  TextEditingController unitPriceEditTextController =
      TextEditingController(text: "0");
  TextEditingController productQuantityEditTextController =
      TextEditingController(text: "0");
  TextEditingController externalLinkEditTextController =
      TextEditingController();
  TextEditingController externalLinkButtonTextEditTextController =
      TextEditingController();
  TextEditingController flatShippingCostTextEditTextController =
      TextEditingController();

  List<TextEditingController> minQTYTextEditTextController = [
    TextEditingController(text: "0")
  ];
  List<TextEditingController> maxQTYTextEditTextController = [
    TextEditingController(text: "0")
  ];
  List<TextEditingController> priceTextEditTextController = [
    TextEditingController(text: "0")
  ];

  GlobalKey<FlutterSummernoteState> productDescriptionKey =
      GlobalKey<FlutterSummernoteState>();

  getCategories() async {
    var categoryResponse = await ProductRepository().getCategoryRes();
    categoryResponse.data!.forEach((element) {
      CategoryModel model = CategoryModel(
          id: element.id.toString(),
          title: element.name,
          isExpanded: false,
          isSelected: false,
          height: 0.0,
          children: setChildCategory(element.child!));
      categories.add(model);
    });
    isCategoryInit = true;
    setState(() {});
  }

  List<CategoryModel> setChildCategory(List<Category> child) {
    List<CategoryModel> list = [];
    child.forEach((element) {
      var children = element.child ?? [];
      CategoryModel model = CategoryModel(
          id: element.id.toString(),
          title: element.name,
          height: 0.0,
          children: children.isNotEmpty ? setChildCategory(children) : []);

      list.add(model);
    });
    return list;
  }

  getBrands() async {
    var brandsRes = await ProductRepository().getBrandRes();
    for (var element in brandsRes.data!) {
      brands.addAll([
        CommonDropDownItem("${element.id}", element.name),
      ]);
    }
    setState(() {});
  }

  setConstDropdownValues() {
    videoType.addAll([
      CommonDropDownItem("youtube",
          LangText(context: OneContext().context).getLocal().youtube_ucf),
      CommonDropDownItem("dailymotion",
          LangText(context: OneContext().context).getLocal().dailymotion_ucf),
      CommonDropDownItem("vimeo",
          LangText(context: OneContext().context).getLocal().vimeo_ucf),
    ]);
    selectedVideoType = videoType.first;

    addToFlashType.addAll([
      CommonDropDownItem("key1", "value1"),
      CommonDropDownItem("key2", "value2"),
      CommonDropDownItem("key3", "value3"),
    ]);
    discountTypeList.addAll([
      CommonDropDownItem("amount",
          LangText(context: OneContext().context).getLocal().flat_ucf),
      CommonDropDownItem("percent",
          LangText(context: OneContext().context).getLocal().percent_ucf),
    ]);
    selectedProductDiscountType = discountTypeList.first;
    selectedFlashDiscountType = discountTypeList.first;

    shippingConfigurationList.addAll([
      CustomRadioModel(
          LangText(context: OneContext().context).getLocal().free_shipping_ucf,
          "free",
          true),
      CustomRadioModel(
          LangText(context: OneContext().context).getLocal().flat_rate_ucf,
          "flat_rate",
          false),
    ]);
    stockVisibilityStateList.addAll([
      CustomRadioModel(
          LangText(context: OneContext().context).getLocal().show_stock_qty_ucf,
          "quantity",
          true),
      CustomRadioModel(
          LangText(context: OneContext().context)
              .getLocal()
              .show_stock_with_text_only_ucf,
          "text",
          false),
      CustomRadioModel(
          LangText(context: OneContext().context).getLocal().hide_stock_ucf,
          "hide",
          false)
    ]);

    selectedShippingConfiguration = shippingConfigurationList.first;
    selectedstockVisibilityState = stockVisibilityStateList.first;

    setState(() {});
  }

  getTaxType() async {
    var taxRes = await ProductRepository().getTaxRes();

    taxRes.data!.forEach((element) {
      vatTaxList.add(
          VatTaxViewModel(VatTaxModel("${element.id}", "${element.name}"), [
        CommonDropDownItem("amount",
            LangText(context: OneContext().context).getLocal().flat_ucf),
        CommonDropDownItem("percent",
            LangText(context: OneContext().context).getLocal().percent_ucf),
      ]));
    });
  }

  fetchAll() {
    getCategories();
    getBrands();
    getTaxType();
    setConstDropdownValues();
  }

  pickGalleryImages() async {
    var tmp = productGalleryImages;
    List<FileInfo>? images = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UploadFile(
                  fileType: "image",
                  canSelect: true,
                  canMultiSelect: true,
                  prevData: tmp,
                )));
    // print(images != null);
    if (images != null) {
      productGalleryImages = images;
      setChange();
    }
  }

  Future<XFile?> pickSingleImage() async {
    return await pickImage.pickImage(source: ImageSource.gallery);
  }

  setProductPhotoValue() {
    photos = "";
    for (int i = 0; i < productGalleryImages.length; i++) {
      if (i != (productGalleryImages.length - 1)) {
        photos = "$photos " + "${productGalleryImages[i].id},";
      } else {
        photos = "$photos " + "${productGalleryImages[i].id}";
      }
    }
  }

  setTaxes() {
    taxType = [];
    tax = [];
    taxId = [];
    for (var element in vatTaxList) {
      taxId!.add(element.vatTaxModel.id);
      tax!.add(element.amount.text.trim().toString());
      if (element.selectedItem != null) taxType!.add(element.selectedItem!.key);
    }
  }

  setProductValues() async {
    productName = productNameEditTextController.text.trim();

    if (selectedBrand != null) brandId = selectedBrand!.key;

    unit = unitPriceEditTextController.text.trim();
    startingBid = startingBindingPriceTextController.text.trim();
    weight = weightEditTextController.text.trim();
    minQuantity = minimumEditTextController.text.trim();
    tagMap.clear();
    for (var element in tags!) {
      tagMap.add(jsonEncode({"value": '$element'}));
    }
    // add product photo
    setProductPhotoValue();
    if (thumbnailImage != null) thumbnailImg = "${thumbnailImage!.id}";
    videoProvider = selectedVideoType!.key;
    videoLink = videoLinkEditTextController.text.trim().toString();
    //Set colors
    unitPrice = unitPriceEditTextController.text.trim().toString();

    ///need implement
    // dateRange =
    //     "${DateFormat("y-MM-d HH:mm:ss").format(dateTimeRange.start)} to ${DateFormat("y-MM-d HH:mm:ss").format(dateTimeRange.end)}";
    discount = productDiscountEditTextController.text.trim().toString();
    discountType = selectedProductDiscountType.key;
    currentStock = productQuantityEditTextController.text.trim().toString();
    externalLink = externalLinkEditTextController.text.trim().toString();
    externalLinkBtn =
        externalLinkButtonTextEditTextController.text.trim().toString();

    if (productDescriptionKey.currentState != null) {
      description = await productDescriptionKey.currentState!.getText() ?? "";
      description = await productDescriptionKey.currentState!.getText() ?? "";
    }

    if (pdfDes != null) pdf = "${pdfDes!.id}";
    metaTitle = metaTitleEditTextController.text.trim().toString();
    metaDescription = metaDescriptionEditTextController.text.trim().toString();
    if (metaImage != null) metaImg = "${metaImage!.id}";
    shippingType = selectedShippingConfiguration.key;
    flatShippingCost =
        flatShippingCostTextEditTextController.text.trim().toString();
    stockVisibilityState = selectedstockVisibilityState.key;
    cashOnDelivery = isCashOnDelivery ? "1" : "0";
    estShippingDays = shippingDayEditTextController.text.trim().toString();
    // get taxes
    setTaxes();
  }

  bool requiredFieldVerification() {
    if (productNameEditTextController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal().product_name_required_ucf,
          gravity: Toast.center);
      return false;
    } else if (unitPriceEditTextController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal().product_unit_required_ucf,
          gravity: Toast.center);
      return false;
    } else if (startingBindingPriceTextController.text
        .trim()
        .toString()
        .isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context)
              .getLocal()
              .starting_binding_price_required_ucf,
          gravity: Toast.center);
      return false;
    }
    return true;
  }

  List getMinQtys() {
    List qtys = [];
    for (var element in minQTYTextEditTextController) {
      qtys.add(element.text.trim());
    }

    return qtys;
  }

  List getMaxQtys() {
    List qtys = [];
    maxQTYTextEditTextController.forEach((element) {
      qtys.add(element.text.trim());
    });

    return qtys;
  }

  List getPrices() {
    List prices = [];
    priceTextEditTextController.forEach((element) {
      prices.add(element.text.trim());
    });

    return prices;
  }

  submitProduct() async {
    if (!requiredFieldVerification()) {
      return;
    }

    Loading().show();

    await setProductValues();

    Map postValue = {};
    postValue.addAll({
      "added_by": "seller",
      "name": productName,
      "category_id": categoryId,
      "category_ids": categoryIds,
      "brand_id": brandId,
      "unit": unit,
      "weight": weight,
      "tags": [tagMap.toString()],
      "photos": photos,
      "thumbnail_img": thumbnailImg,
      "video_provider": videoProvider,
      "video_link": videoLink,
      "starting_bid": startingBid,
      "auction_date_range":
          "${formatDateTime(startDate!)} to ${formatDateTime(endDate!)}"
    });

    // postValue.addAll({
    //   "unit_price": unitPrice,
    //   "earn_point": earnPoint,
    //   "current_stock": currentStock,
    //   "sku": sku,
    // });
    //postValue.addAll(makeVariationMap());

    if (shipping_type.$) {
      postValue.addAll({
        "shipping_type": shippingType,
        "flat_shipping_cost": flatShippingCost
      });
    }

    postValue.addAll({
      "description": description,
      "pdf": pdf,
      "meta_title": metaTitle,
      "meta_description": metaDescription,
      "meta_img": metaImg,
      "cash_on_delivery": cashOnDelivery,
      "est_shipping_days": estShippingDays,
      "tax_id": taxId,
      "tax": tax,
      "tax_type": taxType,
    });

    var postBody = jsonEncode(postValue);

    var response =
        await ProductRepository().addAuctionProductResponse(postBody);

    Loading().hide();
    if (response.result != null && response.result!) {
      ToastComponent.showDialog(response.message, gravity: Toast.center);

      Navigator.pop(context);
    } else {
      dynamic errorMessages = response.message;
      if (errorMessages.runtimeType == String) {
        ToastComponent.showDialog(errorMessages, gravity: Toast.center);
      } else {
        ToastComponent.showDialog(errorMessages.join(","),
            gravity: Toast.center);
      }
    }
  }

/*
  Map makeVariationMap() {
    Map variation = Map();
    productVariations.forEach((element) {
      variation.addAll({
        "price_" + element.name.replaceAll(" ", "-"):
            element.priceEditTextController.text.trim().toString() ?? null,
        "sku_" + element.name.replaceAll(" ", "-"):
            element.skuEditTextController.text.trim().toString() ?? null,
        "qty_" + element.name.replaceAll(" ", "-"):
            element.quantityEditTextController.text.trim().toString() ?? null,
        "img_" + element.name.replaceAll(" ", "-"):
            element.photo == null ? null : element.photo.id,
      });
    });
    return variation;
  }
*/
  @override
  void initState() {
    fetchAll();
    startDate = DateTime.now();
    endDate = DateTime.now();
    // dateRange =
    //     "${DateFormat("y-MM-d HH:mm:ss").format(dateTimeRange.start)} to ${DateFormat("y-MM-d HH:mm:ss").format(dateTimeRange.end)}";
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productDescriptionKey.currentState!.deactivate();
    productDescriptionKey.currentState!.dispose();

    super.dispose();
  }

  String? dateR;

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidht = MediaQuery.of(context).size.width;
    Loading.setInstance(context);
    return Scaffold(
      appBar: buildAppBar(context) as PreferredSizeWidget?,
      body: SingleChildScrollView(child: buildBodyContainer()),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }

  Widget buildBodyContainer() {
    return changeMainContent(_selectedTabIndex);
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: MyTheme.app_accent_color,
            width: mWidht,
            child: Buttons(
              onPressed: () async {
                submitProduct();
              },
              child: Text(
                LangText(context: context).getLocal().save_ucf,
                style: TextStyle(color: MyTheme.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  changeMainContent(int index) {
    switch (index) {
      case 0:
        return buildGeneral();
        break;
      case 1:
        return buildMedia();
        break;
      case 2:
        return buildProductPriceAndDateRange();
        break;
      case 3:
        return buildSEO();
        break;
      case 4:
        return buildShipping();
        break;
      default:
        return Container();
    }
  }

  Widget buildGeneral() {
    return buildTabViewItem(
      LangText(context: context).getLocal().product_information_ucf,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildEditTextField(
            LangText(context: context).getLocal().product_name_ucf,
            LangText(context: context).getLocal().product_name_ucf,
            productNameEditTextController,
            isMandatory: true,
          ),
          itemSpacer(),
          _buildMultiCategory(
              LangText(context: context).getLocal()!.categories_ucf,
              isMandatory: true),
          itemSpacer(),
          _buildDropDownField(LangText(context: context).getLocal().brands_ucf,
              (value) {
            selectedBrand = value;
            setChange();
          }, selectedBrand, brands),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context).getLocal().unit_ucf,
              LangText(context: context).getLocal().unit_eg_ucf,
              unitPriceEditTextController,
              isMandatory: true),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context).getLocal().weight_in_kg_ucf,
              "0.0",
              weightEditTextController),
          itemSpacer(),
          buildTagsEditTextField(
              LangText(context: context).getLocal().tags_ucf,
              LangText(context: context)
                  .getLocal()
                  .type_and_hit_enter_to_add_a_tag_ucf,
              tagEditTextController,
              isMandatory: true),
          itemSpacer(),
          buildGroupItems(
              LangText(context: context).getLocal().product_description_ucf,
              summerNote(LangText(context: context)
                  .getLocal()
                  .product_description_ucf)),
          itemSpacer(),
          buildSwitchField(
            LangText(context: context).getLocal().cash_on_delivery_ucf,
            isCashOnDelivery,
            (onChanged) {
              isCashOnDelivery = onChanged;
              setChange();
            },
          ),
          itemSpacer(),
          buildGroupItems(
            LangText(context: context).getLocal().vat_n_tax_ucf,
            Column(
              children: List.generate(vatTaxList.length, (index) {
                return buildVatTax(vatTaxList[index].vatTaxModel.name,
                    vatTaxList[index].amount, (onChangeDropDown) {
                  vatTaxList[index].selectedItem = onChangeDropDown;
                }, vatTaxList[index].selectedItem, vatTaxList[index].items);
              }),
            ),
          ),
          itemSpacer(),
        ],
      ),
    );
  }

  Widget buildVatTax(title, TextEditingController controller, onChangeDropDown,
      CommonDropDownItem? selectedDropdown, List<CommonDropDownItem> iteams) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          SizedBox(
            width: (mWidht / 2) - 25,
            child: buildEditTextField(title, "0", controller),
          ),
          const Spacer(),
          _buildDropDownField("", (newValue) {
            onChangeDropDown(newValue);
            setChange();
          }, selectedDropdown, iteams, width: (mWidht / 2) - 25),
        ],
      ),
    );
  }

  Widget buildMedia() {
    return buildTabViewItem(
      LangText(context: context).getLocal().product_images_ucf,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chooseGalleryImageField(),
          itemSpacer(),
          chooseSingleImageField(
              LangText(context: context).getLocal().thumbnail_image_300_ucf,
              LangText(context: context).getLocal().thumbnail_image_300_des,
              (onChosenImage) {
            thumbnailImage = onChosenImage;
            setChange();
          }, thumbnailImage),
          itemSpacer(),
          buildGroupItems(
              LangText(context: context).getLocal().product_videos_ucf,
              _buildDropDownField(
                  LangText(context: context).getLocal().video_provider_ucf,
                  (newValue) {
                selectedVideoType = newValue;
                setChange();
              }, selectedVideoType, videoType)),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context).getLocal().video_link_ucf,
              LangText(context: context).getLocal().video_link_ucf,
              videoLinkEditTextController),
          itemSpacer(height: 10),
          smallTextForMessage(
              LangText(context: context).getLocal().video_link_des),
          itemSpacer(),
          buildGroupItems(
              LangText(context: context).getLocal().pdf_description_ucf,
              chooseSingleFileField(
                  LangText(context: context).getLocal().pdf_specification_ucf,
                  "", (onChosenFile) {
                pdfDes = onChosenFile;
                setChange();
              }, pdfDes)),
          itemSpacer()
        ],
      ),
    );
  }

  Widget buildProductPriceAndDateRange() {
    return buildTabViewItem(
      LangText(context: context).getLocal().auction_biding_price_date_range_ucf,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildEditTextField(
            LangText(context: context)
                .getLocal()
                .auction_starting_bid_price_ucf,
            LangText(context: context)
                .getLocal()
                .auction_starting_bid_price_ucf,
            startingBindingPriceTextController,
            isMandatory: true,
          ),
          itemSpacer(),
          Container(
            child: buildCommonSingleField(
              LangText(context: context).getLocal().auction_date_range_ucf,
              MyWidget.customCardView(
                backgroundColor: MyTheme.white,
                elevation: 5,
                width: DeviceInfo(context).getWidth(),
                height: 46,
                borderRadius: 10,
                child: TextButton(
                  onPressed: _buildDateAndTimeRange,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: startDate != null && endDate != null
                        ? Text(
                            "${formatDateTime(startDate!)} To ${formatDateTime(endDate!)}",
                            style: const TextStyle(
                                color: MyTheme.grey_153, fontSize: 12.0),
                          )
                        : const Text(
                            "",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.0),
                          ),
                  ),
                ),
              ),
            ),
          ),
          itemSpacer(),
        ],
      ),
    );
  }

  Widget buildSEO() {
    return buildTabViewItem(
      LangText(context: context).getLocal().seo_all_capital,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildEditTextField(
            LangText(context: context).getLocal().meta_title_ucf,
            LangText(context: context).getLocal().meta_title_ucf,
            metaTitleEditTextController,
            isMandatory: false,
          ),
          itemSpacer(),
          buildGroupItems(
            LangText(context: context).getLocal().description_ucf,
            Container(
                padding: const EdgeInsets.all(8),
                height: 150,
                width: mWidht,
                decoration: MDecoration.decoration1(),
                child: TextField(
                    controller: metaDescriptionEditTextController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 50,
                    enabled: true,
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration.collapsed(
                        hintText: LangText(context: context)
                            .getLocal()
                            .description_ucf))),
          ),
          itemSpacer(),
          chooseSingleImageField(
              LangText(context: context).getLocal().meta_image_ucf, "",
              (onChosenImage) {
            metaImage = onChosenImage;
            setChange();
          }, metaImage),
          itemSpacer()
        ],
      ),
    );
  }

  Widget buildShipping() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: AppStyles.itemMargin,
            right: AppStyles.itemMargin,
            top: AppStyles.itemMargin,
          ),
          child: Container(
            width: DeviceInfo(context).getWidth(),
            padding: EdgeInsets.all(AppStyles.itemMargin),
            decoration: MDecoration.decoration1(),
            child: buildGroupItems(
                LangText(context: context)
                    .getLocal()
                    .shipping_configuration_ucf,
                shipping_type.$
                    ? Column(
                        children: [
                          Column(
                            children: List.generate(
                              shippingConfigurationList.length,
                              (index) => buildSwitchField(
                                shippingConfigurationList[index].title,
                                shippingConfigurationList[index].isActive,
                                (changedValue) {
                                  shippingConfigurationList.forEach((element) {
                                    if (element.key ==
                                        shippingConfigurationList[index].key) {
                                      shippingConfigurationList[index]
                                          .isActive = true;
                                    } else {
                                      element.isActive = false;
                                    }
                                  });
                                  selectedShippingConfiguration =
                                      shippingConfigurationList[index];
                                  setChange();
                                  print(selectedShippingConfiguration.key);
                                },
                              ),
                            ),
                          ),
                          if (selectedShippingConfiguration.key == "flat_rate")
                            Row(
                              children: [
                                Text(LangText(context: context)
                                    .getLocal()
                                    .shipping_cost_ucf),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: MyTheme.white),
                                  width: (mWidht * 0.5),
                                  height: 46,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller:
                                        flatShippingCostTextEditTextController,
                                    decoration:
                                        InputDecorations.buildInputDecoration_1(
                                            fillColor: MyTheme.noColor,
                                            hint_text: "0",
                                            borderColor: MyTheme.light_grey,
                                            hintTextColor: MyTheme.grey_153),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            )
                        ],
                      )
                    : Text(
                        LangText(context: context)
                            .getLocal()
                            .shipping_configuration_is_maintained_by_admin,
                        style: MyTextStyle.normalStyle(),
                      )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: AppStyles.itemMargin,
            right: AppStyles.itemMargin,
            top: AppStyles.itemMargin,
          ),
          child: Container(
            padding: EdgeInsets.all(AppStyles.itemMargin),
            decoration: MDecoration.decoration1(),
            child: buildGroupItems(
              LangText(context: context).getLocal().estimate_shipping_time_ucf,
              buildGroupItems(
                LangText(context: context).getLocal().shipping_days_ucf,
                MyWidget().myContainer(
                  width: DeviceInfo(context).getWidth(),
                  height: 46,
                  borderRadius: 6.0,
                  borderColor: MyTheme.light_grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: mWidht / 2,
                        padding: const EdgeInsets.only(left: 14.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          controller: shippingDayEditTextController,
                          style: const TextStyle(
                              fontSize: 12, color: MyTheme.font_grey),
                          decoration:
                              const InputDecoration.collapsed(hintText: "0"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 46,
                        width: 80,
                        color: MyTheme.light_grey,
                        child: Text(
                          LangText(context: context).getLocal().days_ucf,
                          style:
                              TextStyle(fontSize: 12, color: MyTheme.grey_153),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildTabViewItem(String title, Widget children) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppStyles.itemMargin,
        right: AppStyles.itemMargin,
        top: AppStyles.itemMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.font_grey),
            ),
          const SizedBox(
            height: 16,
          ),
          children,
        ],
      ),
    );
  }

  Widget buildAttributeModelView(
      index,
      attributeName,
      List<CommonDropDownItem> attributesValues,
      selectedValue,
      dynamic onchange,
      dynamic remove) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: mWidht * 0.15, child: buildFieldTitle(attributeName)),
            Container(
              width: mWidht * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: MDecoration.decoration1(),
              child: DropdownButton<CommonDropDownItem>(
                isDense: true,
                underline: Container(),
                isExpanded: true,
                onChanged: (CommonDropDownItem? value) {
                  onchange(value);
                },
                icon: const Icon(Icons.arrow_drop_down),
                value: selectedValue,
                items: attributesValues
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
            SizedBox(
              width: mWidht * 0.10,
              child: IconButton(
                  onPressed: () {
                    remove(index);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: MyTheme.red,
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildGroupItems(groupTitle, Widget children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildGroupTitle(groupTitle),
        itemSpacer(height: 14.0),
        children,
      ],
    );
  }

  Text buildGroupTitle(title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.font_grey),
    );
  }

  Text buildTitle14(title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, color: MyTheme.font_grey),
    );
  }

  Widget chooseGalleryImageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LangText(context: context).getLocal().gallery_images_600,
              style: const TextStyle(
                  fontSize: 12,
                  color: MyTheme.font_grey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Buttons(
              padding: EdgeInsets.zero,
              onPressed: () {
                pickGalleryImages();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: MyWidget().myContainer(
                  width: DeviceInfo(context).getWidth(),
                  height: 46,
                  borderRadius: 6.0,
                  borderColor: MyTheme.light_grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          LangText(context: context).getLocal().choose_file,
                          style:
                              TextStyle(fontSize: 12, color: MyTheme.grey_153),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          height: 46,
                          width: 80,
                          color: MyTheme.light_grey,
                          child: Text(
                            LangText(context: context).getLocal().browse_ucf,
                            style: TextStyle(
                                fontSize: 12, color: MyTheme.grey_153),
                          )),
                    ],
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          LangText(context: context)
              .getLocal()
              .these_images_are_visible_in_product_details_page_gallery_600,
          style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
        ),
        const SizedBox(
          height: 10,
        ),
        if (productGalleryImages.isNotEmpty)
          Wrap(
            children: List.generate(
              productGalleryImages.length,
              (index) => Stack(
                children: [
                  MyWidget.imageWithPlaceholder(
                      height: 60.0,
                      width: 60.0,
                      url: productGalleryImages[index].url),
                  Positioned(
                    top: 0,
                    right: 5,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: MyTheme.white),
                      child: InkWell(
                        onTap: () {
                          productGalleryImages.removeAt(index);
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
            ),
          ),
      ],
    );
  }

  Widget chooseSingleImageField(String title, String shortMessage,
      dynamic onChosenImage, FileInfo? selectedFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 12,
                  color: MyTheme.font_grey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            imageField(shortMessage, onChosenImage, selectedFile)
          ],
        ),
      ],
    );
  }

  Widget chooseSingleFileField(String title, String shortMessage,
      dynamic onChosenFile, FileInfo? selectedFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 12,
                  color: MyTheme.font_grey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            fileField("document", shortMessage, onChosenFile, selectedFile)
          ],
        ),
      ],
    );
  }

  Widget buildShowSelectedOptions(
      List<CommonDropDownItem> options, dynamic remove) {
    return SizedBox(
      width: DeviceInfo(context).getWidth() - 34,
      child: Wrap(
        children: List.generate(
            options.length,
            (index) => Container(
                decoration: BoxDecoration(
                    color: MyTheme.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: MyTheme.grey_153)),
                constraints: BoxConstraints(
                    maxWidth: (DeviceInfo(context).getWidth() - 50) / 4),
                margin: const EdgeInsets.only(right: 5, bottom: 5),
                child: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 20, top: 5, bottom: 5),
                        constraints: BoxConstraints(
                            maxWidth:
                                (DeviceInfo(context).getWidth() - 50) / 4),
                        child: Text(
                          options[index].value.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        )),
                    Positioned(
                      right: 2,
                      child: InkWell(
                        onTap: () {
                          remove(index);
                        },
                        child: Icon(Icons.highlight_remove,
                            size: 15, color: MyTheme.red),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }

  Widget imageField(
      String shortMessage, dynamic onChosenImage, FileInfo? selectedFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Buttons(
          padding: EdgeInsets.zero,
          onPressed: () async {
            // XFile chooseFile = await pickSingleImage();
            List<FileInfo> chooseFile = await (Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UploadFile(
                  fileType: "image",
                  canSelect: true,
                ),
              ),
            ));
            if (chooseFile.isNotEmpty) {
              onChosenImage(chooseFile.first);
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: MyWidget().myContainer(
            width: DeviceInfo(context).getWidth(),
            height: 46,
            borderRadius: 6.0,
            borderColor: MyTheme.light_grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    LangText(context: context).getLocal().choose_file,
                    style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 46,
                  width: 80,
                  color: MyTheme.light_grey,
                  child: Text(
                    LangText(context: context).getLocal().browse_ucf,
                    style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (shortMessage.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                shortMessage,
                style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        if (selectedFile != null)
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
                  border: Border.all(width: 0.5, color: MyTheme.light_grey),
                  radius: BorderRadius.circular(5),
                  height: 50.0,
                  width: 50.0,
                  url: selectedFile.url),
              Positioned(
                top: 3,
                right: 2,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: MyTheme.light_grey),
                  child: InkWell(
                    onTap: () {
                      onChosenImage(null);
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
      ],
    );
  }

  Widget fileField(String fileType, String shortMessage, dynamic onChosenFile,
      FileInfo? selectedFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Buttons(
          padding: EdgeInsets.zero,
          onPressed: () async {
            // XFile chooseFile = await pickSingleImage();
            List<FileInfo> chooseFile = await (Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UploadFile(
                          fileType: fileType,
                          canSelect: true,
                        ))));
            print(chooseFile.first.url);
            if (chooseFile.isNotEmpty) {
              onChosenFile(chooseFile.first);
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: MyWidget().myContainer(
            width: DeviceInfo(context).getWidth(),
            height: 46,
            borderRadius: 6.0,
            borderColor: MyTheme.light_grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    LangText(context: context).getLocal().choose_file,
                    style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 46,
                  width: 80,
                  color: MyTheme.light_grey,
                  child: Text(
                    LangText(context: OneContext().context)
                        .getLocal()
                        .browse_ucf,
                    style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (shortMessage.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shortMessage,
                style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        if (selectedFile != null)
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                height: 40,
                alignment: Alignment.center,
                width: 40,
                decoration: BoxDecoration(
                  color: MyTheme.grey_153,
                ),
                child: Text(
                  "${selectedFile.fileOriginalName!}.${selectedFile.extension!}",
                  style: TextStyle(fontSize: 9, color: MyTheme.white),
                ),
              ),
              Positioned(
                top: 0,
                right: 5,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: MyTheme.white),
                  // remove the selected file button
                  child: InkWell(
                    onTap: () {
                      onChosenFile(null);
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
      ],
    );
  }

  summerNote(title) {
    if (productDescriptionKey.currentState != null) {
      productDescriptionKey.currentState!.activate();
      productDescriptionKey.currentState!.getText().then((value) {
        description = value;
        print(description);
        if (description != null) {
          // productDescriptionKey.currentState.setText(description);
        }
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: MyTheme.font_grey),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 250,
          width: mWidht,
          child: FlutterSummernote(
              showBottomToolbar: false,
              value: description,
              hint: "jhk",
              key: productDescriptionKey),
        ),
      ],
    );
  }

  Widget smallTextForMessage(String txt) {
    return Text(
      txt,
      style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
    );
  }

  setChange() {
    setState(() {});
  }

  Widget itemSpacer({double height = 24}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _buildDropDownField(String title, dynamic onchange,
      CommonDropDownItem? selectedValue, List<CommonDropDownItem> itemList,
      {bool isMandatory = false, double? width}) {
    return buildCommonSingleField(
        title, _buildDropDown(onchange, selectedValue, itemList, width: width),
        isMandatory: isMandatory);
  }

  Widget _buildMultiCategory(String title,
      {bool isMandatory = false, double? width}) {
    return buildCommonSingleField(
        title,
        Container(
            height: 250,
            width: width ?? mWidht,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: MDecoration.decoration1(),
            child: SingleChildScrollView(
              child: MultiCategory(
                isCategoryInit: isCategoryInit,
                categories: categories,
                onSelectedCategories: (categories) {
                  categoryIds.clear();
                  categoryIds.addAll(categories);
                },
                onSelectedMainCategory: (mainCategory) {
                  categoryId = mainCategory;
                },
                initialCategoryIds: categoryIds,
                initialMainCategory: categoryId,
              ),
            )),
        isMandatory: isMandatory);
  }

  Widget _buildDropDown(dynamic onchange, CommonDropDownItem? selectedValue,
      List<CommonDropDownItem> itemList,
      {double? width}) {
    return Container(
      height: 46,
      width: width ?? mWidht,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: MDecoration.decoration1(),
      child: DropdownButton<CommonDropDownItem>(
        menuMaxHeight: 300,
        isDense: true,
        underline: Container(),
        isExpanded: true,
        onChanged: (CommonDropDownItem? value) {
          onchange(value);
        },
        icon: const Icon(Icons.arrow_drop_down),
        value: selectedValue,
        items: itemList
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
    );
  }

  Widget _buildColorDropDown(dynamic onchange, CommonDropDownItem selectedValue,
      List<CommonDropDownItem> itemList,
      {double? width}) {
    return Container(
      height: 46,
      width: width ?? mWidht,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: MDecoration.decoration1(),
      child: DropdownButton<CommonDropDownItem>(
        menuMaxHeight: 300,
        isDense: true,
        underline: Container(),
        isExpanded: true,
        onChanged: (CommonDropDownItem? value) {
          onchange(value);
        },
        icon: const Icon(Icons.arrow_drop_down),
        value: selectedValue,
        items: itemList
            .map(
              (value) => DropdownMenuItem<CommonDropDownItem>(
                value: value,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Color(
                              int.parse(value.key!.replaceAll("#", "0xFF"))),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    Text(
                      value.value!,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFlatDropDown(String title, dynamic onchange,
      CommonDropDownItem selectedValue, List<CommonDropDownItem> itemList,
      {bool isMandatory = false, double? width}) {
    return buildCommonSingleField(
        title,
        Container(
          height: 46,
          width: width ?? mWidht,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyTheme.app_accent_color_extra_light),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: DropdownButton<CommonDropDownItem>(
            isDense: true,
            underline: Container(),
            isExpanded: true,
            onChanged: (value) {
              onchange(value);
            },
            icon: const Icon(Icons.arrow_drop_down),
            value: selectedValue,
            items: itemList
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
        isMandatory: isMandatory);
  }

  Widget buildEditTextField(
      String title, String hint, TextEditingController textEditingController,
      {isMandatory = false, onTap}) {
    return Container(
      child: buildCommonSingleField(
        title,
        MyWidget.customCardView(
          backgroundColor: MyTheme.white,
          elevation: 5,
          width: DeviceInfo(context).getWidth(),
          height: 46,
          borderRadius: 10,
          child: TextField(
            onTap: onTap,
            controller: textEditingController,
            decoration: InputDecorations.buildInputDecoration_1(
                hint_text: hint,
                borderColor: MyTheme.noColor,
                hintTextColor: MyTheme.grey_153),
          ),
        ),
        isMandatory: isMandatory,
      ),
    );
  }

  editTextField(String hint, TextEditingController textEditingController) {
    return MyWidget.customCardView(
      backgroundColor: MyTheme.white,
      elevation: 5,
      width: DeviceInfo(context).getWidth(),
      height: 46,
      borderRadius: 10,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecorations.buildInputDecoration_1(
            hint_text: hint,
            borderColor: MyTheme.noColor,
            hintTextColor: MyTheme.grey_153),
      ),
    );
  }

  Widget buildTagsEditTextField(
      String title, String hint, TextEditingController textEditingController,
      {isMandatory = false}) {
    //textEditingController.buildTextSpan(context: context, withComposing: true);
    return buildCommonSingleField(
      title,
      Container(
        padding:
            const EdgeInsets.only(top: 14, bottom: 10, left: 14, right: 14),
        alignment: Alignment.centerLeft,
        constraints: BoxConstraints(
          minWidth: DeviceInfo(context).getWidth(),
          minHeight: 46,
        ),
        decoration: MDecoration.decoration1(),
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.start,
          clipBehavior: Clip.antiAlias,
          children: List.generate(
            tags!.length + 1,
            (index) {
              if (index == tags!.length) {
                return TextField(
                  onSubmitted: (string) {
                    var tag = textEditingController.text
                        .trim()
                        .replaceAll(",", "")
                        .toString();
                    print("tag empty ${tag.isEmpty}");
                    if (tag.isNotEmpty) addTag(tag);
                  },
                  onChanged: (string) {
                    if (string.trim().contains(",")) {
                      var tag = string.trim().replaceAll(",", "").toString();
                      print("tag empty ${tag.isEmpty}");

                      if (tag.isNotEmpty) addTag(tag);
                    }
                  },
                  controller: textEditingController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration.collapsed(
                          hintText: LangText(context: OneContext().context)
                              .getLocal()
                              .type_hit_submit,
                          hintStyle: const TextStyle(fontSize: 12))
                      .copyWith(
                          constraints: const BoxConstraints(maxWidth: 150)),
                );
              }
              return Container(
                decoration: BoxDecoration(
                    color: MyTheme.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 2, color: MyTheme.grey_153)),
                constraints: BoxConstraints(
                    maxWidth: (DeviceInfo(context).getWidth() - 50) / 4),
                margin: const EdgeInsets.only(right: 5, bottom: 5),
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 20, top: 5, bottom: 5),
                        constraints: BoxConstraints(
                            maxWidth:
                                (DeviceInfo(context).getWidth() - 50) / 4),
                        child: Text(
                          tags![index].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        )),
                    Positioned(
                      right: 2,
                      child: InkWell(
                        onTap: () {
                          tags!.removeAt(index);
                          setChange();
                        },
                        child: Icon(Icons.highlight_remove,
                            size: 15, color: MyTheme.red),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
      isMandatory: isMandatory,
    );
  }

  addTag(String string) {
    if (string.trim().isNotEmpty) {
      tags!.add(string.trim());
    }
    tagEditTextController.clear();
    setChange();
  }

  Widget buildPriceEditTextField(String title, String hint,
      {isMandatory = false}) {
    return Container(
      child: buildCommonSingleField(
        title,
        MyWidget.customCardView(
          backgroundColor: MyTheme.white,
          elevation: 5,
          width: DeviceInfo(context).getWidth(),
          height: 46,
          borderRadius: 10,
          child: TextField(
            controller: unitPriceEditTextController,
            onChanged: (string) {},
            keyboardType: TextInputType.number,
            decoration: InputDecorations.buildInputDecoration_1(
                hint_text: hint,
                borderColor: MyTheme.noColor,
                hintTextColor: MyTheme.grey_153),
          ),
        ),
        isMandatory: isMandatory,
      ),
    );
  }

  Widget buildFlatEditTextField(
      String title, String hint, TextEditingController textEditingController,
      {isMandatory = false}) {
    return Container(
      child: buildCommonSingleField(
        title,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyTheme.app_accent_color_extra_light),
          width: DeviceInfo(context).getWidth(),
          height: 45,
          child: TextField(
            controller: textEditingController,
            decoration: InputDecorations.buildInputDecoration_1(
                hint_text: hint,
                borderColor: MyTheme.noColor,
                hintTextColor: MyTheme.grey_153),
          ),
        ),
        isMandatory: isMandatory,
      ),
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
          height: 10,
        ),
        child,
      ],
    );
  }

  Text buildFieldTitle(title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: MyTheme.font_grey),
    );
  }

/*
  buildExpansionTile(int index, dynamic onExpand, isExpanded) {
    return Container(
      height: isExpanded
          ? productVariations[index].photo == null
              ? 274
              : 334
          : 100,
      decoration: MDecoration.decoration1(),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyTheme.light_grey),
            constraints: BoxConstraints(),
            child: IconButton(
              splashRadius: 5,
              splashColor: MyTheme.noColor,
              constraints: BoxConstraints(),
              iconSize: 12,
              padding: EdgeInsets.zero,
              onPressed: () {
                isExpanded = !isExpanded;
                onExpand(isExpanded);
              },
              icon: Image.asset(
                isExpanded ? "assets/icon/remove.png" : "assets/icon/add.png",
                color: MyTheme.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: (mWidht / 3),
                        child: Text(
                          productVariations[index].name,
                          style: MyTextStyle.smallFontSize()
                              .copyWith(color: MyTheme.font_grey),
                        )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyTheme.app_accent_color_extra_light),
                      width: (mWidht / 3),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller:
                            productVariations[index].priceEditTextController,
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "0",
                            borderColor: MyTheme.noColor,
                            hintTextColor: MyTheme.grey_153),
                      ),
                    )
                  ],
                ),
                if (isExpanded)
                  Column(
                    children: [
                      itemSpacer(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 80,
                              child: Text(
                                LangText(context: context)
                                    .getLocal()
                                    .sku_all_capital,
                                style: MyTextStyle.smallFontSize()
                                    .copyWith(color: MyTheme.font_grey),
                              )),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyTheme.white),
                            width: (mWidht * 0.6),
                            child: TextField(
                              controller: productVariations[index]
                                  .skuEditTextController,
                              decoration:
                                  InputDecorations.buildInputDecoration_1(
                                      fillColor: MyTheme.noColor,
                                      hint_text: "sku",
                                      borderColor: MyTheme.grey_153,
                                      hintTextColor: MyTheme.grey_153),
                            ),
                          )
                        ],
                      ),
                      itemSpacer(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            child: Text(
                              LangText(context: context)
                                  .getLocal()
                                  .quantity_ucf,
                              style: MyTextStyle.smallFontSize()
                                  .copyWith(color: MyTheme.font_grey),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyTheme.white),
                            width: (mWidht * 0.6),
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              keyboardType: TextInputType.number,
                              controller: productVariations[index]
                                  .quantityEditTextController,
                              decoration:
                                  InputDecorations.buildInputDecoration_1(
                                      fillColor: MyTheme.noColor,
                                      hint_text: "0",
                                      borderColor: MyTheme.grey_153,
                                      hintTextColor: MyTheme.grey_153),
                            ),
                          )
                        ],
                      ),
                      itemSpacer(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            child: Text(
                              LangText(context: context)
                                  .getLocal()
                                  .photo_ucf,
                              style: MyTextStyle.smallFontSize()
                                  .copyWith(color: MyTheme.font_grey),
                            ),
                          ),
                          SizedBox(
                            width: (mWidht * 0.6),
                            child: imageField("", (onChosenImage) {
                              productVariations[index].photo = onChosenImage;
                              setChange();
                            }, productVariations[index].photo),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
*/

  buildSwitchField(String title, value, onChanged, {isMandatory = false}) {
    return Row(
      children: [
        if (title.isNotEmpty) buildFieldTitle(title),
        if (isMandatory)
          Text(
            " *",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: MyTheme.red),
          ),
        const Spacer(),
        Container(
          height: 30,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: MyTheme.green,
          ),
        ),
      ],
    );
  }

  AppLocalizations get getLocal => LangText(context: context).getLocal();

  _buildDateAndTimeRange() async {
    DateTimeRange? dateAndTime;
    print(startDate);
    DateTime? startDateTime = startDate, endDateTime = endDate;
    print(startDateTime);
    dateAndTime = await showDialog<DateTimeRange>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return AlertDialog(
              titlePadding: EdgeInsets.zero,
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                color: MyTheme.app_accent_color,
                child: Text(
                  getLocal.pick_a_auction_end_and_start_date,
                  style: TextStyle(
                      fontSize: 16,
                      color: MyTheme.white,
                      fontWeight: FontWeight.w500),
                ),
              ),

              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              content: Container(
                color: MyTheme.noColor,
                height: 280,
                child: Column(
                  children: [
                    Text(
                      LangText(context: OneContext().context)
                          .getLocal()
                          .auction_start_date_ucf,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DateAndTimePicker(
                      onPicked: (dateTime) {
                        startDateTime = dateTime;
                        setState(() {});
                      },
                      initialYear: startDateTime?.year,
                      initialMonth: startDateTime?.month,
                      initialDay: startDateTime?.day,
                      initialHour: startDateTime?.hour,
                      initialMin: startDateTime?.minute,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      LangText(context: OneContext().context)
                          .getLocal()
                          .auction_end_date_ucf,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DateAndTimePicker(
                      onPicked: (dateTime) {
                        endDateTime = dateTime;
                        setState(() {});
                      },
                      initialYear: endDateTime?.year,
                      initialMonth: endDateTime?.month,
                      initialDay: endDateTime?.day,
                      initialHour: endDateTime?.hour,
                      initialMin: endDateTime?.minute,
                    ),
                  ],
                ),
              ),
              //actionsPadding: EdgeInsets.symmetric(vertical: 10),
              actions: [
                Buttons(
                  color: MyTheme.app_accent_color,
                  child: Text(
                    LangText(context: OneContext().context).getLocal().ok,
                    style: TextStyle(
                        fontSize: 16,
                        color: MyTheme.white,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    DateTimeRange? date;
                    if (startDateTime != null &&
                        endDateTime != null &&
                        startDateTime!.isBefore(endDateTime!)) {
                      date = DateTimeRange(
                          start: startDateTime!, end: endDateTime!);
                    }
                    Navigator.pop(context, date);
                  },
                )
              ],
            );
          });
        });
    if (dateAndTime != null) {
      // print("ddd ${dateRange.toString()}");
      startDate = dateAndTime.start;
      endDate = dateAndTime.end;
      setState(() {});
    }

    // var date = DateUtils.getDaysInMonth(2023, 2);
    // showCupertinoModalPopup<void>(
    //   context: context,
    //   builder: (BuildContext context) => Container(
    //     height: 216,
    //     padding: const EdgeInsets.only(top: 6.0),
    //     margin: EdgeInsets.only(
    //       bottom: MediaQuery.of(context).viewInsets.bottom,
    //     ),
    //     color: CupertinoColors.systemBackground.resolveFrom(context),
    //     child: SafeArea(
    //       top: false,
    //       child: CupertinoDatePicker(
    //         dateOrder: DatePickerDateOrder.ydm,
    //         initialDateTime: endDateTime,
    //         use24hFormat: false,
    //         // This is called when the user changes the dateTime.
    //         onDateTimeChanged: (DateTime newDateTime) {
    //           setState(() => endDateTime = newDateTime);
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }

  String formatDateTime(DateTime date) {
    return DateFormat("y-MM-d HH:mm:ss").format(date);
  }

/*
  Widget showYears(setState, {int? initialYear}) {
    // initialYear ??= DateTime.now().year;
    // selectedYear = initialYear;
    return SizedBox(
      width: 60,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          const Text("Year"),
          SizedBox(
            height: 60,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                  initialItem: years.indexOf(selectedMonth)),
              //backgroundColor: Colors.red,
              itemExtent: 25,
              // useMagnifier: false,
              magnification: 1,
              selectionOverlay: Container(
                  // color: Colors.red,
                  ),
              // diameterRatio: 1.1,
              onSelectedItemChanged: (selected) {
                selectedYear = years[selected];
                makeDays(setState, selectedYear, selectedMonth);

                setState(() {});
              },
              children: List.generate(
                years.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "${years[index]}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showMonth(setState) {
    // initialMonth ??= DateTime.now().month;

    return Container(
      width: 60,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          Text("Month"),
          SizedBox(
            height: 60,
            child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: (selectedMonth - 1)),
                //backgroundColor: Colors.red,
                itemExtent: 25,
                // useMagnifier: false,
                magnification: 1,
                selectionOverlay: Container(
                    // color: Colors.red,
                    ),
                // diameterRatio: 1.1,
                onSelectedItemChanged: (selected) {
                  selectedMonth = selected + 1;
                  print(selectedMonth);
                  makeDays(setState, selectedYear, selectedMonth);

                  setState(() {});
                },
                children: List.generate(
                    months.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${months[index]}",
                            style: TextStyle(fontSize: 15),
                          ),
                        ))),
          ),
        ],
      ),
    );
  }

  Widget showDay(setState, {int? initialDay}) {
    makeDays(setState, selectedYear, selectedMonth);
    initialDay ??= DateTime.now().day;

    return SizedBox(
      width: 60,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          const Text("Day"),
          SizedBox(
            height: 60,
            child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: days.indexOf(initialDay)),
                //backgroundColor: Colors.red,
                itemExtent: 25,
                // useMagnifier: false,
                magnification: 1,
                selectionOverlay: Container(
                    // color: Colors.red,
                    ),
                // diameterRatio: 1.1,
                onSelectedItemChanged: (selected) {},
                children: List.generate(
                    days.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${days[index]}",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ))),
          ),
        ],
      ),
    );
  }

  makeDays(state, year, month) {
    int i = 1;
    days.clear();
    print(selectedYear);
    print(selectedMonth);
    print(DateUtils.getDaysInMonth(selectedYear, selectedMonth));
    while (i <= DateUtils.getDaysInMonth(selectedYear, selectedMonth)) {
      days.add(i);
      i++;
    }
    state(() {});
  }

  Widget showHour() {
    return SizedBox(
      width: 60,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          const Text("Day"),
          SizedBox(
            height: 60,
            child: CupertinoPicker(
                //backgroundColor: Colors.red,
                itemExtent: 25,
                // useMagnifier: false,
                magnification: 1,
                selectionOverlay: Container(
                    // color: Colors.red,
                    ),
                // diameterRatio: 1.1,
                onSelectedItemChanged: (selected) {},
                children: List.generate(
                    days.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${days[index]}",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ))),
          ),
        ],
      ),
    );
  }

  Widget showMin() {
    return SizedBox(
      width: 60,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          const Text("Day"),
          SizedBox(
            height: 60,
            child: CupertinoPicker(
                //backgroundColor: Colors.red,
                itemExtent: 25,
                // useMagnifier: false,
                magnification: 1,
                selectionOverlay: Container(
                    // color: Colors.red,
                    ),
                // diameterRatio: 1.1,
                onSelectedItemChanged: (selected) {},
                children: List.generate(
                    days.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${days[index]}",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ))),
          ),
        ],
      ),
    );
  }
*/ /*
  _buildPickDate() async {
    DateTimeRange? p;
    DateTime? startDateTime;
    DateTime? endDateTime;
    p = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.utc(2050),
        builder: (context, child) {
          return SizedBox(
            width: 500,
            height: 500,
            child: DateRangePickerDialog(
              initialDateRange:
                  DateTimeRange(start: DateTime.now(), end: DateTime.now()),
              saveText: "Select",
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              firstDate: DateTime.now(),
              lastDate: DateTime.utc(2050),
            ),
          );
        });
    // if (context.mounted) {
    var startTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 0),
        helpText: "Start Time",
        builder: (context, child) {
          return child!;
        });

    var endTime = await showTimePicker(
        helpText: "End Time",
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 0));

    if (p != null) {
      if (startTime != null) {
        startDateTime = p.start.copyWith(
            hour: startTime.hour, minute: startTime.minute, millisecond: 0);
      }
      if (endTime != null) {
        endDateTime = p.end.copyWith(
            hour: endTime.hour, minute: endTime.minute, millisecond: 0);
      }
    }
    // }

    setState(() {
      dateTimeRange = DateTimeRange(start: startDateTime!, end: endDateTime!);
      dateRange =
          "${DateFormat("y-MM-d HH:mm:ss").format(dateTimeRange.start)} to ${DateFormat("y-MM-d HH:mm:ss").format(dateTimeRange.end)}";
    });
  }*/

  Widget buildTapBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildTopTapBarItem(
              LangText(context: context).getLocal().general_ucf, 0),
          tabBarDivider(),
          buildTopTapBarItem(
              LangText(context: context).getLocal().media_ucf, 1),
          tabBarDivider(),
          buildTopTapBarItem(
              LangText(context: context)
                  .getLocal()
                  .product_binding_and_date_ucf,
              2),
          tabBarDivider(),
          buildTopTapBarItem(
              LangText(context: context).getLocal().seo_all_capital, 3),
          tabBarDivider(),
          buildTopTapBarItem(
              LangText(context: context).getLocal().shipping_ucf, 4),
        ],
      ),
    );
  }

  Widget tabBarDivider() {
    return const SizedBox(
      width: 1,
      height: 50,
    );
  }

  Container buildTopTapBarItem(String text, int index) {
    return Container(
      height: 50,
      width: 100,
      color: _selectedTabIndex == index
          ? MyTheme.app_accent_color
          : MyTheme.app_accent_color.withOpacity(0.5),
      child: Buttons(
        onPressed: () {
          _selectedTabIndex = index;
          setState(() {});
        },
        child: Text(
          text,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: MyTheme.white),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 0.0,
      centerTitle: false,
      elevation: 0.0,
      title: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            child: IconButton(
              splashRadius: 15,
              padding: const EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                'assets/icon/back_arrow.png',
                height: 20,
                width: 20,
                color: MyTheme.app_accent_color,
                //color: MyTheme.dark_grey,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            LangText(context: context).getLocal().add_new_product_ucf,
            style: MyTextStyle().appbarText(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: Size(mWidht, 50),
        child: buildTapBar(),
      ),
    );
  }
}

class VariationModel {
  String name;

  FileInfo photo;
  TextEditingController priceEditTextController,
      quantityEditTextController,
      skuEditTextController;
  bool isExpended;

  VariationModel(
      this.name,
      //this.id,
      this.photo,
      this.priceEditTextController,
      this.quantityEditTextController,
      this.skuEditTextController,
      this.isExpended);
}

class Tags {
  static List<String> tags = [];

  static toJson() {
    Map<String, String> map = {};

    tags.forEach((element) {
      map.addAll({"value": element});
    });

    return map;
  }

  static string() {
    return jsonEncode(toJson());
  }
}
