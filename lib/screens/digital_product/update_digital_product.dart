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
import 'package:active_ecommerce_seller_app/data_model/product/category_response_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/category_view_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/custom_radio_model.dart';
import 'package:active_ecommerce_seller_app/data_model/product/product_edit_response.dart';
import 'package:active_ecommerce_seller_app/data_model/product/vat_tax_model.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/language_repository.dart';
import 'package:active_ecommerce_seller_app/repositories/product_repository.dart';
import 'package:active_ecommerce_seller_app/screens/uploads/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:one_context/one_context.dart';
import 'package:toast/toast.dart';

import '../../data_model/digital_product_edit_response.dart';
import '../../data_model/uploaded_file_list_response.dart';
import '../../repositories/digital_product_repository.dart';

class UpdateDigitalProduct extends StatefulWidget {
  final productId;

  UpdateDigitalProduct({Key? key, this.productId}) : super(key: key);

  @override
  State<UpdateDigitalProduct> createState() => _UpdateDigitalProductState();
}

class _UpdateDigitalProductState extends State<UpdateDigitalProduct> {
  // double variables

  String _statAndEndTime = "Select Date";
  double mHeight = 0.0, mWidht = 0.0;
  int _selectedTabIndex = 0;

  bool isFeatured = false;
  bool isTodaysDeal = false;

  bool isCategoryInit = false;
  List<CategoryModel> categories = [];
  List<Language> languages = [];
  List<VatTaxViewModel> vatTaxList = [];
  List<CommonDropDownItem> discountTypeList = [];

  late CustomRadioModel selectedShippingConfiguration;
  late CustomRadioModel selectedstockVisibilityState;

  CommonDropDownItem? selectedBrand;
  Language? selectedLanguage;

  CommonDropDownItem? selectedAddToFlashType;
  CommonDropDownItem? selectedFlashDiscountType;
  CommonDropDownItem? selectedProductDiscountType;
  FlutterSummernote? summernote;

  //Product value

  List<String> tmpColorList = [];
  List<ChoiceOption> tmpAttribute = [];
  String? tmpBrand = "";

  bool isProductDetailsInit = false;
  List categoryIds = [];
  String? productName,
      categoryId,
      photos,
      thumbnailImg,
      unitPrice,
      purchasePrice,
      discount,
      dateRange,
      discountType,
      description,
      pf,
      metaTitle,
      slug,
      metaDescription,
      metaImg;
  String? lang = "en";
  var tagMap = [];
  List<String?>? tags = [],
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
  FileInfo? productFile;
  DateTimeRange? dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  //Edit text controller
  TextEditingController productNameEditTextController = TextEditingController();
  TextEditingController minimumEditTextController =
      TextEditingController(text: "1");
  TextEditingController tagEditTextController = TextEditingController();
  TextEditingController taxEditTextController = TextEditingController();
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
  TextEditingController purchasePriceTextController =
      TextEditingController(text: '0');
  TextEditingController flatShippingCostTextEditTextController =
      TextEditingController();

  GlobalKey<FlutterSummernoteState> productDescriptionKey = GlobalKey();

