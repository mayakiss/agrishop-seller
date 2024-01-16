import 'package:active_ecommerce_seller_app/custom/buttons.dart';
import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBox {
  static late BuildContext context;

  static warningShow(BuildContext context, List<dynamic>? warnings) {
    showDialog(
        context: context,
        builder: (context) {
          DialogBox.context = context;
          return AlertDialog(
            title: Text(LangText(context: context).getLocal()!.warning_ucf),
            content: Container(
              constraints: BoxConstraints(maxHeight: 60),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      warnings!.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text("● ${warnings[index]}"),
                          )),
                ),
              ),
            ),
            actions: [
              Buttons(
                color: MyTheme.medium_grey,
                padding: EdgeInsets.all(8),
                width: 40,
                height: 40,
                child: Text(
                  LangText(context: context).getLocal()!.close_all_capital,
                  style: TextStyle(color: MyTheme.white),
                ),
                onPressed: () {
                  pop();
                },
              )
            ],
          );
        });
  }

  static pop() {
    Navigator.pop(DialogBox.context);
  }
}
