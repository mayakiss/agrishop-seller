import 'dart:async';
import 'dart:convert';

import 'package:active_ecommerce_seller_app/const/app_style.dart';
import 'package:active_ecommerce_seller_app/const/dropdown_models.dart';
import 'package:active_ecommerce_seller_app/custom/aiz_summer_note.dart';
import 'package:active_ecommerce_seller_app/custom/buttons.dart';
import 'package:active_ecommerce_seller_app/custom/common_style.dart';
import 'package:active_ecommerce_seller_app/custom/decorations.dart';
import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/custom/input_decorations.dart';
import 'package:active_ecommerce_seller_app/custom/loading.dart';
import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:active_ecommerce_seller_app/custom/multi_category_section.dart';
import 'package:active_ecommerce_seller_app/custom/my_widget.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/data_model/language_list_response.dart';
import 'package:active_ecommerce_seller_app/data_model/product/attribut_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/category_response_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/category_view_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/custom_radio_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/product_edit_response.dart';
import 'package:active_ecommerce_seller_app/data_model/product/vat_tax_model.dart';
import 'package:active_ecommerce_seller_app/data_model/uploaded_file_list_response.dart';
import 'package:active_ecommerce_seller_app/helpers/main_helper.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/language_repository.dart';
import 'package:active_ecommerce_seller_app/repositories/product_repository.dart';
import 'package:active_ecommerce_seller_app/screens/uploads/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:one_context/one_context.dart';
import 'package:toast/toast.dart';

class UpdateProduct extends StatefulWidget {
  final productId;

  UpdateProduct({Key? key, this.productId}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  // double variables

  String _statAndEndTime = "Select Date";

  double mHeight = 0.0, mWidht = 0.0;
  int _selectedTabIndex = 0;
  bool isColorActive = false;
  bool isRefundable = false;
  bool isCashOnDelivery = false;
  bool isProductQuantityMultiply = false;
  bool isFeatured = false;
  bool isTodaysDeal = false;
  bool isShowStockQuantity = false;
  bool isShowStockWithTextOnly = false;
  bool isHideStock = false;

  bool isCategoryInit = false;
  List<CategoryModel> categories = [];
  List<Language> languages = [];
  List<CommonDropDownItem> brands = [];
  List<VatTaxViewModel> vatTaxList = [];
  List<CommonDropDownItem> videoType = [];
  List<CommonDropDownItem> discountTypeList = [];
  List<CommonDropDownItem> colorList = [];
  List<CommonDropDownItem> selectedColors = [];
  List<AttributesModel> attribute = [];
  List<AttributesModel> selectedAttributes = [];
  List<VariationModel> productVariations = [];
  List<CustomRadioModel> shippingConfigurationList = [];
  List<CustomRadioModel> stockVisibilityStateList = [];
  late CustomRadioModel selectedShippingConfiguration;
  late CustomRadioModel selectedstockVisibilityState;

  CommonDropDownItem? selectedBrand;
  Language? selectedLanguage;

  CommonDropDownItem? selectedVideoType;
  CommonDropDownItem? selectedAddToFlashType;
  CommonDropDownItem? selectedFlashDiscountType;
  CommonDropDownItem? selectedProductDiscountType;
  CommonDropDownItem? selectedColor;
  AttributesModel? selectedAttribute;
  FlutterSummernote? summernote;

  //Product value

  List<String> tmpColorList = [];
  List<ChoiceOption> tmpAttribute = [];
  String? tmpCategory = "";
  String? tmpBrand = "";
  bool isProductDetailsInit = false;

  List categoryIds = [];
  String? productName,
      categoryId,
      brandId,
      unit,
      weight,
      minQuantity,
      refundable,
      barcode,
      photos,
      thumbnailImg,
      videoProvider,
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
      slug,
      metaDescription,
      metaImg,
      shippingType,
      flatShippingCost,
      lowStockQuantity,
      stockVisibilityState,
      cashOnDelivery,
      estShippingDays,
      button;
  String? lang = "en";
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

  //ImagePicker pickImage = ImagePicker();

  List<FileInfo> productGalleryImages = [];
  FileInfo? thumbnailImage;
  FileInfo? metaImage;
  FileInfo? pdfDes;
  DateTimeRange? dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  //Edit text controller
  TextEditingController productNameEditTextController = TextEditingController();
  TextEditingController unitEditTextController = TextEditingController();
  TextEditingController weightEditTextController =
      TextEditingController(text: "0.0");
  TextEditingController minimumEditTextController =
      TextEditingController(text: "1");
  TextEditingController tagEditTextController = TextEditingController();
  TextEditingController barcodeEditTextController = TextEditingController();
  TextEditingController taxEditTextController = TextEditingController();
  TextEditingController videoLinkEditTextController = TextEditingController();
  TextEditingController metaTitleEditTextController = TextEditingController();
  TextEditingController slugEditTextController = TextEditingController();
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
  TextEditingController skuEditTextController = TextEditingController();
  TextEditingController externalLinkEditTextController =
      TextEditingController();
  TextEditingController externalLinkButtonTextEditTextController =
      TextEditingController();
  TextEditingController stockLowWarningTextEditTextController =
      TextEditingController();
  TextEditingController variationPriceTextEditTextController =
      TextEditingController();
  TextEditingController variationQuantityTextEditTextController =
      TextEditingController();
  TextEditingController variationSkuTextEditTextController =
      TextEditingController();
  TextEditingController flatShippingCostTextEditTextController =
      TextEditingController();
  TextEditingController lowStockQuantityTextEditTextController =
      TextEditingController(text: "1");
  TextEditingController _TextEditTextController = TextEditingController();

  GlobalKey<FlutterSummernoteState> productDescriptionKey = GlobalKey();

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

      // if (element.level > 0) {
      //   model.setLevelText();
      // }
      // categories.add(model);
      // if (element.child!.isNotEmpty) {
      //
      // }
    });
    return list;
  }

  getBrands() async {
    var brandsRes = await ProductRepository().getBrandRes();
    brands.clear();
    brandsRes.data!.forEach((element) {
      brands.addAll([
        CommonDropDownItem("${element.id}", element.name),
      ]);
    });

    if (tmpBrand != null && tmpBrand!.isNotEmpty && brands.isNotEmpty) {
      brands.forEach((element) {
        if (element.key == tmpBrand) {
          selectedBrand = element;
        }
      });
    }

    setState(() {});
  }

  getColors() async {
    var colorRes = await ProductRepository().getColorsRes();
    colorList.clear();

    colorRes.data!.forEach((element) {
      colorList.add(CommonDropDownItem("${element.code}", "${element.name}"));
    });

    selectedColors.clear();

    colorList.forEach((element) {
      if (tmpColorList.contains(element.key)) {
        selectedColors.add(element);
      }
    });

    setState(() {});
  }

  getAttributes() async {
    var attributeRes = await ProductRepository().getAttributeRes();
    attribute.clear();

    selectedAttributes.clear();

    attributeRes.data!.forEach((element) {
      attribute.add(
        AttributesModel(
          CommonDropDownItem("${element.id}", "${element.name}"),
          List.generate(
              element.values!.length,
              (index) => CommonDropDownItem("${element.values![index].id}",
                  "${element.values![index].value}")),
          [],
          null,
        ),
      );
    });

    tmpAttribute.forEach((tmpElement) {
      attribute.forEach((attributeElement) {
        if (attributeElement.name.key == tmpElement.attributeId) {
          List<CommonDropDownItem> items = [];

          tmpElement.values!.forEach((tmpItems) {
            attributeElement.attributeItems.forEach((attributeItems) {
              if (tmpItems == attributeItems.value) {
                items.add(attributeItems);
              }
            });
          });
          selectedAttributes.add(AttributesModel(attributeElement.name,
              attributeElement.attributeItems, items, null));
        }
      });
    });
    setState(() {});
  }

  setConstDropdownValues() {
    videoType.clear();
    videoType.addAll([
      CommonDropDownItem("youtube",
          LangText(context: OneContext().context).getLocal()!.youtube_ucf),
      CommonDropDownItem("dailymotion",
          LangText(context: OneContext().context).getLocal()!.dailymotion_ucf),
      CommonDropDownItem("vimeo",
          LangText(context: OneContext().context).getLocal()!.vimeo_ucf),
    ]);
    selectedVideoType = videoType.first;

    discountTypeList.clear();
    discountTypeList.addAll([
      CommonDropDownItem("amount", "Flat"),
      CommonDropDownItem("percent", "Percent"),
    ]);
    selectedProductDiscountType = discountTypeList.first;
    selectedFlashDiscountType = discountTypeList.first;
    // selectedCategory = categories.first;
    shippingConfigurationList.clear();
    shippingConfigurationList.addAll([
      CustomRadioModel("Free Shipping", "free", true),
      CustomRadioModel("Flat Rate", "flat_rate", false),
    ]);
    stockVisibilityStateList.clear();
    stockVisibilityStateList.addAll([
      CustomRadioModel("Show Stock Quantity", "quantity", true),
      CustomRadioModel("Show Stock With Text Only", "text", false),
      CustomRadioModel("Hide Stock", "hide", false)
    ]);

    selectedShippingConfiguration = shippingConfigurationList.first;
    selectedstockVisibilityState = stockVisibilityStateList.first;

    setState(() {});
  }

  getTaxType(ProductInfo productInfo) async {
    var taxRes = await ProductRepository().getTaxRes();
    vatTaxList.clear();
    taxRes.data!.forEach((element) {
      var tmpTax = productInfo.tax!
          .where((productTax) => productTax.taxId == element.id);

      if (tmpTax.isNotEmpty) {
        var taxList = [
          CommonDropDownItem("amount", "Flat"),
          CommonDropDownItem("percent", "Percent")
        ];
        CommonDropDownItem selectedTax = taxList
            .where((element) => element.key == tmpTax.first.taxType)
            .first;

        vatTaxList.add(
          VatTaxViewModel(
              VatTaxModel("${element.id}", "${element.name}"), taxList,
              selectedItem: selectedTax, amount: tmpTax.first.tax?.toString()),
        );
      } else {
        vatTaxList.add(
          VatTaxViewModel(
            VatTaxModel("${element.id}", "${element.name}"),
            [
              CommonDropDownItem("amount", "Flat"),
              CommonDropDownItem("percent", "Percent"),
            ],
          ),
        );
      }
    });
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
    // ////print(images != null);
    if (images != null) {
      productGalleryImages = images;
      setChange();
    }
  }

