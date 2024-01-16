import 'package:active_ecommerce_seller_app/app_config.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/main_helper.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StripeScreen extends StatefulWidget {
  double amount;
  String payment_type;
  String? payment_method_key;
  String? package_id;

  StripeScreen(
      {Key? key,
      this.amount = 0.00,
      this.payment_type = "",
      this.payment_method_key = "",
      this.package_id})
      : super(key: key);

  @override
  _StripeScreenState createState() => _StripeScreenState();
}

class _StripeScreenState extends State<StripeScreen> {
  int _combined_order_id = 0;
  bool _order_init = false;
  String initial_url = "";
  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial_url =
        "${AppConfig.BASE_URL}/stripe?payment_type=${widget.payment_type}&combined_order_id=${_combined_order_id}&amount=${widget.amount}&user_id=${seller_id.$}&package_id=${widget.package_id}";

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (page) {
            //print(page.toString());

            if (page.contains("/stripe/success")) {
              getData();
            } else if (page.contains("/stripe/cancel")) {
              ToastComponent.showDialog(
                  AppLocalizations.of(context)!.payment_cancelled_ucf,
                  gravity: Toast.center,
                  duration: Toast.lengthLong);
              Navigator.of(context).pop();
              return;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(initial_url), headers: commonHeader);
  }

  // createOrder() async {
  //   var orderCreateResponse = await PaymentRepository()
  //       .getOrderCreateResponse(widget.payment_method_key);
  //
  //   if (orderCreateResponse.result == false) {
  //     ToastComponent.showDialog(orderCreateResponse.message, context,
  //         gravity: Toast.center, duration: Toast.lengthLong);
  //     Navigator.of(context).pop();
  //     return;
  //   }
  //
  //   _combined_order_id = orderCreateResponse.combined_order_id;
  //   _order_init = true;
  //   setState(() {});
  // }

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
      ToastComponent.showDialog(responseJSON["message"],
          duration: Toast.lengthLong, gravity: Toast.center);
      Navigator.pop(context);
    });
  }

  buildBody() {
    //print("init url");
    //print(initial_url);

    if (_order_init == false &&
        _combined_order_id == 0 &&
        widget.payment_type == "cart_payment") {
      return Container(
        child: Center(
          child: Text(AppLocalizations.of(context)!.date_ucf),
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
        AppLocalizations.of(context)!.pay_with_stripe,
        style: TextStyle(fontSize: 16, color: MyTheme.app_accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
