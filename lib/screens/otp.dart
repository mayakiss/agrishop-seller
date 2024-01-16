import 'package:active_ecommerce_seller_app/custom/buttons.dart';
import 'package:active_ecommerce_seller_app/custom/input_decorations.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/middlewares/mail_verification_route_middleware.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/auth_repository.dart';
import 'package:active_ecommerce_seller_app/screens/login.dart';
import 'package:active_ecommerce_seller_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../helpers/aiz_route.dart';

class Otp extends StatefulWidget {
  Otp({Key? key, this.title = "", this.verifyBy = "email"}) : super(key: key);
  final String title;
  String verifyBy;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  //controllers
  TextEditingController _verificationCodeController = TextEditingController();

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onTapResend() async {
    var resendCodeResponse = await AuthRepository().getResendCodeResponse();

    if (resendCodeResponse.result == false) {
      ToastComponent.showDialog(resendCodeResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);
    } else {
      ToastComponent.showDialog(resendCodeResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }

  onPressConfirm() async {
    var code = _verificationCodeController.text.toString();

    if (code == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context)!.enter_verification_code,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    }

    var confirmCodeResponse =
        await AuthRepository().getConfirmCodeResponse(code);

    if (confirmCodeResponse.result ?? false) {
      ToastComponent.showDialog(confirmCodeResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);
      AIZRoute.pushAndRemoveAll(context, Main());
    } else {
      ToastComponent.showDialog(confirmCodeResponse.message!,
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  width: 75,
                  height: 75,
                  child: Image.asset('assets/logo/app_logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "${AppLocalizations.of(context)!.verify_your} " +
                      (widget.verifyBy == "email"
                          ? AppLocalizations.of(context)!.email_account_ucf
                          : AppLocalizations.of(context)!.phone_number_ucf),
                  style: TextStyle(
                      color: MyTheme.app_accent_color,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                    width: _screen_width * (3 / 4),
                    child: widget.verifyBy == "email"
                        ? Text(
                            AppLocalizations.of(context)!
                                .enter_the_verification_code_that_sent_to_your_email_recently,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyTheme.dark_grey, fontSize: 14))
                        : Text(
                            AppLocalizations.of(context)!
                                .enter_the_verification_code_that_sent_to_your_phone_recently,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyTheme.dark_grey, fontSize: 14))),
              ),
              Container(
                width: _screen_width * (3 / 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 36,
                            child: TextField(
                              controller: _verificationCodeController,
                              autofocus: false,
                              decoration:
                                  InputDecorations.buildInputDecoration_1(
                                      hint_text: "A X B 4 J H"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: MyTheme.textfield_grey, width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0))),
                        child: Buttons(
                          width: MediaQuery.of(context).size.width,
                          color: MyTheme.app_accent_color,
                          shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          child: Text(
                            AppLocalizations.of(context)!.confirm_ucf,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            onPressConfirm();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: InkWell(
                  onTap: () {
                    onTapResend();
                  },
                  child: Text(AppLocalizations.of(context)!.resend_code_ucf,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: MyTheme.app_accent_color,
                          decoration: TextDecoration.underline,
                          fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
