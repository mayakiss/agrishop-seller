import 'dart:convert';

import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/custom/input_decorations.dart';
import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:active_ecommerce_seller_app/custom/my_app_bar.dart';
import 'package:active_ecommerce_seller_app/custom/my_widget.dart';
import 'package:active_ecommerce_seller_app/custom/submitButton.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/main_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/shop_repository.dart';
import 'package:active_ecommerce_seller_app/screens/uploads/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_context/one_context.dart';
import 'package:toast/toast.dart';

import '../../data_model/uploaded_file_list_response.dart';

class ShopGeneralSetting extends StatefulWidget {
  const ShopGeneralSetting({Key? key}) : super(key: key);

  @override
  State<ShopGeneralSetting> createState() => _ShopGeneralSettingState();
}

class _ShopGeneralSettingState extends State<ShopGeneralSetting> {
  late BuildContext loadingContext;

  String? avatar_original = "";
  String? _imageId = "";
  List<String> _errors = [];

  bool _faceData = false;

  //for image uploading
  final ImagePicker _picker = ImagePicker();
  XFile? _file;

  TextEditingController nameEditingController = TextEditingController(text: "");
  TextEditingController addressEditingController =
      TextEditingController(text: "");
  TextEditingController titleEditingController =
      TextEditingController(text: "");
  TextEditingController phoneEditingController =
      TextEditingController(text: "");
  TextEditingController descriptionEditingController =
      TextEditingController(text: "");

  Future<bool> _getAccountInfo() async {
    var response = await ShopRepository().getShopInfo();
    Navigator.pop(loadingContext);
    avatar_original = response.shopInfo!.logo;
    nameEditingController.text = response.shopInfo!.name!;
    addressEditingController.text = response.shopInfo!.address!;
    titleEditingController.text = response.shopInfo!.title!;
    descriptionEditingController.text = response.shopInfo!.description!;
    phoneEditingController.text = response.shopInfo!.phone!;
    _imageId = response.shopInfo!.uploadId;
    _faceData = true;
    setState(() {});
    return true;
  }

  updateInfo() async {
    var postBody = jsonEncode({
      "name": nameEditingController.text.trim(),
      "address": addressEditingController.text.trim(),
      "phone": phoneEditingController.text.trim(),
      "meta_title": titleEditingController.text.trim(),
      "meta_description": descriptionEditingController.text.trim(),
      "logo": _imageId,
    });
    loadingShow(context);
    var response = await ShopRepository().updateShopSetting(postBody);
    Navigator.pop(loadingContext);

    if (response.result!) {
      ToastComponent.showDialog(response.message,
          bgColor: MyTheme.white,
          duration: Toast.lengthLong,
          gravity: Toast.center);
    } else {
      ToastComponent.showDialog(response.message,
          bgColor: MyTheme.white,
          duration: Toast.lengthLong,
          gravity: Toast.center);
    }
  }

  faceData() {
    WidgetsBinding.instance.addPostFrameCallback((_) => loadingShow(context));
    _getAccountInfo();
  }

  chooseAndUploadImage(context) async {
    List<FileInfo>? fileInfo = await Navigator.push<List<FileInfo>>(
        context,
        MaterialPageRoute(
            builder: (context) => const UploadFile(
                  fileType: "image",
                  canSelect: true,
                )));
    if (fileInfo != null && fileInfo.isNotEmpty) {
      _imageId = fileInfo.first.id.toString();
      avatar_original = fileInfo.first.url;
      setState(() {});
    }
  }

  formValidation() {
    _errors = [];
    if (nameEditingController.text.trim().isEmpty) {
      _errors.add(LangText(context: context).getLocal()!.shop_name_is_required);
    }
    if (phoneEditingController.text.trim().isEmpty) {
      _errors
          .add(LangText(context: context).getLocal()!.shop_phone_is_required);
    }
    if (addressEditingController.text.trim().isEmpty) {
      _errors
          .add(LangText(context: context).getLocal()!.shop_address_is_required);
    }
    if (titleEditingController.text.trim().isEmpty) {
      _errors
          .add(LangText(context: context).getLocal()!.shop_title_is_required);
    }
    if (descriptionEditingController.text.trim().isEmpty) {
      _errors.add(
          LangText(context: context).getLocal()!.shop_description_is_required);
    }
    if (_imageId!.isEmpty) {
      _errors.add(LangText(context: context).getLocal()!.shop_logo_is_required);
    }

    setState(() {});
  }