/*
  Future<XFile> pickSingleImage() async {
    return await pickImage.pickImage(source: ImageSource.gallery);
  }*/

  createProductVariation() {
    productVariations.clear();

    if (selectedColors.isNotEmpty) {
      selectedColors.forEach((colors) {
        // add attribute with color;
        var colorName = colors.value;
        List<String> attributeList = generateAttributeVariation();
        if (attributeList.isNotEmpty) {
          attributeList.forEach((element) {
            String variationName = colorName! + "-" + element;
            productVariations.add(VariationModel(
                variationName,
                FileInfo(),
                TextEditingController(
                    text: unitPriceEditTextController.text.trim().toString()),
                TextEditingController(text: "0"),
                TextEditingController(text: variationName),
                false));
          });
        } else {
          String? variationName = colorName;
          productVariations.add(VariationModel(
              variationName,
              FileInfo(),
              TextEditingController(
                  text: unitPriceEditTextController.text.trim().toString()),
              TextEditingController(text: "0"),
              TextEditingController(text: variationName),
              false));
        }
      });
    } else {
      List<String> attributeList = generateAttributeVariation();

      if (attributeList.isNotEmpty) {
        attributeList.forEach((element) {
          String variationName = element;
          productVariations.add(VariationModel(
              variationName,
              null,
              TextEditingController(
                  text: unitPriceEditTextController.text.trim().toString()),
              TextEditingController(text: "10"),
              TextEditingController(text: variationName),
              false));
        });
      }
    }
  }

  setInitialProductVariation(Stock stock) {
    productVariations.clear();

    if (stock.data!.isNotEmpty) {
      stock.data!.forEach(
        (element) {
          FileInfo? image;
          if (element.image!.data!.isNotEmpty) {
            image = element.image!.data!.first;
          }

          productVariations.add(VariationModel(
              element.variant,
              image == null ? null : image,
              TextEditingController(text: element.price?.toString()),
              TextEditingController(text: element.qty?.toString()),
              TextEditingController(text: element.sku),
              false));
        },
      );
    }

    ////print("productVariations.length${productVariations.length}");

    /*if (stock.data.isNotEmpty) {
      selectedColors.forEach((colors) {
        // add attribute with color;
        var colorName = colors.value;
        List<String> attributeList = generateAttributeVariation();
        if (attributeList.isNotEmpty) {
          attributeList.forEach((element) {

            String variationName = colorName + "-" + element;
            productVariations.add(VariationModel(
                variationName,
                FileInfo(),
                TextEditingController(
                    text: unitPriceEditTextController.text.trim()?.toString()),
                TextEditingController(text: "0"),
                TextEditingController(text: variationName),
                false));
          });
        } else {
          String variationName = colorName ;
          productVariations.add(VariationModel(
              variationName,
              FileInfo(),
              TextEditingController(
                  text: unitPriceEditTextController.text.trim()?.toString()),
              TextEditingController(text: "0"),
              TextEditingController(text: variationName),
              false));
        }
      });
    } else {
      List<String> attributeList = generateAttributeVariation();

      if (attributeList.isNotEmpty) {
        attributeList.forEach((element) {
          String variationName = element ;
          productVariations.add(VariationModel(
              variationName,
              null,
              TextEditingController(
                  text: unitPriceEditTextController.text.trim()?.toString()),
              TextEditingController(text: "10"),
              TextEditingController(text: variationName),
              false));
        });
      }
    }*/
    setChange();
  }

  List<String> generateAttributeVariation() {
    var variationColumn = 1;

    selectedAttributes.forEach((element) {
      if (element.selectedAttributeItems.isNotEmpty) {
        variationColumn =
            variationColumn * element.selectedAttributeItems.length;
      }
    });

    List<String> mList = [];

    for (int i = 0; i < selectedAttributes.length; i++) {
      for (int j = 0;
          j < selectedAttributes[i].selectedAttributeItems.length;
          j++) {
        if (i == 0) {
          for (int k = 0;
              k <
                  (variationColumn /
                      selectedAttributes[i].selectedAttributeItems.length);
              k++) {
            var value = selectedAttributes[i]
                .selectedAttributeItems[j]
                .value!
                .replaceAll(" ", "");
            mList.add(value);
          }
        } else {
          for (int l = j;
              l < mList.length;
              l = l + selectedAttributes[i].selectedAttributeItems.length) {
            String tmp = mList[l] +
                "-" +
                selectedAttributes[i]
                    .selectedAttributeItems[j]
                    .value!
                    .replaceAll(" ", "");
            mList[l] = tmp;
          }
        }
      }
    }

    return mList;
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

  setColors() {
    colors = [];
    selectedColors.forEach((element) {
      colors!.add(element.key);
    });
  }

  setChoiceAtt() {
    choiceAttributes = [];
    choiceNo = [];
    choice = [];
    if (choice_options != null) choice_options.clear();

    selectedAttributes.forEach((element) {
      choiceAttributes!.add(element.name.key);
      choiceNo!.add(element.name.key);
      choice!.add(element.name.value);

      List<String?> tmpValue = [];
      element.selectedAttributeItems.forEach((attributes) {
        tmpValue.add(attributes.value);
      });
      choice_options.addAll({"choice_options_${element.name.key}": tmpValue});
    });

    choiceAttributes!.sort();
  }

  setTaxes() {
    taxType = [];
    tax = [];
    taxId = [];
    vatTaxList.forEach((element) {
      taxId!.add(element.vatTaxModel.id);
      tax!.add(element.amount.text.trim().toString());
      if (element.selectedItem != null) taxType!.add(element.selectedItem!.key);
    });
  }

  setProductValues() async {
    productName = productNameEditTextController.text.trim();

    if (selectedBrand != null) brandId = selectedBrand!.key;

    unit = unitEditTextController.text.trim();
    weight = weightEditTextController.text.trim();
    minQuantity = minimumEditTextController.text.trim();

    tagMap.clear();
    tags!.forEach((element) {
      tagMap.add(jsonEncode({"value": '$element'}));
    });
    // add product photo
    setProductPhotoValue();
    if (thumbnailImage != null) thumbnailImg = "${thumbnailImage!.id}";
    videoProvider = selectedVideoType!.key;
    videoLink = videoLinkEditTextController.text.trim().toString();
    //Set colors
    setColors();
    colorsActive = isColorActive ? "1" : "0";
    unitPrice = unitPriceEditTextController.text.trim().toString();
    //print("#########################");
    //print(unitPrice);
    //print("#########################");
    dateRange = dateTimeRange!.start.toString() +
        " to " +
        dateTimeRange!.end.toString();
    discount = productDiscountEditTextController.text.trim().toString();
    discountType = selectedProductDiscountType!.key;
    currentStock = productVariations.isEmpty
        ? productQuantityEditTextController.text.trim().toString()
        : "0";
    sku = productVariations.isEmpty
        ? skuEditTextController.text.trim().toString()
        : null;
    externalLink = externalLinkEditTextController.text.trim().toString();
    externalLinkBtn =
        externalLinkButtonTextEditTextController.text.trim().toString();

    if (productDescriptionKey.currentState != null) {
      description = await productDescriptionKey.currentState!.getText() ?? "";
      description = await productDescriptionKey.currentState!.getText() ?? "";
    }

    if (pdfDes != null) pdf = "${pdfDes!.id}";
    metaTitle = metaTitleEditTextController.text.trim().toString();
    slug = slugEditTextController.text.trim().toString();
    ////print("slug");
    ////print(slug);

    metaDescription = metaDescriptionEditTextController.text.trim().toString();
    if (metaImage != null) metaImg = "${metaImage!.id}";
    shippingType = selectedShippingConfiguration.key;
    flatShippingCost =
        flatShippingCostTextEditTextController.text.trim().toString();
    lowStockQuantity =
        lowStockQuantityTextEditTextController.text.trim().toString();
    stockVisibilityState = selectedstockVisibilityState.key;
    cashOnDelivery = isCashOnDelivery ? "1" : "0";
    estShippingDays = shippingDayEditTextController.text.trim().toString();
    // get taxes
    refundable = isRefundable ? "1" : "0";
    setTaxes();
  }

  bool requiredFieldVerification() {
    if (productNameEditTextController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog("Product Name Required", gravity: Toast.center);
      return false;
    } else if (minimumEditTextController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog("Product Minimum Quantity Required");
      return false;
    } else if (unitEditTextController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog("Product Unit Required");
      return false;
    }
    return true;
  }

  submitProduct() async {
    if (!requiredFieldVerification()) {
      return;
    }

    Loading().show();

    await setProductValues();

    setChoiceAtt();
    Map postValue = Map();
    postValue.addAll({
      "name": productName,
      "category_id": categoryId,
      "category_ids": categoryIds,
      "brand_id": brandId,
      "unit": unit,
      "weight": weight,
      "min_qty": minQuantity,
      "tags": [tagMap.toString()],
      "photos": photos,
      "thumbnail_img": thumbnailImg,
      "video_provider": videoProvider,
      "video_link": videoLink,
      "colors": colors,
      "colors_active": colorsActive,
      "choice_attributes": choiceAttributes,
      "choice_no": choiceNo,
      "choice": choice
    });

    postValue.addAll(choice_options);

    if (refund_addon.$) {
      postValue.addAll({"refundable": refundable});
    }

    postValue.addAll({
      "unit_price": unitPrice,
      "date_range": int.parse(discount!) <= 0 ? null : dateRange,
      "discount": discount,
      "discount_type": discountType,
      "current_stock": currentStock,
      "sku": sku,
      "external_link": externalLink,
      "external_link_btn": externalLinkBtn,
    });
    postValue.addAll(makeVariationMap());

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
      "slug": slug,
      "low_stock_quantity": lowStockQuantity,
      "stock_visibility_state": stockVisibilityState,
      "cash_on_delivery": cashOnDelivery,
      "est_shipping_days": estShippingDays,
      "tax_id": taxId,
      "tax": tax,
      "tax_type": taxType,
      "button": button,
    });

    ////print("lang");
    ////print(lang);
    ////print(postValue);

    var postBody = jsonEncode(postValue);
    var response = await ProductRepository()
        .updateProductResponse(postBody, widget.productId, lang);

    Loading().hide();
    if (response.result!) {
      ToastComponent.showDialog(response.message, gravity: Toast.center);

      Navigator.pop(context);
    } else {
      List errorMessages = response.message;
      ToastComponent.showDialog(errorMessages.join(","), gravity: Toast.center);
    }
  }

  Map makeVariationMap() {
    Map variation = Map();
    productVariations.forEach((element) {
      variation.addAll({
        "price_" + element.name!.replaceAll(" ", "-"):
            element.priceEditTextController.text.trim().toString() ?? null,
        "sku_" + element.name!.replaceAll(" ", "-"):
            element.skuEditTextController.text.trim().toString() ?? null,
        "qty_" + element.name!.replaceAll(" ", "-"):
            element.quantityEditTextController.text.trim().toString() ?? null,
        "img_" + element.name!.replaceAll(" ", "-"):
            element.photo == null ? null : element.photo!.id,
      });
    });
    return variation;
  }

  setInitialValue(ProductInfo productInfo) {
    selectedLanguage =
        languages.where((element) => element.code == productInfo.lang).first;
    setConstDropdownValues();
    isColorActive = productInfo.colors!.isNotEmpty;
    isRefundable = productInfo.refundable == 1 ? true : false;

    ////print(productInfo.refundable);
    ////print("productInfo.refundable");

    isCashOnDelivery = productInfo.cashOnDelivery == 1 ? true : false;

    isProductQuantityMultiply =
        productInfo.isQuantityMultiplied == 1 ? true : false;
    // isFeatured = productInfo.featured == 1 ? true : false;
    isTodaysDeal = productInfo.todaysDeal == 1 ? true : false;
    tmpColorList.addAll(productInfo.colors!);
    getColors();

    tmpAttribute.clear();
    tmpAttribute.addAll(productInfo.choiceOptions!);
    getAttributes();
    if (productInfo.choiceOptions!.isNotEmpty) {
      setInitialProductVariation(productInfo.stocks!);
    }

    shippingConfigurationList.forEach((element) {
      element.isActive = false;
      if (element.key == productInfo.shippingType) {
        selectedShippingConfiguration = element;
        element.isActive = true;
        flatShippingCostTextEditTextController.text =
            productInfo.shippingCost!.toString();
      }
    });

    stockVisibilityStateList.forEach((element) {
      element.isActive = false;
      if (element.key == productInfo.stockVisibilityState) {
        selectedstockVisibilityState = element;
        element.isActive = true;
      }
    });

    categoryId = productInfo.categoryId?.toString();
    categoryIds.addAll(productInfo.categories);
    //print("cate = $categoryIds");
    getCategories();

    tmpBrand = productInfo.brandId?.toString();
    getBrands();

    videoType.forEach((element) {
      if (element.key == productInfo.videoProvider) {
        selectedVideoType = element;
      }
    });

    getTaxType(productInfo);

    discountTypeList.forEach((element) {
      if (productInfo.discountType == element.key) {
        selectedProductDiscountType = element;
      }
    });
    if (productInfo.photos!.data!.isNotEmpty) {
      productGalleryImages.addAll(productInfo.photos!.data!);
    }
    if (productInfo.thumbnailImg!.data!.isNotEmpty) {
      thumbnailImage = productInfo.thumbnailImg!.data!.first;
    }
    if (productInfo.metaImg!.data!.isNotEmpty) {
      metaImage = productInfo.metaImg!.data!.first;
    }
    if (productInfo.pdf!.data!.isNotEmpty) {
      pdfDes = productInfo.pdf!.data!.first;
    }

    var start = DateTime.tryParse(productInfo.discountStartDate)!;
    var end = DateTime.tryParse(productInfo.discountEndDate)!;
    ////print(start);
    ////print(end);
    dateTimeRange = DateTimeRange(start: start, end: end);

    _statAndEndTime =
        intl.DateFormat('d/MM/y').format(dateTimeRange!.start).toString() +
            " - " +
            intl.DateFormat('d/MM/y').format(dateTimeRange!.end).toString();
    tags!.clear();
    if (productInfo.tags!.isNotEmpty) {
      tags!.addAll(productInfo.tags!.split(","));
    }

    productNameEditTextController.text = productInfo.productName!;
    unitEditTextController.text = productInfo.productUnit ?? '';
    weightEditTextController.text = productInfo.weight!.toString();
    minimumEditTextController.text = productInfo.minQty!.toString();
    barcodeEditTextController.text = productInfo.barcode ?? "";

    videoLinkEditTextController.text = productInfo.videoLink ?? "";
    metaTitleEditTextController.text = productInfo.metaTitle!;
    slugEditTextController.text = productInfo.slug!;
    metaDescriptionEditTextController.text = productInfo.metaDescription!;
    shippingDayEditTextController.text =
        productInfo.estShippingDays.toString() ?? "";
    productDiscountEditTextController.text = productInfo.discount!.toString();

    unitPriceEditTextController.text = productInfo.unitPrice!.toString();

    if (productInfo.choiceOptions!.isEmpty) {
      productQuantityEditTextController.text =
          productInfo.stocks!.data!.first.qty!.toString();
      skuEditTextController.text = productInfo.stocks!.data!.first.sku ?? "";
    }

    externalLinkEditTextController.text = productInfo.externalLink ?? "";
    externalLinkButtonTextEditTextController.text =
        productInfo.externalLinkBtn ?? '';

    stockLowWarningTextEditTextController.text =
        productInfo.stockVisibilityState!.toString();

    lowStockQuantityTextEditTextController.text =
        productInfo.lowStockQuantity.toString() ?? "";
    description = productInfo.description ?? "";

    // summernote  = FlutterSummernote(
    //     showBottomToolbar: false,
    //     hint: "",
    //     value:description ,
    //     key: productDescriptionKey);

    productDescriptionKey.currentState!.setText(description!);

    ////print(productInfo.description);

    setChange();
  }

  getProductCurrentValues() async {
    if (selectedLanguage != null) {
      lang = selectedLanguage!.code;
    } else {
      lang = languages!.first.code;
    }

    await Future.delayed(Duration.zero);
    Loading.setInstance(context);
    Loading().show();

    var productResponse =
        await ProductRepository().productEdit(id: widget.productId, lang: lang);

    Loading().hide();
    if (productResponse.result!) {
      isProductDetailsInit = true;
      ////print("result true");
      setInitialValue(productResponse.data!);
    }
  }

  Future getLanguages() async {
    var languageListResponse = await LanguageRepository().getLanguageList();
    languages.addAll(languageListResponse.languages!);

    setChange();

    return;
  }

  @override
  void initState() {
    getLanguages().then((value) {
      getProductCurrentValues();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidht = MediaQuery.of(context).size.width;
    if (Loading.getInstance() == null) {
      Loading.setInstance(context);
    }
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: buildAppBar(context) as PreferredSizeWidget?,
        body: SingleChildScrollView(child: buildBodyContainer()),
        bottomNavigationBar: buildBottomAppBar(context),
      ),
    );
  }

  Widget buildBodyContainer() {
    return changeMainContent(_selectedTabIndex);
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
          color: MyTheme.app_accent_color.withOpacity(0.7),
          width: mWidht,
          child: Buttons(
              onPressed: () async {
                submitProduct();
              },
              child: Text(
                LangText(context: context).getLocal()!.update_now_ucf,
                style: TextStyle(color: MyTheme.white),
              ))),
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
        return buildPriceNStock();
        break;
      case 3:
        return buildSEO();
        break;
      case 4:
        return buildShipping();
        break;
      case 5:
        //return buildMarketing();
        break;
      default:
        return Container();
    }
  }

  Widget buildGeneral() {
    return buildTabViewItem(
      LangText(context: context).getLocal()!.product_information_ucf,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildEditTextField(
            LangText(context: context).getLocal()!.product_name_ucf,
            LangText(context: context).getLocal()!.product_name_ucf,
            productNameEditTextController,
            isMandatory: true,
          ),
          itemSpacer(),
          _buildMultiCategory(
              LangText(context: context).getLocal()!.categories_ucf,
              isMandatory: true),
          itemSpacer(),
          _buildDropDownField(LangText(context: context).getLocal()!.brands_ucf,
              (value) {
            selectedBrand = value;
            setChange();
          }, selectedBrand, brands),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context).getLocal()!.unit_ucf,
              LangText(context: context).getLocal()!.unit_ucf,
              unitEditTextController),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context).getLocal()!.weight_in_kg_ucf,
              "0.0",
              weightEditTextController),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context)
                  .getLocal()!
                  .minimum_purchase_quantity_ucf,
              "1",
              minimumEditTextController,
              isMandatory: true),
          itemSpacer(),
          buildTagsEditTextField(
              LangText(context: context).getLocal()!.tags_ucf,
              LangText(context: context)
                  .getLocal()!
                  .type_and_hit_enter_to_add_a_tag_ucf,
              tagEditTextController,
              isMandatory: true),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context).getLocal()!.barcode_ucf,
              LangText(context: context).getLocal()!.barcode_ucf,
              barcodeEditTextController,
              isMandatory: false),
          if (refund_addon.$)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                itemSpacer(),
                buildSwitchField(
                    LangText(context: context).getLocal()!.refundable_ucf,
                    isRefundable, (value) {
                  isRefundable = value;
                  setChange();
                }),
              ],
            ),
          itemSpacer(),
          // buildSwitchField(
          //     LangText(context: context).getLocal().product_add_screen_featured,
          //     isFeatured, (changedValue) {
          //   isFeatured = changedValue;
          //   setChange();
          // }),
          // itemSpacer(),
          buildGroupItems(
              LangText(context: context).getLocal()!.product_description_ucf,
              summerNote(
                  LangText(context: context).getLocal()!.description_ucf)),
          itemSpacer(),
          buildSwitchField(
            LangText(context: context).getLocal()!.cash_on_delivery_ucf,
            isCashOnDelivery,
            (onChanged) {
              isCashOnDelivery = onChanged;
              setChange();
            },
          ),
          itemSpacer(),
          buildGroupItems(
            LangText(context: context).getLocal()!.vat_n_tax_ucf,
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
          Spacer(),
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
      LangText(context: context).getLocal()!.product_images_ucf,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chooseGalleryImageField(),
          itemSpacer(),
          chooseSingleImageField(
              LangText(context: context).getLocal()!.thumbnail_image_300_ucf,
              LangText(context: context).getLocal()!.thumbnail_image_300_des,
              (onChosenImage) {
            thumbnailImage = onChosenImage;
            setChange();
          }, thumbnailImage),
          itemSpacer(),
          buildGroupItems(
              LangText(context: context).getLocal()!.product_videos_ucf,
              _buildDropDownField(
                  LangText(context: context).getLocal()!.video_provider_ucf,
                  (newValue) {
                selectedVideoType = newValue;
                setChange();
              }, selectedVideoType, videoType)),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context).getLocal()!.video_link_ucf,
              LangText(context: context).getLocal()!.video_link_ucf,
              videoLinkEditTextController),
          itemSpacer(height: 10),
          smallTextForMessage(
              LangText(context: context).getLocal()!.video_link_des),
          itemSpacer(),
          buildGroupItems(
              LangText(context: context).getLocal()!.pdf_description_ucf,
              chooseSingleFileField(
                  LangText(context: context).getLocal()!.pdf_specification_ucf,
                  "", (onChosenFile) {
                pdfDes = onChosenFile;
                setChange();
              }, pdfDes)),
          itemSpacer()
        ],
      ),
    );
  }

  Widget buildPriceNStock() {
    return buildTabViewItem(
      "",
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPriceEditTextField(
              LangText(context: context).getLocal()!.unit_price_ucf,
              "0",
              unitPriceEditTextController),
          itemSpacer(),
          buildGroupItems(
              LangText(context: context).getLocal()!.discount_date_range_ucf,
              Container(
                height: 45,
                width: mWidht,
                decoration: MDecoration.decoration1(),
                child: Buttons(
                  onPressed: () async {
                    dateTimeRange = await _buildPickDate();

                    _statAndEndTime = intl.DateFormat('d/MM/y')
                            .format(dateTimeRange!.start)
                            .toString() +
                        " - " +
                        intl.DateFormat('d/MM/y')
                            .format(dateTimeRange!.end)
                            .toString();
                    setChange();
                  },
                  child: Text(
                    _statAndEndTime,
                    style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                ),
              )),

          itemSpacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (mWidht / 2) - 20,
                child: buildEditTextField(
                    LangText(context: context).getLocal()!.discount_ucf,
                    "0",
                    productDiscountEditTextController,
                    isMandatory: true),
              ),
              Spacer(),
              SizedBox(
                width: (mWidht / 2) - 20,
                child: _buildDropDownField('', (onchange) {
                  selectedProductDiscountType = onchange;
                  setChange();
                }, selectedProductDiscountType, discountTypeList),
              ),
            ],
          ),

          if (productVariations.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                itemSpacer(),
                buildEditTextField(
                    LangText(context: context).getLocal()!.quantity_ucf,
                    "0",
                    productQuantityEditTextController,
                    isMandatory: true),
                itemSpacer(),
                buildEditTextField(
                    LangText(context: context).getLocal()!.sku_all_capital,
                    LangText(context: context).getLocal()!.sku_all_capital,
                    skuEditTextController),
              ],
            ),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context).getLocal()!.external_link_ucf,
              LangText(context: context).getLocal()!.external_link_ucf,
              externalLinkEditTextController),
          itemSpacer(height: 10),
          smallTextForMessage(LangText(context: context)
              .getLocal()!
              .leave_it_blank_if_you_do_not_use_external_site_link),
          itemSpacer(),
          buildEditTextField(
              LangText(context: context)
                  .getLocal()!
                  .external_link_button_text_ucf,
              LangText(context: context)
                  .getLocal()!
                  .external_link_button_text_ucf,
              externalLinkButtonTextEditTextController),
          itemSpacer(height: 10),
          smallTextForMessage(LangText(context: context)
              .getLocal()!
              .leave_it_blank_if_you_do_not_use_external_site_link),
          itemSpacer(),
          buildGroupItems(
              LangText(context: context)
                  .getLocal()!
                  .low_stock_quantity_warning_ucf,
              buildEditTextField(
                  LangText(context: context).getLocal()!.quantity_ucf,
                  "0",
                  lowStockQuantityTextEditTextController)),
          itemSpacer(),
          buildGroupItems(
            LangText(context: context).getLocal()!.stock_visibility_state_ucf,
            Column(
              children: List.generate(
                  stockVisibilityStateList.length,
                  (index) => buildSwitchField(
                          stockVisibilityStateList[index].title,
                          stockVisibilityStateList[index].isActive,
                          (changedValue) {
                        stockVisibilityStateList.forEach((element) {
                          if (element.key ==
                              stockVisibilityStateList[index].key) {
                            stockVisibilityStateList[index].isActive = true;
                          } else {
                            element.isActive = false;
                          }
                        });
                        selectedstockVisibilityState =
                            stockVisibilityStateList[index];
                        setChange();
                      })),
            ),
          ),
          itemSpacer(),
          buildGroupItems(
              LangText(context: context).getLocal()!.product_variation_ucf,
              SizedBox()),
          // if (false)
          Row(
            children: [
              buildFieldTitle(
                  LangText(context: context).getLocal()!.colors_ucf),
              Spacer(),
              Switch(
                  activeColor: MyTheme.green,
                  value: isColorActive,
                  onChanged: (onChanged) {
                    isColorActive = onChanged;
                    selectedColors.clear();
                    selectedColor = null;
                    createProductVariation();
                    setChange();
                  })
            ],
          ),
          if (isColorActive)
            Column(
              children: [
                _buildColorDropDown((value) {
                  selectedColor = value;
                  if (!selectedColors.contains(value)) {
                    selectedColors.add(value);
                  }
                  setChange();
                  createProductVariation();
                }, selectedColor, colorList),
                SizedBox(
                  height: 10,
                ),
                buildShowSelectedOptions(selectedColors, (index) {
                  selectedColors.removeAt(index);
                  setChange();
                  createProductVariation();
                })
              ],
            ),

          itemSpacer(),
          buildCommonSingleField(
              LangText(context: context).getLocal()!.attributes_ucf,
              Container(
                width: mWidht,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: MDecoration.decoration1(),
                child: DropdownButton<AttributesModel>(
                  isDense: true,
                  underline: Container(),
                  isExpanded: true,
                  onChanged: (AttributesModel? value) {
                    selectedAttribute = value;

                    var tmp = selectedAttributes.where(
                        (element) => element.name.key == value!.name.key);

                    if (tmp.isEmpty) {
                      selectedAttributes.add(AttributesModel(
                          value!.name, value.attributeItems, [], null));
                    }
                    createProductVariation();
                    setChange();
                  },
                  icon: const Icon(Icons.arrow_drop_down),
                  value: selectedAttribute,
                  items: attribute
                      .map(
                        (value) => DropdownMenuItem<AttributesModel>(
                          value: value,
                          child: Text(
                            value.name.value!,
                          ),
                        ),
                      )
                      .toList(),
                ),
              )),

          if (selectedAttributes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Column(
                children: List.generate(selectedAttributes.length, (index) {
                  return buildAttributeModelView(
                      index,
                      selectedAttributes[index].name.value,
                      selectedAttributes[index].attributeItems,
                      selectedAttributes[index].selectedAttributeItem,
                      (onchange) {
                    selectedAttributes[index].selectedAttributeItem = onchange;
                    if (!selectedAttributes[index]
                        .selectedAttributeItems
                        .contains(onchange)) {
                      selectedAttributes[index]
                          .selectedAttributeItems
                          .add(onchange);
                    }
                    setChange();
                    createProductVariation();
                  }, (removeIndex) {
                    selectedAttributes.removeAt(removeIndex);
                    setChange();
                    createProductVariation();
                  });
                }),
              ),
            ),

          itemSpacer(),

          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => variationViewModel(index),
              separatorBuilder: (context, index) => itemSpacer(),
              itemCount: productVariations.length),
          itemSpacer()
        ],
      ),
    );
  }

  Widget buildSEO() {
    return buildTabViewItem(
      LangText(context: context).getLocal()!.seo_all_capital,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildEditTextField(
            LangText(context: context).getLocal()!.meta_title_ucf,
            LangText(context: context).getLocal()!.meta_title_ucf,
            metaTitleEditTextController,
            isMandatory: false,
          ),
          itemSpacer(),
          buildGroupItems(
            LangText(context: context).getLocal()!.description_ucf,
            Container(
                padding: EdgeInsets.all(8),
                height: 150,
                width: mWidht,
                decoration: MDecoration.decoration1(),
                child: TextField(
                    controller: metaDescriptionEditTextController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 50,
                    enabled: true,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration.collapsed(
                        hintText: LangText(context: context)
                            .getLocal()!
                            .product_description_ucf))),
          ),
          itemSpacer(),
          chooseSingleImageField(
              LangText(context: context).getLocal()!.meta_image_ucf, "",
              (onChosenImage) {
            metaImage = onChosenImage;
            setChange();
          }, metaImage),
          itemSpacer(),
          buildEditTextField(
            LangText(context: context).getLocal()!.slug_ucf,
            LangText(context: context).getLocal()!.slug_ucf,
            slugEditTextController,
            isMandatory: false,
          ),
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
              LangText(context: context).getLocal()!.shipping_configuration_ucf,
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
                                    shippingConfigurationList
                                        .forEach((element) {
                                      if (element.key ==
                                          shippingConfigurationList[index]
                                              .key) {
                                        shippingConfigurationList[index]
                                            .isActive = true;
                                      } else {
                                        element.isActive = false;
                                      }
                                    });
                                    selectedShippingConfiguration =
                                        shippingConfigurationList[index];
                                    setChange();
                                    ////print(selectedShippingConfiguration.key);
                                  })),
                        ),
                        if (selectedShippingConfiguration.key == "flat_rate")
                          Row(
                            children: [
                              Text(LangText(context: context)
                                  .getLocal()!
                                  .shipping_cost_ucf),
                              Spacer(),
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
                              SizedBox(
                                width: 10,
                              )
                            ],
                          )
                      ],
                    )
                  : Container(
                      child: Text(
                        LangText(context: context)
                            .getLocal()!
                            .shipping_configuration_is_maintained_by_admin,
                        style: MyTextStyle.normalStyle(),
                      ),
                    ),
            ),
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
                LangText(context: context)
                    .getLocal()!
                    .estimate_shipping_time_ucf,
                buildGroupItems(
                  LangText(context: context).getLocal()!.shipping_days_ucf,
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
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              controller: shippingDayEditTextController,
                              style: TextStyle(
                                  fontSize: 12, color: MyTheme.font_grey),
                              decoration:
                                  InputDecoration.collapsed(hintText: "0"),
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              height: 46,
                              width: 80,
                              color: MyTheme.light_grey,
                              child: Text(
                                "Days",
                                style: TextStyle(
                                    fontSize: 12, color: MyTheme.grey_153),
                              )),
                        ],
                      )),
                )),
          ),
        )
      ],
    );
  }

