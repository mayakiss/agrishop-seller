import 'dart:convert';
import 'dart:io';

import 'package:active_ecommerce_seller_app/app_config.dart';
import 'package:active_ecommerce_seller_app/custom/buttons.dart';
import 'package:active_ecommerce_seller_app/custom/decorations.dart';
import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/custom/input_decorations.dart';
import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:active_ecommerce_seller_app/custom/my_widget.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/data_model/common_response.dart';
import 'package:active_ecommerce_seller_app/helpers/main_helper.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/shop_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  List<VerificationModel> formList = [];
  late BuildContext loadingContext;
  bool isFetchData = false;

  getFormData() async {
    var response = await ShopRepository.getFormDataRequest();

    for (int i = 0; i < response.length; i++) {
      if (response[i].type == "text") {
        TextEditingController value = TextEditingController();
        formList.add(VerificationModel<TextEditingController?>(
            key: "element_$i",
            type: response[i].type,
            title: response[i].label,
            data: value));
      } else if (response[i].type == "file") {
        File? value;
        formList.add(VerificationModel<File?>(
            key: "element_$i",
            type: response[i].type,
            title: response[i].label,
            data: value));
      } else if (response[i].type == "select") {
        String? value;
        var options = jsonDecode(response[i].options!);
        print(options);
        formList.add(VerificationModel<String?>(
            key: "element_$i",
            type: response[i].type,
            title: response[i].label,
            data: value,
            options: options));
      } else if (response[i].type == "multi_select") {
        List<String> value = [];
        var options = jsonDecode(response[i].options!);
        formList.add(VerificationModel<List<String>?>(
            key: "element_$i",
            type: response[i].type,
            title: response[i].label,
            data: value,
            options: options));
      } else if (response[i].type == "radio") {
        var options = jsonDecode(response[i].options!);

        String? value = options.first;
        formList.add(VerificationModel<String?>(
            key: "element_$i",
            type: response[i].type,
            title: response[i].label,
            data: value,
            options: options));
      }
    }
    isFetchData = true;
    setState(() {});
  }

  onVerify() async {
    Map<String, String> data = Map();

    Uri url =
    Uri.parse("${AppConfig.BASE_URL_WITH_PREFIX}/shop-verify-info-store");

    Map<String, String> header = {

      "App-Language": app_language.$!,
      "Authorization": "Bearer ${access_token.$}",
      "Content-Type":
      "multipart/form-data; boundary=<calculated when request is sent>",
      "Accept": "*/*",
      "System-Key": AppConfig.system_key
    };

    final httpReq = http.MultipartRequest("POST", url);
    httpReq.headers.addAll(header);

    for (VerificationModel element in formList) {
      if (element.type == "text") {
        if (element.data.text
            .trim()
            .toString()
            .isEmpty) {
          ToastComponent.showDialog("${element.title} is Empty");
          return;
        }
        data.addAll({element.key!: element.data.text.trim().toString()});
      } else if (element.type == "select") {
        if (element.data == null || element.data
            .toString()
            .isEmpty) {
          ToastComponent.showDialog("${element.title} is Empty");
          return;
        }
        data.addAll({element.key!: element.data.toString()});
      } else if (element.type == "multi_select") {
        if (element.data == null || element.data.isEmpty) {
          ToastComponent.showDialog("${element.title} is Empty");
          return;
        }
        data.addAll({element.key!: element.data.join(",").toString()});
      } else if (element.type == "radio") {
        if (element.data == null || element.data
            .toString()
            .isEmpty) {
          ToastComponent.showDialog("${element.title} is Empty");
          return;
        }
        data.addAll({element.key!: element.data.toString()});
      } else if (element.type == "file") {
        if (element.data == null || element.data
            .toString()
            .isEmpty) {
          ToastComponent.showDialog("${element.title} is Empty");
          return;
        }

        final image =
        await http.MultipartFile.fromPath(element.key!, element.data.path);

        httpReq.files.add(image);
      }
    }

    httpReq.fields.addAll(data as Map<String, String>);

    loading();

    var response = await httpReq.send();
    Navigator.pop(loadingContext);
    response.stream.bytesToString().then((value) {
      var res = commonResponseFromJson(value);
      ToastComponent.showDialog(res.message);
      if (res.result!) {
        Navigator.pop(context, true);
        verify_form_submitted.$ = true;
        verify_form_submitted.save();
      }
    });
  }

  @override
  void initState() {
    getFormData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: isFetchData
          ? ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          itemBuilder: (context, index) =>
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle(formList[index].title),
                    const SizedBox(
                      height: 10,
                    ),
                    if (formList[index].type == "text")
                      buildEditTextField(
                          formList[index].title, formList[index].data)
                    else
                      if (formList[index].type == "select")
                        buildDropDown(index,
                            formList[index] as VerificationModel<String?>)
                      else
                        if (formList[index].type == "multi_select")
                          buildMultiSelect(index)
                        else
                          if (formList[index].type == "file")
                            buildFile(index)
                          else
                            if (formList[index].type == "radio")
                              buildRadio(index),
                  ],
                ),
              ),
          separatorBuilder: (context, index) =>
          const SizedBox(
            height: 10,
          ),
          itemCount: formList.length)
          : const Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: Buttons(
        height: 50,
        shape: const RoundedRectangleBorder(),
        onPressed: () {
          onVerify();
        },
        color: MyTheme.app_accent_color,
        width: DeviceInfo(context).getWidth(),
        child: Text(
          LangText(context: context).getLocal()!.submit_ucf,
          style: TextStyle(fontSize: 14, color: MyTheme.white),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) =>
            IconButton(
              icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
      ),
      title: Text(
        LangText(context: context).getLocal()!.verification_form_ucf,
        style: TextStyle(fontSize: 16, color: MyTheme.app_accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  Widget buildEditTextField(String? hint,
      TextEditingController? textEditingController) {
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

  Text buildTitle(title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.font_grey),
    );
  }

  setChange() {
    setState(() {});
  }

  Widget buildDropDown(int index, VerificationModel<String?> model) {
    return Container(
      height: 46,
      width: DeviceInfo(context).getWidth(),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: MDecoration.decoration1(),
      child: DropdownButton<String>(
        menuMaxHeight: 300,
        isDense: true,
        underline: Container(),
        isExpanded: true,
        onChanged: (String? value) {
          formList[index].data = value;
          setChange();
        },
        icon: const Icon(Icons.arrow_drop_down),
        value: model.data,
        items: formList[index]
            .options!
            .map(
              (value) =>
              DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              ),
        )
            .toList(),
      ),
    );
  }

  Widget buildMultiSelect(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 46,
          width: DeviceInfo(context).getWidth(),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: MDecoration.decoration1(),
          child: DropdownButton<String>(
            menuMaxHeight: 300,
            isDense: true,
            underline: Container(),
            isExpanded: true,
            onChanged: (String? value) {
              if (!formList[index].data.contains(value)) {
                formList[index].data.add(value);
              }

              setChange();
            },
            icon: const Icon(Icons.arrow_drop_down),
            items: formList[index]
                .options!
                .map(
                  (value) =>
                  DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  ),
            )
                .toList(),
          ),
        ),
        Wrap(
          children: List.generate(
            formList[index].data.length,
                (subIndex) =>
                SizedBox(
                  width: 90,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 40,
                          child: Text(formList[index].data[subIndex])),
                      Buttons(
                        onPressed: () {
                          formList[index].data.removeAt(subIndex);
                          setState(() {});
                        },
                        width: 30,
                        height: 30,
                        child: const Icon(
                          Icons.close,
                          size: 15,
                        ),
                      )
                    ],
                  ),
                ),
          ),
        )
      ],
    );
  }

  Widget buildFile(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Buttons(
          padding: EdgeInsets.zero,
          onPressed: () async {
            FilePickerResult? file = await pickSingleFile();
            if (file == null) {
              ToastComponent.showDialog(
                  LangText(context: context).getLocal()!.no_file_is_chosen,
                  gravity: Toast.center,
                  duration: Toast.lengthLong);
              return;
            }
            formList[index].data = File(file.paths.first!);
            setState(() {});
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
                      )),
                ],
              )),
        ),
        SizedBox(
          height: 8,
        ),
        formList[index].data != null
            ? Image.file(
          formList[index].data,
          height: 100,
          width: 100,
        )
            : const SizedBox.shrink(),
      ],
    );
  }

  Future<FilePickerResult?> pickSingleFile() async {
    return await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      "jpg",
      "jpeg",
      "png",
      "svg",
      "webp",
      "gif",
      "mp4",
      "mpg",
      "mpeg",
      "webm",
      "ogg",
      "avi",
      "mov",
      "flv",
      "swf",
      "mkv",
      "wmv",
      "wma",
      "aac",
      "wav",
      "mp3",
      "zip",
      "rar",
      "7z",
      "doc",
      "txt",
      "docx",
      "pdf",
      "csv",
      "xml",
      "ods",
      "xlr",
      "xls",
      "xlsx"
    ]);
  }

  Widget radio(index, subIndex) {
    return Radio<String>(
      value: formList[index].options![subIndex],
      groupValue: formList[index].data,
      onChanged: (String? value) {
        formList[index].data = value;
        setState(() {});
      },
    );
  }

  buildRadio(index) {
    return Column(
      children: List.generate(
          formList[index].options!.length,
              (subIndex) =>
              Row(
                children: [
                  radio(index, subIndex),
                  Text(
                    formList[index].options![subIndex],
                    style:
                    const TextStyle(fontSize: 14, color: MyTheme.font_grey),
                  )
                ],
              )),
    );
  }

  loading() {
    return showDialog(
        context: context,
        builder: (context) {
          loadingContext = context;
          return AlertDialog(
              content: Row(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(LangText(context: context).getLocal()!.please_wait_ucf),
                ],
              ));
        });
  }
}

class VerificationModel<T> {
  String? key, type, title;
  T data;
  List<dynamic>? options;

  VerificationModel({required this.key,
    required this.type,
    required this.title,
    required this.data,
    this.options});
}