  Future<void> onRefresh() {
    faceData();
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void initState() {
    faceData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
              context: context,
              title: LangText(context: context).getLocal()!.general_setting_ucf)
          .show(),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                buildShopName(context),
                SizedBox(
                  height: 14,
                ),
                buildShopLogo(context),
                SizedBox(
                  height: 14,
                ),
                buildShopPhone(context),
                SizedBox(
                  height: 14,
                ),
                buildShopAddress(context),
                SizedBox(
                  height: 14,
                ),
                buildShopTitle(context),
                SizedBox(
                  height: 14,
                ),
                buildShopDes(context),
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
                  height: 20,
                ),
                SubmitBtn.show(
                    radius: 6,
                    elevation: 5,
                    alignment: Alignment.center,
                    width: DeviceInfo(context).getWidth(),
                    backgroundColor: MyTheme.app_accent_color,
                    height: 48,
                    padding: EdgeInsets.zero,
                    onTap: () {
                      formValidation();
                      if (_errors.isEmpty) {
                        updateInfo();
                      }
                    },
                    child: Text(
                      LangText(context: context).getLocal()!.save_ucf,
                      style: TextStyle(fontSize: 17, color: MyTheme.white),
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildShopDes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.shop_description,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MyWidget.customCardView(
          width: DeviceInfo(context).getWidth(),
          backgroundColor: MyTheme.white,
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          borderColor: MyTheme.noColor,
          borderRadius: 6,
          child: TextField(
            controller: descriptionEditingController,
            decoration: InputDecoration.collapsed(
                hintText: LangText(context: OneContext().context)
                    .getLocal()
                    .there_are_variations,
                hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 12)),
            maxLines: 6,
          ),
        ),
      ],
    );
  }

  Column buildShopTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.shop_title,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MyWidget.customCardView(
          height: 40,
          width: DeviceInfo(context).getWidth(),
          backgroundColor: MyTheme.white,
          borderRadius: 10,
          child: TextField(
            controller: titleEditingController,
            decoration: InputDecorations.buildInputDecoration_1(
                hint_text: LangText(context: OneContext().context)
                    .getLocal()
                    .demo_store_ucf,
                borderColor: MyTheme.noColor,
                hintTextColor: MyTheme.grey_153),
          ),
        ),
      ],
    );
  }

  Column buildShopPhone(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.shop_phone,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MyWidget.customCardView(
          elevation: 5,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          borderWidth: 0,
          backgroundColor: MyTheme.white,
          height: 40,
          width: DeviceInfo(context).getWidth(),
          borderColor: MyTheme.light_grey,
          borderRadius: 6,
          child: TextField(
            controller: phoneEditingController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration.collapsed(
                hintText: "01.....",
                hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 12)),
            maxLines: 6,
          ),
        ),
      ],
    );
  }

  Column buildShopAddress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.shop_address,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        MyWidget.customCardView(
          alignment: Alignment.center,
          backgroundColor: MyTheme.white,
          elevation: 5,
          height: 65,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          width: DeviceInfo(context).getWidth(),
          borderColor: MyTheme.light_grey,
          borderRadius: 6,
          child: TextField(
            controller: addressEditingController,
            decoration: InputDecoration.collapsed(
                hintText: LangText(context: OneContext().context)
                    .getLocal()
                    .demo_address,
                hintStyle: TextStyle(color: MyTheme.grey_153, fontSize: 12)),
            maxLines: 6,
          ),
        ),
      ],
    );
  }

  Column buildShopName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.shop_name_ucf,
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
          width: DeviceInfo(context).getWidth(),
          height: 45,
          borderRadius: 10,
          elevation: 5,
          child: TextField(
            controller: nameEditingController,
            decoration: InputDecorations.buildInputDecoration_1(
                hint_text: LangText(context: OneContext().context)
                    .getLocal()
                    .demo_store_ucf,
                borderColor: MyTheme.light_grey,
                hintTextColor: MyTheme.grey_153),
          ),
        ),
      ],
    );
  }

  Widget buildShopLogo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangText(context: context).getLocal()!.shop_logo_ucf,
          style: TextStyle(
              fontSize: 12,
              color: MyTheme.font_grey,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            chooseAndUploadImage(context);
          },
          child: MyWidget.customCardView(
              backgroundColor: MyTheme.white,
              width: DeviceInfo(context).getWidth(),
              height: 36,
              borderRadius: 6,
              elevation: 5,
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
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          color: MyTheme.light_grey,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(6),
                            topRight: Radius.circular(6),
                          )),
                      child: Text(
                        getLocal(context).browse_ucf,
                        style: TextStyle(fontSize: 12, color: MyTheme.grey_153),
                      )),
                ],
              )),
        ),
        SizedBox(
          height: 6,
        ),
        Visibility(
            visible: avatar_original!.isNotEmpty,
            child: MyWidget.customCardView(
              height: 120,
              width: 120,
              elevation: 5,
              backgroundColor: MyTheme.white,
              child: Stack(
                children: [
                  MyWidget.imageWithPlaceholder(
                      height: 120.0, width: 120.0, url: avatar_original),
                  Positioned(
                    child: InkWell(
                      onTap: () {
                        avatar_original = "";
                        _imageId = "";
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        size: 15,
                        color: MyTheme.red,
                      ),
                    ),
                    top: 0,
                    right: 5,
                  ),
                ],
              ),
            )),
      ],
    );
  }

  loadingShow(BuildContext myContext) {
    return showDialog(
        //barrierDismissible: false,
        context: myContext,
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