  getCategories() async {
    var categoryResponse = await DigitalProductRepository().getCategoryRes();

    categoryResponse!.data!.forEach((element) {
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

  setConstDropdownValues() {
    discountTypeList.clear();
    discountTypeList.addAll([
      CommonDropDownItem("amount", "Flat"),
      CommonDropDownItem("percent", "Percent"),
    ]);
    selectedProductDiscountType = discountTypeList.first;
    selectedFlashDiscountType = discountTypeList.first;
    // selectedCategory = categories.first;

    setState(() {});
  }

  getTaxType(DigitalProductInfo productInfo) async {
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
    List<FileInfo>? tmp;
    tmp = productGalleryImages;
    List<FileInfo> images = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadFile(
          fileType: "image",
          canSelect: true,
          canMultiSelect: true,
          prevData: tmp,
        ),
      ),
    );
    // //print(images != null);
    if (images != null) {
      productGalleryImages = images;
      setChange();
    }
  }

  setProductPhotoValue() {
    photos = "";
    for (int i = 0; i < productGalleryImages!.length; i++) {
      if (i != (productGalleryImages!.length - 1)) {
        photos = "$photos " + "${productGalleryImages![i].id},";
      } else {
        photos = "$photos " + "${productGalleryImages![i].id}";
      }
    }
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

  /// set product value is-> when user put value in the text field
  /// it will take value from controller and set it.
  /// then it goes to submit

  setProductValues() async {
    productName = productNameEditTextController.text.trim();

    unitPrice = unitPriceEditTextController.text.trim().toString();
    purchasePrice = purchasePriceTextController.text.trim().toString();
    dateRange = "${dateTimeRange!.start} to ${dateTimeRange!.end}";
    tagMap.clear();
    tags!.forEach((element) {
      tagMap.add(jsonEncode({"value": '$element'}));
    });
    // add product photo
    setProductPhotoValue();
    if (thumbnailImage != null) thumbnailImg = "${thumbnailImage!.id}";

    //Set colors

    if (productFile != null) pf = "${productFile!.id}";
    discount = productDiscountEditTextController.text.trim().toString();
    discountType = selectedProductDiscountType!.key;

    if (productDescriptionKey.currentState != null) {
      description = await productDescriptionKey.currentState!.getText() ?? "";
      description = await productDescriptionKey.currentState!.getText() ?? "";
    }

    metaTitle = metaTitleEditTextController.text.trim().toString();
    slug = slugEditTextController.text.trim().toString();

    metaDescription = metaDescriptionEditTextController.text.trim().toString();
    if (metaImage != null) metaImg = "${metaImage!.id}";

    setTaxes();
  }

  bool requiredFieldVerification() {
    if (productNameEditTextController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog("Product Name Required", gravity: Toast.center);
      return false;
    } else if (unitPriceEditTextController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog("Product Unit Price Required",
          gravity: Toast.center);
      return false;
    } else if (purchasePriceTextController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog("Product Purchase Price Required",
          gravity: Toast.center);
      return false;
    } else if (productDiscountEditTextController.text
        .trim()
        .toString()
        .isEmpty) {
      ToastComponent.showDialog("Product Discount Required",
          gravity: Toast.center);
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

    Map postValue = Map();
    postValue.addAll({
      "added_by": "seller",
      "digital": 1,
      "name": productName,
      "category_id": categoryId,
      "category_ids": categoryIds,
      "tags": [tagMap.toString()],
      "photos": photos,
      "thumbnail_img": thumbnailImg,
    });

    postValue.addAll(choice_options);

    postValue.addAll({
      "unit_price": unitPrice,
      "purchase_price": purchasePrice,
      "date_range": int.parse(discount!) <= 0 ? null : dateRange,
      "discount": discount,
      "discount_type": discountType,
    });

    postValue.addAll({
      "description": description,
      "file_name": pf,
      "meta_title": metaTitle,
      "meta_description": metaDescription,
      "meta_img": metaImg,
      "slug": slug,
      "tax_id": taxId,
      "tax": tax,
      "tax_type": taxType,
    });

    var postBody = jsonEncode(postValue);
    print(postBody);

    var response = await DigitalProductRepository()
        .updateDigitalProduct(postBody, widget.productId, lang);
    isProductDetailsInit = true;
    Loading().hide();
    if (response.result!) {
      ToastComponent.showDialog(response.message, gravity: Toast.center);

      Navigator.pop(context);
    } else {
      List errorMessages = response.message;
      ToastComponent.showDialog(errorMessages.join(","), gravity: Toast.center);
    }
  }

  setInitialValue(DigitalProductInfo productInfo) {
    selectedLanguage =
        languages.where((element) => element.code == productInfo.lang).first;
    setConstDropdownValues();

    // GENERAL

    productNameEditTextController.text = productInfo.productName!;
    tmpAttribute.clear();

    categoryId = productInfo.categoryId?.toString();
    categoryIds.addAll(productInfo.categoryIds!);
    print(categoryIds);
    getCategories();

    if (productInfo.productFile!.data!.isNotEmpty) {
      productFile = productInfo.productFile!.data!.first;
    }
    tags!.clear();
    if (productInfo.tags!.isNotEmpty) {
      tags!.addAll(productInfo.tags!.split(","));
    }
    description = productInfo.description;
    getTaxType(productInfo);

    discountTypeList.forEach((element) {
      if (productInfo.discountType == element.key) {
        selectedProductDiscountType = element;
      }
    });

    if (productInfo.photos!.data!.isNotEmpty) {
      productGalleryImages!
          .addAll(productInfo.photos!.data! as Iterable<FileInfo>);
    }
    if (productInfo.thumbnailImg!.data!.isNotEmpty) {
      thumbnailImage = productInfo.thumbnailImg!.data!.first as FileInfo?;
    }

    // PRICE AND STOCK

    unitPriceEditTextController.text = productInfo.unitPrice?.toString() ?? "";
    purchasePriceTextController.text =
        productInfo.purchasePrice?.toString() ?? "";
    var start = DateTime.tryParse(productInfo.discountStartDate.toString())!;
    var end = DateTime.tryParse(productInfo.discountEndDate.toString())!;
    // print(start);
    // print(end);
    dateTimeRange = DateTimeRange(start: start, end: end);

    _statAndEndTime =
        intl.DateFormat('d/MM/y').format(dateTimeRange!.start).toString() +
            " - " +
            intl.DateFormat('d/MM/y').format(dateTimeRange!.end).toString();
    productDiscountEditTextController.text = productInfo.discount!.toString();

    // S E O

    metaTitleEditTextController.text = productInfo.metaTitle!;
    metaDescriptionEditTextController.text = productInfo.metaDescription!;
    if (productInfo.metaImg!.data!.isNotEmpty) {
      metaImage = productInfo.metaImg!.data!.first;
    }
    slugEditTextController.text = productInfo.slug!;

    productDescriptionKey.currentState!.setText(description ?? "");

    setChange();
  }

  getProductCurrentValues() async {
    if (selectedLanguage != null) {
      lang = selectedLanguage!.code;
    }

    await Future.delayed(Duration.zero);
    Loading.setInstance(context);
    Loading().show();

    var productResponse = await DigitalProductRepository()
        .editDigitalProduct(id: widget.productId, lang: lang);

    isProductDetailsInit = true;
    Loading().hide();

    if (productResponse.result!) {
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
          ),
        ),
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
        return buildPriceNStock();
        break;
      case 3:
        return buildSEO();
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
          buildGroupItems(
              '',
              chooseSingleFileField(
                  LangText(context: context).getLocal()!.product_file_ucf, "",
                  (onChosenFile) {
                productFile = onChosenFile;
                setChange();
              }, productFile)),
          itemSpacer(),
          buildTagsEditTextField(
              LangText(context: context).getLocal()!.tags_ucf,
              LangText(context: context)
                  .getLocal()!
                  .type_and_hit_enter_to_add_a_tag_ucf,
              tagEditTextController,
              isMandatory: true),
          itemSpacer(),
          buildGroupItems(
              LangText(context: context).getLocal()!.product_description_ucf,
              summerNote(
                  LangText(context: context).getLocal()!.description_ucf)),
          itemSpacer(),
          buildGroupItems(
            LangText(context: context).getLocal()!.vat_n_tax_ucf,
            Column(
              children: List.generate(
                vatTaxList.length,
                (index) {
                  return buildVatTax(vatTaxList[index].vatTaxModel.name,
                      vatTaxList[index].amount, (onChangeDropDown) {
                    vatTaxList[index].selectedItem = onChangeDropDown;
                  }, vatTaxList[index].selectedItem, vatTaxList[index].items);
                },
              ),
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
            unitPriceEditTextController,
            isMandatory: true,
          ),
          itemSpacer(),
          buildPriceEditTextField(
            LangText(context: context).getLocal()!.purchase_price_ucf,
            "0",
            purchasePriceTextController,
            isMandatory: true,
          ),
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

                    _statAndEndTime = intl.DateFormat('MM/d/y')
                            .format(dateTimeRange!.start)
                            .toString() +
                        " - " +
                        intl.DateFormat('MM/d/y')
                            .format(dateTimeRange!.end)
                            .toString();
                    setChange();
                  },
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    _statAndEndTime,
                    style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                  ),
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

  Widget chooseGalleryImageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LangText(context: context).getLocal()!.gallery_images_600,
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
                          LangText(context: OneContext().context)
                              .getLocal()
                              .choose_file,
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
                            LangText(context: OneContext().context)
                                .getLocal()
                                .browse_ucf,
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
              .getLocal()!
              .these_images_are_visible_in_product_details_page_gallery_600,
          style: TextStyle(fontSize: 8, color: MyTheme.grey_153),
        ),
        const SizedBox(
          height: 10,
        ),
        if (productGalleryImages!.isNotEmpty)
          Wrap(
            children: List.generate(
              productGalleryImages!.length,
              (index) => Stack(
                children: [
                  MyWidget.imageWithPlaceholder(
                      height: 60.0,
                      width: 60.0,
                      url: productGalleryImages![index].url),
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
                          //print(index);
                          productGalleryImages!.removeAt(index);
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
                        maxWidth: (DeviceInfo(context).getWidth() - 50) / 4),
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
            ),
          ),
        ),
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
            //print("chooseFile.url");
            //print(chooseFile.first.url);
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
                    LangText(context: OneContext().context)
                        .getLocal()
                        .choose_file,
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
            print('choose file eeeeeeeeeeeeeeeeeeeeeeeeee');

            List<FileInfo> chooseFile = await (Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadFile(
                  fileType: fileType,
                  canSelect: true,
                ),
              ),
            ));
            print('choose file');
            //print("chooseFile.url");
            //print(chooseFile.first.url);
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
                    LangText(context: OneContext().context)
                        .getLocal()
                        .choose_file,
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
        SizedBox(
          height: 250,
          width: mWidht,
          //child: summernote??Container(),
          child: FlutterSummernote(
              showBottomToolbar: false,
              returnContent: (text) {
                description = text;
                //print(description);
              },
              hint: "",
              value: description,
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
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration.collapsed(
                          hintText: LangText(context: OneContext().context)
                              .getLocal()
                              .type_hit_submit,
                          hintStyle: TextStyle(fontSize: 12))
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
                          maxWidth: (DeviceInfo(context).getWidth() - 50) / 4),
                      child: Text(
                        tags![index]!.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
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
              //print(string);
              if (string.isEmpty) {
                textEditingController.text = "0";
              }
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

  // Widget buildPurchasePriceEditTextField(String title, String hint, TextEditingController purchasePriceController,
  //     {isMandatory = false}) {
  //   return Container(
  //     child: buildCommonSingleField(
  //       title,
  //       MyWidget.customCardView(
  //         backgroundColor: MyTheme.white,
  //         elevation: 5,
  //         width: DeviceInfo(context).getWidth(),
  //         height: 46,
  //         borderRadius: 10,
  //         child: TextField(
  //           controller: purchasePriceController,
  //           keyboardType: TextInputType.number,
  //           decoration: InputDecorations.buildInputDecoration_1(
  //               hint_text: hint,
  //               borderColor: MyTheme.noColor,
  //               hintTextColor: MyTheme.grey_153),
  //         ),
  //       ),
  //       isMandatory: isMandatory,
  //     ),
  //   );
  // }

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
        SizedBox(
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
              saveText: "Select",
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
          SizedBox(
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
            LangText(context: context).getLocal()!.update_product_ucf,
            style: MyTextStyle().appbarText(),
          ),
          const Spacer(),
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
