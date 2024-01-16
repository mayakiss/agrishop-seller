import 'dart:convert';

import 'package:active_ecommerce_seller_app/data_model/product_query_reply_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import '../../custom/common_style.dart';
import '../../custom/decorations.dart';
import '../../custom/loading.dart';
import '../../custom/localization.dart';
import '../../custom/my_app_bar.dart';
import '../../custom/my_widget.dart';
import '../../custom/toast_component.dart';
import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import '../../repositories/product_query_repository.dart';

class ProductQueryReply extends StatefulWidget {
  int? id;

  ProductQueryReply({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<ProductQueryReply> createState() => _ProductQueryReplyState();
}

class _ProductQueryReplyState extends State<ProductQueryReply> {
  TextEditingController replyEditTextController = TextEditingController();
  ProductQueryRepository repository = ProductQueryRepository();
  late ProductQueryDetailModel _productQueriesReply;
  bool _isFetchAllData = false;
  String? reply;
  int? conversationId;

  bool requiredFieldVerification() {
    if (replyEditTextController.text.trim().toString().isEmpty) {
      ToastComponent.showDialog("Product Reply Required",
          gravity: Toast.center);
      return false;
    }
    return true;
  }

  setProductReplyValues() async {
    reply = replyEditTextController.text.trim();
    conversationId = widget.id!;
  }

  _submitReply() async {
    if (!requiredFieldVerification()) {
      return;
    }
    Loading.setInstance(context);
    Loading().show();
    await setProductReplyValues();
    Map postValue = {};
    postValue.addAll({
      "conversation_id": conversationId,
      "reply": reply,
    });

    var postBody = jsonEncode(postValue);
    var response =
        await repository.addProductQueryReplyResponse(postBody, widget.id);

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

  setInitialValue() {
    replyEditTextController.text = _productQueriesReply.reply!.toString();
  }

  // get product queries list method
  Future<bool> getProductQueryDetails() async {
    var response = await repository.getProductQueryDetails(widget.id!);
    _productQueriesReply = response.data!;

    setState(() {});
    return true;
  }

  // fetch method
  Future<bool> fetchData() async {
    await getProductQueryDetails().then((value) => setInitialValue());

    _isFetchAllData = true;
    setState(() {});
    return true;
  }

  //init method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
              title: AppLocalizations.of(context)!.product_queries_reply_ucf,
              context: context)
          .show(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: _isFetchAllData
                  ? productQueriesContainer(
                      productName: _productQueriesReply.product,
                      imageUrl: _productQueriesReply.userImage,
                      question: _productQueriesReply.question,
                      userName: _productQueriesReply.userName,
                      timePeriod: _productQueriesReply.createdAt,
                      reply: _productQueriesReply.reply,
                    )
                  : ShimmerHelper().buildProductReplyShimmer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget productQueriesContainer(
      {productName, imageUrl, question, userName, timePeriod, reply}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProductName(productName),
          itemSpacer(),
          buildNameImage(imageUrl, userName, timePeriod),
          itemSpacer(),
          buildQuestion(question),
          buildReplyBox(),
          itemSpacer(height: 10),
          buildSubmitButton()
        ],
      ),
    );
  }

  Widget buildProductName(productName) {
    return Text(
      "$productName",
      style: MyTextStyle().appbarText(),
    );
  }

  Widget buildNameImage(imageUrl, userName, timePeriod) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imageUrl != null && imageUrl.isNotEmpty
            ? MyWidget.roundImageWithPlaceholder(
                width: 40.0,
                height: 40.0,
                borderRadius: 32.0,
                url: imageUrl,
                backgroundColor: MyTheme.noColor,
                fit: BoxFit.fill)
            : Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  image: const DecorationImage(
                      image: AssetImage("assets/logo/placeholder.png"),
                      fit: BoxFit.cover),
                ),
              ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName!, style: MyTextStyle.normalStyle()),
            const SizedBox(
              height: 4,
            ),
            Text(timePeriod!, style: MyTextStyle.smallFontSize()),
          ],
        )
      ],
    );
  }

  Widget buildQuestion(question) =>
      Text(question, style: MyTextStyle.normalStyle());

  Widget buildReplyBox() {
    return buildGroupItems(
      Container(
        padding: const EdgeInsets.all(8),
        height: 150,
        width: double.infinity,
        decoration: MDecoration.decoration1(),
        child: TextField(
          controller: replyEditTextController,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 50,
          enabled: true,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration.collapsed(
              hintText:
                  LangText(context: context).getLocal()!.type_your_reply_ucf),
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(30, 30),
            backgroundColor: MyTheme.app_accent_color,
            padding: const EdgeInsets.all(8),
            elevation: 0.0,
            primary: Colors.white,
            textStyle: const TextStyle(color: Colors.white),
          ),
          onPressed: _submitReply,
          child: Text(
            replyEditTextController.text.isNotEmpty
                ? AppLocalizations.of(context)!.update_ucf
                : AppLocalizations.of(context)!.submit_ucf,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buildGroupItems(Widget children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        itemSpacer(height: 14.0),
        children,
      ],
    );
  }

  Widget buildGroupTitle(title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: MyTheme.font_grey),
    );
  }

  Widget itemSpacer({double height = 24}) {
    return SizedBox(
      height: height,
    );
  }
}
