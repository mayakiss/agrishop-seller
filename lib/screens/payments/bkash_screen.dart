import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/main_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/payment_repository.dart';
import 'package:flutter/material.dart';

import 'package:toast/toast.dart';
import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BkashScreen extends StatefulWidget {
  double amount;
  String payment_type;
  String? payment_method_key;
  String? package_id;

  BkashScreen(
      {Key? key,
      this.amount = 0.00,
      this.payment_type = "",
      this.payment_method_key = "",
      this.package_id})
      : super(key: key);

  @override
  _BkashScreenState createState() => _BkashScreenState();
}

class _BkashScreenState extends State<BkashScreen> {
  int _combined_order_id = 0;
  bool _order_init = false;
  String? _initial_url = "";
  bool _initial_url_fetched = false;

  WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  String? _token = "";
  bool showLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webViewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String page) {
          if (page.contains("/bkash/api/success")) {
            getData();
          } else if (page.contains("/bkash/api/fail")) {
            ToastComponent.showDialog("Payment cancelled",
                gravity: Toast.center, duration: Toast.lengthLong);
            Navigator.of(context).pop();
            return;
          }
        },
        onWebResourceError: (WebResourceError error) {},
      ),
    );

    // on cart payment need proper order id
    getSetInitialUrl();
  }

  getSetInitialUrl() async {
    var bkashUrlResponse = await PaymentRepository().getBkashBeginResponse(
        widget.payment_type,
        _combined_order_id,
        widget.package_id,
        widget.amount);

    if (bkashUrlResponse.result == false) {
      ToastComponent.showDialog(bkashUrlResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);
      Navigator.of(context).pop();
      return;
    }
    _token = bkashUrlResponse.token;

    _initial_url = bkashUrlResponse.url;
    _initial_url_fetched = true;

    _webViewController.loadRequest(Uri.parse(_initial_url!),
        headers: commonHeader);
    setState(() {});

    // print(_initial_url);
    // print(_initial_url_fetched);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: buildBody(),
    );
  }

  buildBody() {
    if (_initial_url_fetched == false) {
      return Container(
        child: Center(
          child: Text(AppLocalizations.of(context)!.fetching_bkash_url),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: showLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 1,
                      height: 1,
                    ),
                    CircularProgressIndicator(
                      strokeWidth: 3,
                    )
                  ],
                )
              : WebViewWidget(
                  controller: _webViewController,
                ),
        ),
      );
    }
  }

  onPaymentSuccess(payment_details) async {
    showLoading = true;
    setState(() {});
    var bkashPaymentProcessResponse =
        await PaymentRepository().getBkashPaymentProcessResponse(
      amount: widget.amount,
      token: _token,
      payment_type: widget.payment_type,
      combined_order_id: _combined_order_id,
      package_id: widget.package_id,
      payment_id: payment_details['paymentID'],
    );
    ToastComponent.showDialog(bkashPaymentProcessResponse.message!,
        duration: Toast.lengthLong, gravity: Toast.center);
    Navigator.pop(context);
  }

  void getData() {
    String? payment_details = '';
    _webViewController
        .runJavaScriptReturningResult("document.body.innerText")
        .then((data) {
      var responseJSON = jsonDecode(data as String);
      if (responseJSON.runtimeType == String) {
        responseJSON = jsonDecode(responseJSON);
      }
      print(data);
      if (responseJSON["result"] == false) {
        Toast.show(responseJSON["message"],
            duration: Toast.lengthLong, gravity: Toast.center);
        Navigator.pop(context);
      } else if (responseJSON["result"] == true) {
        payment_details = responseJSON['payment_details'];
        onPaymentSuccess(responseJSON);
      }
    });
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
        AppLocalizations.of(context)!.pay_with_bkash,
        style: TextStyle(fontSize: 16, color: MyTheme.app_accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
