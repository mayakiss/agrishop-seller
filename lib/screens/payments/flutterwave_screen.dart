import 'dart:convert';

import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/main_helper.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../custom/localization.dart';

class FlutterwaveScreen extends StatefulWidget {
  double amount;
  String payment_type;
  String? payment_method_key;
  String? package_id;

  FlutterwaveScreen(
      {Key? key,
      this.amount = 0.00,
      this.payment_type = "",
      this.payment_method_key = "",
      this.package_id})
      : super(key: key);

  @override
  _FlutterwaveScreenState createState() => _FlutterwaveScreenState();
}

class _FlutterwaveScreenState extends State<FlutterwaveScreen> {
  int _combined_order_id = 0;
  bool _order_init = false;
  String? _initial_url = "";
  bool _initial_url_fetched = false;

  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (page) {
            //print(page.toString());

            if (page.contains("/flutterwave/payment/callback")) {
              getData();
            }
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      );

    getSetInitialUrl();
  }

  getSetInitialUrl() async {
    var flutterwaveUrlResponse = await PaymentRepository()
        .getFlutterwaveUrlResponse(widget.payment_type, _combined_order_id,
            widget.package_id, widget.amount);

    if (flutterwaveUrlResponse.result == false) {
      ToastComponent.showDialog(flutterwaveUrlResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);
      Navigator.of(context).pop();
      return;
    }

    _initial_url = flutterwaveUrlResponse.url;
    _initial_url_fetched = true;

    _webViewController.loadRequest(Uri.parse(_initial_url!),
        headers: commonHeader);
    setState(() {});

    //print(_initial_url);
    //print(_initial_url_fetched);
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
    _webViewController
        .runJavaScriptReturningResult("document.body.innerText")
        .then((data) {
      var responseJSON = jsonDecode(data as String);
      if (responseJSON.runtimeType == String) {
        responseJSON = jsonDecode(responseJSON);
      }
      //print(data.toString());
      if (responseJSON["result"] == false) {
        ToastComponent.showDialog(responseJSON["message"],
            duration: Toast.lengthLong, gravity: Toast.center);
        Navigator.pop(context);
      } else if (responseJSON["result"] == true) {
        ToastComponent.showDialog(responseJSON["message"],
            duration: Toast.lengthLong, gravity: Toast.center);

        Navigator.pop(context);
      }
    });
  }

  buildBody() {
    if (_order_init == false &&
        _combined_order_id == 0 &&
        widget.payment_type == "cart_payment") {
      return Container(
        child: Center(
          child: Text(LangText(context: context).getLocal()!.creating_order),
        ),
      );
    } else if (_initial_url_fetched == false) {
      return Container(
        child: Center(
          child: Text(
              LangText(context: context).getLocal()!.fetching_flutterwave_url),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebViewWidget(
            controller: _webViewController,
          ),
        ),
      );
    }
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
        LangText(context: context).getLocal()!.pay_with_flutterwave,
        style: TextStyle(fontSize: 16, color: MyTheme.app_accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
