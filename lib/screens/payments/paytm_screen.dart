import 'package:active_ecommerce_seller_app/app_config.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/main_helper.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaytmScreen extends StatefulWidget {
  double amount;
  String payment_type;
  String? payment_method_key;
  String? package_id;

  PaytmScreen({Key? key,
    this.amount = 0.00,
    this.payment_type = "",
    this.payment_method_key = "", this.package_id})
      : super(key: key);

  @override
  _PaytmScreenState createState() => _PaytmScreenState();
}

class _PaytmScreenState extends State<PaytmScreen> {
  int _combined_order_id = 0;
  bool _order_init = false;
  String initial_url = "";
  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial_url =
    "${AppConfig.BASE_URL}/paytm/payment/pay?payment_type=${widget
        .payment_type}&combined_order_id=${_combined_order_id}&amount=${widget
        .amount}&user_id=${seller_id.$}&package_id=${widget.package_id}";

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (page) {
            //print(page.toString());

            if (page.contains("/paytm/payment/callback")) {
              getData();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(initial_url), headers: commonHeader);
    checkPhoneAvailability().then((val) {});
  }

  checkPhoneAvailability() async {
    var phoneEmailAvailabilityResponse =
    await ProfileRepository().getPhoneEmailAvailabilityResponse();
    print(phoneEmailAvailabilityResponse.toString());
    if (phoneEmailAvailabilityResponse.phone_available == false) {
      ToastComponent.showDialog(
          phoneEmailAvailabilityResponse.phone_available_message!,
          gravity: Toast.center, duration: Toast.lengthLong);
      Navigator.of(context).pop();
      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$! ? TextDirection.rtl : TextDirection
          .ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: buildBody(),
      ),
    );
  }

  void getData() {
    _webViewController
        .runJavaScriptReturningResult("document.body.innerText")
        .then((data) {
      var responseJSON = jsonDecode(data as String);
      if (responseJSON.runtimeType == String) {
        responseJSON = jsonDecode(responseJSON);
      }
      //print(data.toString());
      ToastComponent.showDialog(responseJSON["message"],
          duration: Toast.lengthLong, gravity: Toast.center);
      Navigator.pop(context);
    });
  }

  buildBody() {
    print(initial_url);

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: WebViewWidget(
          controller: _webViewController,
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
        AppLocalizations.of(context)!.pay_with_paytm,
        style: TextStyle(fontSize: 16, color: MyTheme.app_accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