/*
  Widget buildMarketing() {
    return Column(
      children: [
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
              LangText(context: context).getLocal().product_add_screen_featured,
              Container(
                child: Column(
                  children: [
                    buildSwitchField(
                        LangText(context: context)
                            .getLocal()
                            .product_add_screen_status,
                        isFeatured, (changedValue) {
                      isFeatured = changedValue;
                      setChange();
                    }),
                  ],
                ),
              ),
            ),
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
                LangText(context: context)
                    .getLocal()
                    .product_add_screen_todays_deal,
                Container(
                  child: Column(
                    children: [
                      buildSwitchField(
                          LangText(context: context)
                              .getLocal()
                              .product_add_screen_status,
                          isTodaysDeal, (changedValue) {
                        isTodaysDeal = changedValue;
                        setChange();
                      }),
                    ],
                  ),
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
              LangText(context: context)
                  .getLocal()
                  .product_add_screen_flash_deal,
              Column(
                children: [
                  _buildFlatDropDown(
                      LangText(context: context)
                          .getLocal()
                          .product_add_screen_add_to_flash, (onchange) {
                    selectedAddToFlashType = onchange;
                    setChange();
                  }, selectedAddToFlashType, addToFlashType),
                  itemSpacer(),
                  buildFlatEditTextField(
                      LangText(context: context)
                          .getLocal()
                          .product_add_screen_discount,
                      "0",
                      flashDiscountEditTextController),
                  itemSpacer(),
                  _buildFlatDropDown(
                      LangText(context: context)
                          .getLocal()
                          .product_add_screen_discount_type, (onchange) {
                    selectedFlashDiscountType = onchange;
                    setChange();
                  }, selectedFlashDiscountType, discountTypeList),
                  itemSpacer(),
                ],
              ),
            ),
          ),
        ),
        itemSpacer()
      ],
    );
  }*/

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
            Container(
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
        SizedBox(
          height: 10,
        ),
        buildShowSelectedOptions(
            selectedAttributes[index].selectedAttributeItems, (deleteIndex) {
          selectedAttributes[index]
              .selectedAttributeItems
              .removeAt(deleteIndex);
          setChange();
          createProductVariation();
        })
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

  Widget chooseGalleryImageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LangText(context: context).getLocal()!.gallery_images_600,
              style: TextStyle(
                  fontSize: 12,
                  color: MyTheme.font_grey,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
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
                          getLocal(context).choose_file,
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
                            getLocal(context).browse_ucf,
                            style: TextStyle(
                                fontSize: 12, color: MyTheme.grey_153),
                          )),
                    ],
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          LangText(context: context)
              .getLocal()!
              .these_images_are_visible_in_product_details_page_gallery_600,
          style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
        ),
        SizedBox(
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
                          ////print(index);
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
              style: TextStyle(
                  fontSize: 12,
                  color: MyTheme.font_grey,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
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
              style: TextStyle(
                  fontSize: 12,
                  color: MyTheme.font_grey,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
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
                          options[index].value!.toString(),
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
                        ))));
            ////print("chooseFile.url");
            ////print(chooseFile.first.url);
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
                    getLocal(context).choose_file,
                    style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 46,
                  width: 80,
                  color: MyTheme.light_grey,
                  child: Text(
                    getLocal(context).browse_ucf,
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
              SizedBox(
                height: 10,
              ),
              Text(
                shortMessage,
                style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
              ),
              SizedBox(
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
              SizedBox(
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
            List<FileInfo> chooseFile = await (Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadFile(
                  fileType: fileType,
                  canSelect: true,
                ),
              ),
            ));
            ////print("chooseFile.url");
            ////print(chooseFile.first.url);
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
                    getLocal(context).choose_file,
                    style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 46,
                  width: 80,
                  color: MyTheme.light_grey,
                  child: Text(
                    getLocal(context).browse_ucf,
                    style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        if (selectedFile != null)
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(3),
                height: 40,
                alignment: Alignment.center,
                width: 40,
                decoration: BoxDecoration(
                  color: MyTheme.grey_153,
                ),
                child: Text(
                  selectedFile.fileOriginalName! +
                      "." +
                      selectedFile.extension!,
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
          //child: summernote??Container(),
          child: FlutterSummernote(
              showBottomToolbar: false,
              returnContent: (text) {
                description = text;
                ////print(description);
              },
              hint: "",
              value: description,
              key: productDescriptionKey),
        ),
      ],
    );
    // FlutterSummernote(
    // hint: "Your text here...",
    // key: productDescriptionKey,
    // customToolbar: """
    //         [
    //             ['style', ['bold', 'italic', 'underline', 'clear']],
    //             ['font', ['strikethrough', 'superscript', 'subscript']]
    //         ]"""
    // )
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
    //print("object $categoryIds");
    return buildCommonSingleField(
        title,
        Container(
            height: 250,
            width: width ?? mWidht,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: MDecoration.decoration1(),
            child: SingleChildScrollView(
              child: isProductDetailsInit
                  ? MultiCategory(
                      isCategoryInit: isCategoryInit,
                      categories: categories,
                      onSelectedCategories: (categories) {
                        categoryIds = categories;
                      },
                      onSelectedMainCategory: (mainCategory) {
                        categoryId = mainCategory;
                      },
                      initialCategoryIds: categoryIds,
                      initialMainCategory: categoryId,
                    )
                  : SizedBox.shrink(),
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

  Widget _buildLanguageDropDown(
      dynamic onchange, Language? selectedValue, List<Language> itemList,
      {double? width}) {
    return Container(
      height: 46,
      width: DeviceInfo(context).getWidth() / 2.6,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //decoration: MDecoration,
      child: DropdownButton<Language>(
        menuMaxHeight: 300,
        isDense: true,
        underline: Container(),
        isExpanded: true,
        onChanged: (Language? value) {
          onchange(value);
        },
        icon: const Icon(Icons.arrow_drop_down),
        value: selectedValue,
        items: itemList
            .map(
              (value) => DropdownMenuItem<Language>(
                value: value,
                child: Row(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child:
                                /*Image.asset(
                          _list[index].image,
                          fit: BoxFit.fitWidth,
                        ),*/
                                FadeInImage.assetNetwork(
                              placeholder: 'assets/logo/placeholder.png',
                              image: value.image!,
                              fit: BoxFit.fitWidth,
                            ))),
                    Text(
                      value.name!,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildColorDropDown(dynamic onchange,
      CommonDropDownItem? selectedValue, List<CommonDropDownItem> itemList,
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
                      margin: EdgeInsets.symmetric(horizontal: 5),
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

  Widget buildTagsEditTextField(
      String title, String hint, TextEditingController textEditingController,
      {isMandatory = false}) {
    //textEditingController.buildTextSpan(context: context, withComposing: true);
    return buildCommonSingleField(
      title,
      Container(
        padding: EdgeInsets.only(top: 14, bottom: 10, left: 14, right: 14),
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
          children: List.generate(tags!.length + 1, (index) {
            if (index == tags!.length) {
              return TextField(
                onSubmitted: (string) {
                  var tag = textEditingController.text
                      .trim()
                      .replaceAll(",", "")
                      .toString();
                  addTag(tag);
                },
                onChanged: (string) {
                  if (string.trim().contains(",")) {
                    var tag = string.trim().replaceAll(",", "").toString();
                    addTag(tag);
                  }
                },
                controller: textEditingController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration.collapsed(
                        hintText: "Type and hit submit",
                        hintStyle: TextStyle(fontSize: 12))
                    .copyWith(constraints: BoxConstraints(maxWidth: 150)),
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
                          tags![index]!.toString(),
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
                ));
          }),
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

  Widget buildPriceEditTextField(
      String title, String hint, TextEditingController textEditingController,
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
            controller: textEditingController,
            onChanged: (string) {
              ////print(string);
              if (string.isEmpty) {
                textEditingController.text = "0";
              }
              createProductVariation();
            },
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

  variationViewModel(int index) {
    return buildExpansionTile(index, (onExpand) {
      productVariations[index].isExpended = onExpand;
      setChange();
    }, productVariations[index].isExpended);
  }

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
                          productVariations[index].name!,
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
                                    .getLocal()!
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
                                  .getLocal()!
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
                              LangText(context: context).getLocal()!.photo_ucf,
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

  Future<DateTimeRange?> _buildPickDate() async {
    DateTimeRange? p;
    p = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.utc(2050),
        builder: (context, child) {
          return Container(
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

  Widget buildTapBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildTopTapBarItem(
              LangText(context: context).getLocal()!.general_ucf, 0),
          tabBarDivider(),
          buildTopTapBarItem(
              LangText(context: context).getLocal()!.media_ucf, 1),
          tabBarDivider(),
          buildTopTapBarItem(
              LangText(context: context).getLocal()!.price_n_stock_ucf, 2),
          tabBarDivider(),
          buildTopTapBarItem(
              LangText(context: context).getLocal()!.seo_all_capital, 3),
          tabBarDivider(),
          buildTopTapBarItem(
              LangText(context: context).getLocal()!.shipping_ucf, 4),
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
            onPressed: () async {
              if (productDescriptionKey.currentState != null) {
                await productDescriptionKey.currentState!.getText();
                // productDescriptionKey.currentState.getText().then((value) {
                //   description = value;
                // });
              }
              _selectedTabIndex = index;
              setState(() {});
            },
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.white),
            )));
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
              padding: EdgeInsets.all(0.0),
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
          SizedBox(
            width: 10,
          ),
          Text(
            LangText(context: context).getLocal()!.update_product_ucf,
            style: MyTextStyle().appbarText(),
          ),
          Spacer(),
          SizedBox(
            width: DeviceInfo(context).getWidth() / 2.5,
            child: _buildLanguageDropDown((onchange) {
              selectedLanguage = onchange;
              setChange();
              getProductCurrentValues();
            }, selectedLanguage, languages,
                width: DeviceInfo(context).getWidth() / 2.5),
          )
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
  String? name;

  FileInfo? photo;
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

// class AttributeItemsModel {
//   List<CommonDropDownItem> attributeItems;
//   List<CommonDropDownItem> selectedAttributeItems;
//   CommonDropDownItem selectedAttributeItem;
//
//   AttributeItemsModel(this.attributeItems, this.selectedAttributeItems,
//       this.selectedAttributeItem);
// }

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
