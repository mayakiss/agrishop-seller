import 'package:active_ecommerce_seller_app/app_config.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/main_helper.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaystackScreen extends StatefulWidget {
  double amount;
  String payment_type;
  String? payment_method_key;
  String? package_id;

  PaystackScreen(
      {Key? key,
      this.amount = 0.00,
      this.payment_type = "",
      this.payment_method_key = "",
      this.package_id})
      : super(key: key);

  @override
  _PaystackScreenState createState() => _PaystackScreenState();
}

class _PaystackScreenState extends State<PaystackScreen> {
  int _combined_order_id = 0;
  bool _order_init = false;
  String initial_url = "";
  late WebViewController _webViewController;

  @override
  void initState() {
    initial_url =
        "${AppConfig.BASE_URL}/paystack/init?payment_type=${widget.payment_type}&combined_order_id=${_combined_order_id}&amount=${widget.amount}&user_id=${seller_id.$}&package_id=${widget.package_id}";

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (page) {
            getData();
          },
        ),
      )
      ..loadRequest(Uri.parse(initial_url), headers: commonHeader);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: buildBody(),
      ),
    );
  }

  void getData() {
    print('called.........');
    String? payment_details = '';
    _webViewController
        .runJavaScriptReturningResult("document.body.innerText")
        .then((data) {
      var responseJSON = jsonDecode(data as String);
      if (responseJSON.runtimeType == String) {
        responseJSON = jsonDecode(responseJSON);
      }
      //print(responseJSON.toString());
      if (responseJSON["result"] == false) {
        ToastComponent.showDialog(responseJSON["message"],
            duration: Toast.lengthLong, gravity: Toast.center);

        Navigator.pop(context);
      } else if (responseJSON["result"] == true) {
        print("a");
        payment_details = responseJSON['payment_details'];
        onPaymentSuccess(payment_details);
      }
    });
  }

  onPaymentSuccess(payment_details) async {
    var paystackPaymentSuccessResponse = await PaymentRepository()
        .getPaystackPaymentSuccessResponse(widget.payment_type, widget.amount,
            _combined_order_id, payment_details);

    ToastComponent.showDialog(paystackPaymentSuccessResponse.message!,
        duration: Toast.lengthLong, gravity: Toast.center);
    Navigator.pop(context);
  }

  buildBody() {
    return SizedBox.expand(
      child: Container(
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
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        AppLocalizations.of(context)!.pay_with_paystack,
        style: TextStyle(fontSize: 16, color: MyTheme.app_accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
